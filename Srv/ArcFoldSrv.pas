unit ArcFoldSrv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.StrUtils;

type
  TfrmArcFoldSrv = class(TForm)
    Label1: TLabel;
    TimerStack: TTimer;
    procedure TimerStackTimer(Sender: TObject);
    procedure StartTask(ID:string);

    procedure ControlCopy(ToZip, FindCopy: string; kolCopy: integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmArcFoldSrv: TfrmArcFoldSrv;

implementation

uses
  unitDMSrv, sevenzip, Func;

{$R *.dfm}

// Контроль копий по указанной маске и количеству копий
procedure TfrmArcFoldSrv.ControlCopy(ToZip, FindCopy: string; kolCopy: integer);
var
  SearchRec: TSearchRec; // информация о файле или каталоге
  massiv: Array [1..30] of String;
  n, i: LongInt;

begin
  //удаляем старый архив если количество больше указанного
  n := 1;
  if FindFirst(FindCopy, faAnyFile, SearchRec) = 0 then
  repeat
     //SetLength(massiv, Length(massiv) + 1);
     massiv[n] := SearchRec.Name;
     inc(n);
  until FindNext(SearchRec) <> 0;

  if n-1>kolCopy then
  begin
    for i := 1 to n-KolCopy-1 do
      DeleteFile(ToZip + '\' + massiv[i])

  end;

  FindClose(SearchRec)  ;

end;


//запуск архивации
procedure TfrmArcFoldSrv.StartTask(ID: string);
var
  NameTask, PrefixName, PrefixNameDT, FromZip, ToZip, CryptWord, Log, SelDay, SelMonth: string ;
  TipTask, CompressZip, CryptZip, KolCopy, DayMonthTask: integer;
  NextStart, TimeTask: TDateTime;
  Arch: I7zOutArchive;
  strLog: string;
begin

  // Запуск задачи
  if DMS.qStartTask.Active then DMS.qStartTask.Close;
  //DM.qStartTask.Prepared;
  DMS.qStartTask.Parameters.ParamByName('ID').Value := ID;
  DMS.qStartTask.Open;

  //проверяем наличие пути
  if not DirectoryExists(DMS.qStartTaskFromZip.AsString) then
  begin
    LogZip(DMS.pathExe + 'Logs',
           DMS.pathExe + 'Logs\' + DMS.qStartTaskPrefixName.AsString + '.log',
           'Задача <' + DMS.qStartTaskNameTask.AsString + '> - путь архивации не найден, задача выключена' );

    //путь не найден выключаем задачу
    DMS.setOnTask.Parameters.ParamByName('ID').Value := ID;
    DMS.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DMS.setOnTask.Execute;

    exit;
  end;


  //указываем время запуска
  DMS.setLastStartTask.Parameters.ParamByName('ID').Value := ID;
  DMS.setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  DMS.setLastStartTask.Execute;


  //логирование !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := 'Задача запущена - ' + DateTimeToStr(Now());

  logZip(DMS.pathExe + 'Logs',
         DMS.pathExe + 'Logs\'+ DMS.qStartTaskPrefixName.AsString + '.log',
         strLog);


  //архивируем
  DMS.qStartTask.First;
  NameTask := DMS.qStartTaskNameTask.AsString;
  PrefixName := DMS.qStartTaskPrefixName.AsString;
  PrefixNameDT := DMS.qStartTaskPrefixName.AsString + ReplaceStr(DateTimeToStr(Now()), ':', '.');
  FromZip := DMS.qStartTaskFromZip.AsString;
  ToZip := DMS.qStartTaskToZip.AsString;
  CryptWord := DMS.qStartTaskCryptWord.AsString;
  CryptZip := DMS.qStartTaskCryptZip.AsInteger;
  CompressZip := DMS.qStartTaskCompressZip.AsInteger  ;
  KolCopy := DMS.qStartTaskKolCopy.AsInteger  ;
  Log := DMS.qStartTaskLogTask.AsString;

  TipTask := DMS.qStartTaskTipTask.AsInteger ;
  TimeTask := DMS.qStartTaskTimeTask.asDateTime;
  SelDay := DMS.qStartTaskSelDay.AsString;
  SelMonth := DMS.qStartTaskSelMonth.AsString;
  DayMonthTask := DMS.qStartTaskDayMonthTask.AsInteger  ;

  Arch := CreateOutArchive(CLSID_CFormat7Z);

  Arch.AddFiles(FromZip, '', '*', true);

  // compression level
  SetCompressionLevel(Arch, CompressZip);

  SevenZipSetCompressionMethod(Arch, m7BZip2);

  // set a password if necessary
  if CryptZip=1 then
    Arch.SetPassword(CryptWord)
  else
    Arch.SetPassword('');

  // Save to file
  Arch.SaveToFile(ToZip+'\'+PrefixNameDT+'.zip');



  //логирование !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := 'Задача выполнена - ' + DateTimeToStr(Now());
  logZip(DMS.pathExe + 'Logs',
         DMS.pathExe + 'Logs\' + DMS.qStartTaskPrefixName.AsString + '.log',
         strLog);
  strLog := '----------------------';
  logZip(DMS.pathExe + 'Logs',
         DMS.pathExe + 'Logs\' + DMS.qStartTaskPrefixName.AsString + '.log',
         strLog);

  // Контроль количества копий
  ControlCopy(ToZip, ToZip + '\' + PrefixName + '*.zip', kolCopy);
//
  //после выполнения задачи определяем следующий старт задачи
  NextStart := FindNextStart( TipTask,
                              TimeTask,
                              SelDay,
                              SelMonth,
                              DayMonthTask);

  DMS.setNextStartTask.Parameters.ParamByName('ID').Value := ID;
  DMS.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
  DMS.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
  DMS.setNextStartTask.execute;


  //после выполнения архивирования удаляем из стека задачу
  DMS.delExecStack.Parameters.ParamByName('ID').Value := ID;
  DMS.delExecStack.Execute;

end;

procedure TfrmArcFoldSrv.TimerStackTimer(Sender: TObject);
begin
  //перебираем задачи в стеке
  DMS.dbFindStack.Requery();
  if DMS.dbFindStack.RecordCount=0 then exit;
  DMS.dbFindStack.First;
  if DMS.dbFindStackOnExec.AsInteger=1 then
  begin
    //DM.setExecStack.Prepared;
    DMS.setExecStack.Parameters.ParamByName('ID').Value := DMS.dbFindStackID.AsString;
    DMS.setExecStack.Parameters.ParamByName('OnExec').Value := 0;
    DMS.setExecStack.Execute;


    StartTask(DMS.dbFindStackID.AsString);

  end;
end;

end.
