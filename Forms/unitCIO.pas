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
  // ������� ���� ��� ��������������� ������������ ������
  CreatePipe(StdOutPipeRead, // ���������� ������
    StdOutPipeWrite, // ���������� ������
    @SA, // ��������� ������������
    0 // ���������� ���� �������� ��� ����� - 0 �� ���������
    );
  try
    // ������� �������� �������, ��������� StdOutPipeWrite � �������� ������������ ������,
    // � ��� �� ���������, ����� �� �� ����������� �� ������.
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // ����������� ���� �� ��������������
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    // ��������� ���������� �� ��������� ������
    WorkDir := ExtractFilePath(CommandLine);
    WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil, PChar(WorkDir), SI, PI);

    // ������, ����� ���������� �������, ��� ������������ ��������� ������.
    // ��� �� �����, ����� ��������� ��������� ������ ��� ������.
    CloseHandle(StdOutPipeWrite);
    // ���� ������� ����� ���� ������, �� ����������, ��� ��� �����
    if not WasOK then
      raise Exception.Create('Could not execute command line!')
    else
    try
        // �������� ���� ����� �� ��� ���, ���� DOS-���������� �� ����� ���������
      Line := '';
      repeat
          // ������ ���� �������� (����� ��������� �������� ������� � �������� ������)
        WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

          // ���� �� ���-������ ��� ��� ������?
        if BytesRead > 0 then
        begin
            // ��������� ����� PChar-��
          Buffer[BytesRead] := #0;
            // ��������� ����� � ����� �����
          Line := Line + Buffer;
        end;
      until not WasOK or (BytesRead = 0);
        // ����, ���� ���������� ���������� ����������
      WaitForSingleObject(PI.hProcess, INFINITE);
    finally
        // ��������� ��� ���������� �����������
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;
  finally
    result := Line;
    CloseHandle(StdOutPipeRead);
  end;
end;

end.