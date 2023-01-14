unit consoleoutput;

interface

uses
  Controls, Windows, SysUtils, Forms;

function GetDosOutput(const CommandLine: string): string;

implementation

function GetDosOutput(const CommandLine: string): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of Char;
  BytesRead: Cardinal;
  WorkDir, Line: string;
begin
  Application.ProcessMessages;
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  // создаем пайп дл€ перенаправлени€ стандартного вывода
  CreatePipe(StdOutPipeRead, // дескриптор чтени€
    StdOutPipeWrite, // дескриптор записи
    @SA, // аттрибуты безопасности
    0 // количество байт прин€тых дл€ пайпа - 0 по умолчанию
    );
  try
    // —оздаем дочерний процесс, использу€ StdOutPipeWrite в качестве стандартного вывода,
    // а так же провер€ем, чтобы он не показывалс€ на экране.
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // стандартный ввод не перенаправл€ем
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    // «апускаем компил€тор из командной строки
    WorkDir := ExtractFilePath(CommandLine);
    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil, PChar(WorkDir), SI, PI);

    // “еперь, когда дескриптор получен, дл€ безопасности закрываем запись.
    // Ќам не нужно, чтобы произошло случайное чтение или запись.
    CloseHandle(StdOutPipeWrite);
    // если процесс может быть создан, то дескриптор, это его вывод
    if not WasOK then
      raise Exception.Create('Could not execute command line!')
    else
    try
        // получаем весь вывод до тех пор, пока DOS-приложение не будет завершено
      Line := '';
      repeat
          // читаем блок символов (могут содержать возвраты каретки и переводы строки)
        WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

          // есть ли что-нибудь еще дл€ чтени€?
        if BytesRead > 0 then
        begin
            // завершаем буфер PChar-ом
          Buffer[BytesRead] := #0;
            // добавл€ем буфер в общий вывод
          Line := Line + Buffer;
        end;
      until not WasOK or (BytesRead = 0);
        // ждем, пока завершитс€ консольное приложение
      WaitForSingleObject(PI.hProcess, INFINITE);
    finally
        // «акрываем все оставшиес€ дескрипторы
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;
  finally
    result := Line;
    CloseHandle(StdOutPipeRead);
  end;
end;

end.