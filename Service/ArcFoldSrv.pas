unit ArcFoldSrv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls, Data.DB, System.StrUtils;

type
  TService1 = class(TService)
    TimerTask: TTimer;
    TimerStack: TTimer;
    procedure TimerTaskTimer(Sender: TObject);

    function ExistRecStack():boolean;

    procedure TimerStackTimer(Sender: TObject);

    procedure StartTask(ID: string);

    procedure ControlCopy(ToZip, FindCopy: string; kolCopy: integer);

  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Service1: TService1;

implementation

uses
  UnitDM, Func;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

// Контроль копий по указанной маске и количеству копий
procedure TService1.ControlCopy(ToZip, FindCopy: string; kolCopy: integer);
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

function TService1.ExistRecStack: boolean;
begin
   //проверяем наличие задач в стеке
   if DM.existStack.Active then DM.existStack.Close;
   DM.existStack.Open;
   if DM.existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

//запуск архивации
procedure TService1.StartTask(ID: string);
var
  NameTask, PrefixName, PrefixNameDT, FromZip, ToZip, CryptWord, Log, SelDay, SelMonth: string ;
  TipTask, CompressZip, CryptZip, KolCopy, DayMonthTask: integer;
  NextStart, TimeTask: TDateTime;
  strLog: string;
begin

  // Запуск задачи
  if DM.qStartTask.Active then DM.qStartTask.Close;
  //DM.qStartTask.Prepared;
  DM.qStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.qStartTask.Open;

  //проверяем наличие пути
  if not DirectoryExists(DM.qStartTaskFromZip.AsString) then
  begin
    LogZip(DM.pathExe + 'Logs',
           DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
           'Задача <' + DM.qStartTaskNameTask.AsString + '> - путь архивации не найден, задача выключена' );

    //путь не найден выключаем задачу
    DM.setOnTask.Parameters.ParamByName('ID').Value := ID;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;

    exit;
  end;


  //указываем время запуска
  DM.setLastStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  DM.setLastStartTask.Execute;


  //логирование !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := 'Задача запущена - ' + DateTimeToStr(Now());

  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\'+ DM.qStartTaskPrefixName.AsString + '.log',
         strLog);


  //архивируем
  DM.qStartTask.First;
  NameTask := DM.qStartTaskNameTask.AsString;
  PrefixName := DM.qStartTaskPrefixName.AsString;
  PrefixNameDT := DM.qStartTaskPrefixName.AsString + ReplaceStr(DateTimeToStr(Now()), ':', '.');
  FromZip := DM.qStartTaskFromZip.AsString;
  ToZip := DM.qStartTaskToZip.AsString;
  CryptWord := DM.qStartTaskCryptWord.AsString;
  CryptZip := DM.qStartTaskCryptZip.AsInteger;
  CompressZip := DM.qStartTaskCompressZip.AsInteger  ;
  KolCopy := DM.qStartTaskKolCopy.AsInteger  ;
  Log := DM.qStartTaskLogTask.AsString;

  TipTask := DM.qStartTaskTipTask.AsInteger ;
  TimeTask := DM.qStartTaskTimeTask.asDateTime;
  SelDay := DM.qStartTaskSelDay.AsString;
  SelMonth := DM.qStartTaskSelMonth.AsString;
  DayMonthTask := DM.qStartTaskDayMonthTask.AsInteger  ;

  //Arch := CreateOutArchive(CLSID_CFormat7Z);

  //Arch.AddFiles(FromZip, '', '*', true);

  // compression level
  //SetCompressionLevel(Arch, CompressZip);

  //SevenZipSetCompressionMethod(Arch, m7BZip2);

  // set a password if necessary
  //if CryptZip=1 then
  //  Arch.SetPassword(CryptWord)
  //else
  //  Arch.SetPassword('');

  // Save to file
  //Arch.SaveToFile(ToZip+'\'+PrefixNameDT+'.zip');



  //логирование !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := 'Задача выполнена - ' + DateTimeToStr(Now());
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
         strLog);
  strLog := '----------------------';
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
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

  DM.setNextStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
  DM.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
  DM.setNextStartTask.execute;


  //после выполнения архивирования удаляем из стека задачу
  DM.delExecStack.Parameters.ParamByName('ID').Value := ID;
  DM.delExecStack.Execute;

end;

//контроль стека задач на выполнение и запуск задач по очереди
procedure TService1.TimerStackTimer(Sender: TObject);
begin
  //перебираем задачи в стеке
  DM.dbFindStack.Requery();
  if DM.dbFindStack.RecordCount=0 then exit;
  DM.dbFindStack.First;
  if DM.dbFindStackOnExec.AsInteger=1 then
  begin
    //DM.setExecStack.Prepared;
    DM.setExecStack.Parameters.ParamByName('ID').Value := DM.dbFindStackID.AsString;
    DM.setExecStack.Parameters.ParamByName('OnExec').Value := 0;
    DM.setExecStack.Execute;


    StartTask(DM.dbFindStackID.AsString);

  end;
end;

//контроль заданий и постановка в стек задач на выполнение
procedure TService1.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  BM: TBookmark;
  NextStart: TDateTime;
begin

  //перебираем задачи попадающие в запрос для стека
  DM.dbFindTask.Requery();
  if DM.dbFindTask.RecordCount=0 then exit;

  DM.dbFindTask.First;
  while not DM.dbFindTask.Eof do
  begin
    //добавляем в стек задачу

    flFind := ExistRecStack();
    //проверяем наличие в стеке задач
    if flFind then
    begin
      // проверяем на повторый запуск                     !!!!!!!!!!!!!!!!!!
      DM.existStack.Requery();
      DM.ExistStack.First;
      while not DM.ExistStack.Eof do
      begin
        if (Trim(DM.ExistStackID.AsString) = Trim(DM.dbFindTaskID.AsString))   then
        begin
          //задача уже есть в стеке
          exit;
        end;
        DM.ExistStack.Next;
      end;

    end;

    //Добавляем задачу в стек
    DM.addExecTask.Prepared;
    DM.addExecTask.Parameters.ParamByName('ID').Value := DM.dbFindTaskID.AsString;
    DM.addExecTask.Parameters.ParamByName('NameTask').Value := DM.dbFindTaskNameTask.AsString;
    DM.addExecTask.Parameters.ParamByName('StartTime').Value := DM.dbFindTaskNextStart.AsDateTime;
    DM.addExecTask.Parameters.ParamByName('onExec').Value := 1 ;   // статус В ожидании...
    DM.addExecTask.Execute;


    DM.dbFindTask.Next;

    //пересчитываем следующий запуск

    //после выполнения задачи определяем следующий старт задачи
    NextStart := FindNextStart( DM.dbFindTaskTipTask.asInteger,
                                DM.dbFindTaskTimeTask.asDateTime,
                                DM.dbFindTaskSelDay.asString,
                                DM.dbFindTaskSelMonth.asString,
                                DM.dbFindTaskDayMonthTask.asInteger);

    DM.setNextStartTask.Parameters.ParamByName('ID').Value := DM.dbFindTaskID.AsString;
    DM.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
    DM.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
    DM.setNextStartTask.execute;


  end;

end;



end.
