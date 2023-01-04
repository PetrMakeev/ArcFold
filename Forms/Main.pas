unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls, System.StrUtils, Vcl.ComCtrls,
  System.DateUtils, Data.Win.ADODB, System.ImageList, Vcl.ImgList;

type


  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    popRestore: TMenuItem;
    AppEvents: TApplicationEvents;
    popTask: TPopupMenu;
    popAdd: TMenuItem;
    popOn: TMenuItem;
    popDel: TMenuItem;
    popOff: TMenuItem;
    popEdit: TMenuItem;
    N1: TMenuItem;
    pgTask: TPageControl;
    tabTask: TTabSheet;
    DBGrid1: TDBGrid;
    tabStack: TTabSheet;
    memLog: TMemo;
    Label1: TLabel;
    DBGrid2: TDBGrid;
    TimerTask: TTimer;
    TimerStack: TTimer;
    ImageList: TImageList;
    popStack: TPopupMenu;
    popDelStack: TMenuItem;
    tmpMemo: TMemo;
    procedure popRestoreClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure popTaskPopup(Sender: TObject);
    procedure popAddClick(Sender: TObject);

    procedure AddSetting();

    procedure StartTask(ID:string);

    procedure SaveSetting(ID:string;
                           NameTask:string;
                           FromZip:string;
                           ToZip:string;
                           PrefixName:string;
                           FormatZip:integer;
                           CompressZip:integer;
                           CryptZip:integer;
                           CryptWord:string;
                           CryptFileName:integer;
                           TipTask:integer;
                           TimeTask:TDatetime;
                           DayMonthTask:word;
                           OnTask:integer;
                           SelDay:string;
                           SelMonth:string;
                           modeEdit:integer;
                           kolCopy:integer);

    function ExistRecStack():boolean;

    procedure ControlCopy(ToZip, FindCopy:string; kolCopy:integer );

    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure TimerTaskTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerStackTimer(Sender: TObject);
    procedure popStackPopup(Sender: TObject);
    procedure pgTaskChange(Sender: TObject);

    procedure viewLog(PrefixName:string);


  private
    FexecIDTask: string;
    procedure SetexecIDTask(const Value: string);
    { Private declarations }

  public
    { Public declarations }
    property execIDTask: string read FexecIDTask write SetexecIDTask;

  end;

var
  frmMain: TfrmMain;

implementation

uses
  SetTask, sevenzip, unitDM, Func;

{$R *.dfm}

procedure TfrmMain.SetexecIDTask(const Value: string);
begin
  FexecIDTask := Value;
end;




//-----------------------------------------------

procedure TfrmMain.ADDSetting();
begin
  // добавляем данные

end;

procedure TfrmMain.popEditClick(Sender: TObject);
begin
  // настраиваем редактирование
  frmSetTask.modeEdit := 'EDIT';
  frmSetTask.initEDIT(DM.dbSettingID.AsString,
                      DM.dbSettingNameTask.AsString,
                      DM.dbSettingFromZip.AsString,
                      DM.dbSettingToZip.AsString,
                      DM.dbSettingPrefixName.AsString,

                      DM.dbSettingFormatZip.AsInteger,
                      DM.dbSettingCompressZip.AsInteger,
                      DM.dbSettingCryptZip.AsInteger,
                      DM.dbSettingCryptWord.AsString,
                      DM.dbSettingCryptFileName.AsInteger,

                      DM.dbSettingTipTask.AsInteger,
                      DM.dbSettingTimeTask.AsDateTime,
                      DM.dbSettingDayMonthTask.AsInteger,
                      DM.dbSettingOnTask.AsInteger,
                      DM.dbSettingSelDay.AsString,
                      DM.dbSettingSelMonth.AsString,
                      DM.dbSettingKolCopy.AsInteger    )  ;

  frmSetTask.ShowModal ;

end;

procedure TfrmMain.AppEventsMinimize(Sender: TObject);
begin
  TrayIcon.visible:=true;
  //Убираем с панели задач
  ShowWindow(Handle,SW_HIDE);  // Скрываем программу
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем кнопку с TaskBar'а
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
  GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
end;


// Контроль копий по указанной маске и количеству копий
procedure TfrmMain.ControlCopy(ToZip, FindCopy: string; kolCopy: integer);
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

// проверка стека
function TfrmMain.ExistRecStack():boolean;
begin
   //проверяем наличие задач в стеке
   if DM.existStack.Active then DM.existStack.Close;
   DM.existStack.Open;
   if DM.existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

end;

procedure TfrmMain.pgTaskChange(Sender: TObject);
begin
  memLog.Clear;
  if pgTask.ActivePageIndex=0 then
  begin
    DM.dbSetting.AfterScroll(DM.dbSetting);
  end;


end;

procedure TfrmMain.popAddClick(Sender: TObject);
begin
  // добавляем задачу
  frmSetTask.modeEdit := 'ADD';
  frmSetTask.initADD();
  frmSetTask.ShowModal ;

end;

procedure TfrmMain.popDelClick(Sender: TObject);
begin

  if MessageDlg('Удалить задачу?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      DM.dbSetting.Delete;
    end;

end;

procedure TfrmMain.popOffClick(Sender: TObject);
begin
    //выключаем задачу
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;
    DM.dbSettingRefresh();
    
    //DM.dbSetting.Requery();

end;

procedure TfrmMain.popOnClick(Sender: TObject);
begin
    //выключаем задачу
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 1;
    DM.setOnTask.Execute;
    DM.dbSettingRefresh();
    
    //DM.dbSetting.Requery();

end;

procedure TfrmMain.popRestoreClick(Sender: TObject);
begin
  // восстанавливаем окно из трея
  TrayIcon.ShowBalloonHint;
  ShowWindow(Handle,SW_RESTORE);
  SetForegroundWindow(Handle);
  TrayIcon.Visible:=False;
end;

procedure TfrmMain.popStackPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (DM.dbStack.Eof) then
  begin
    popDelStack.Enabled := false;
   end
  else
  begin
    if DM.dbStackOnExec.AsInteger = 0 then
      popDelStack.Enabled := false
    else
      popDelStack.Enabled := true;
  end;

end;

procedure TfrmMain.popTaskPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (DM.dbSetting.Eof) then
  begin
    popAdd.Enabled := True;
    popEdit.Enabled := false;
    popDel.Enabled := false;
    popOn.Enabled := False;
    popOff.Enabled := false;
   end
  else
  begin
    popAdd.Enabled := True;
    popEdit.Enabled := true;
    popDel.Enabled := true;
    popOn.Enabled := true;
    popOff.Enabled := true;
  end;


  if DM.dbSettingOnTask.AsInteger = 1 then
  begin
    popOn.Visible := False;
    popOff.Visible := true;
  end
  else
  begin
    popOn.Visible := true;
    popOff.Visible := false;
  end;

end;


/// сохраняем настройки задачи
procedure TfrmMain.SaveSetting(ID, NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime; DayMonthTask: Word; OnTask: integer; SelDay,
  SelMonth: string; modeEdit:integer; KolCopy:integer);
var
  tmpDT:Tdatetime;
begin
  // Сохраняем даныные
  if modeEdit=0 then
  begin
    //выключаем задачу
    DM.addTask.Parameters.ParamByName('ID').Value := ID;
    DM.addTask.Parameters.ParamByName('NameTask').Value := NameTask;
    DM.addTask.Parameters.ParamByName('FromZip').Value := FromZip;
    DM.addTask.Parameters.ParamByName('ToZip').Value := ToZip;
    DM.addTask.Parameters.ParamByName('PrefixName').Value := PrefixName;

    DM.addTask.Parameters.ParamByName('FormatZip').Value := FormatZip;
    DM.addTask.Parameters.ParamByName('CompressZip').Value := CompressZip;
    DM.addTask.Parameters.ParamByName('CryptZip').Value := CryptZip;
    DM.addTask.Parameters.ParamByName('CryptWord').Value := CryptWord;
    DM.addTask.Parameters.ParamByName('CryptFileName').Value := CryptFileName;

    DM.addTask.Parameters.ParamByName('TipTask').Value := TipTask;
    DM.addTask.Parameters.ParamByName('TimeTask').Value := TimeTask;
    DM.addTask.Parameters.ParamByName('DayMonthTask').Value := DayMonthTask;
    DM.addTask.Parameters.ParamByName('OnTask').Value := OnTask;
    DM.addTask.Parameters.ParamByName('SelDay').Value := SelDay;
    DM.addTask.Parameters.ParamByName('SelMonth').Value := SelMonth;
    DM.addTask.Parameters.ParamByName('LogTask').Value := '';

    tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

    DM.addTask.Parameters.ParamByName('NextStart').Value := tmpDT;
    DM.addTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(tmpDT);
    DM.addTask.Parameters.ParamByName('LastStart').Value := 'Никогда' ;
    DM.addTask.Parameters.ParamByName('KolCopy').Value := KolCopy;
    DM.addTask.Execute;
    DM.dbSetting.Requery();
  end
  else
  begin
    DM.upTask.Parameters.ParamByName('ID').Value := ID;
    DM.upTask.Parameters.ParamByName('NameTask').Value := NameTask;
    DM.upTask.Parameters.ParamByName('FromZip').Value := FromZip;
    DM.upTask.Parameters.ParamByName('ToZip').Value := ToZip;
    DM.upTask.Parameters.ParamByName('PrefixName').Value := PrefixName;

    DM.upTask.Parameters.ParamByName('FormatZip').Value := FormatZip;
    DM.upTask.Parameters.ParamByName('CompressZip').Value := CompressZip;
    DM.upTask.Parameters.ParamByName('CryptZip').Value := CryptZip;
    DM.upTask.Parameters.ParamByName('CryptWord').Value := CryptWord;
    DM.upTask.Parameters.ParamByName('CryptFileName').Value := CryptFileName;

    DM.upTask.Parameters.ParamByName('TipTask').Value := TipTask;
    DM.upTask.Parameters.ParamByName('TimeTask').Value := TimeTask;
    DM.upTask.Parameters.ParamByName('DayMonthTask').Value := DayMonthTask;
    DM.upTask.Parameters.ParamByName('OnTask').Value := OnTask;
    DM.upTask.Parameters.ParamByName('SelDay').Value := SelDay;
    DM.upTask.Parameters.ParamByName('SelMonth').Value := SelMonth;
    DM.upTask.Parameters.ParamByName('LogTask').Value := '';

    tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

    DM.upTask.Parameters.ParamByName('NextStart').Value := tmpDT;
    DM.upTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(tmpDT);
    DM.upTask.Parameters.ParamByName('LastStart').Value := tmpDT ;
    DM.upTask.Parameters.ParamByName('KolCopy').Value := KolCopy;
    DM.upTask.Execute;
    DM.dbSettingRefresh();
    //DM.dbSetting.Requery();
  end;
end;



// Запуск задачи - архивирование
procedure TfrmMain.StartTask(ID:string);
var
  NameTask, PrefixName, PrefixNameDT, FromZip, ToZip, CryptWord, Log, SelDay, SelMonth: string ;
  TipTask, CompressZip, CryptZip, KolCopy, DayMonthTask: integer;
  NextStart, TimeTask: TDateTime;
  Arch: I7zOutArchive;
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
    DM.dbSettingRefresh();
    //DM.dbSetting.Requery();
    exit;
  end;


  //указываем время запуска
  DM.setLastStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  DM.setLastStartTask.Execute;
  DM.dbSettingRefresh();
  //DM.dbSetting.Requery();


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
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
         strLog);
  strLog := '----------------------';
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
         strLog);

  // Контроль количества копий
  frmMain.ControlCopy(ToZip, ToZip + '\' + PrefixName + '*.zip', kolCopy);

//  //после выполнения задачи определяем следующий старт задачи
//  NextStart := FindNextStart( TipTask,
//                              TimeTask,
//                              SelDay,
//                              SelMonth,
//                              DayMonthTask);
//
//  DM.setNextStartTask.Parameters.ParamByName('ID').Value := ID;
//  DM.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
//  DM.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
//  DM.setNextStartTask.execute;

  //обновляем грид планировщика
  DM.dbSettingRefresh();


  //после выполнения архивирования удаляем из стека задачу
  DM.delExecStack.Parameters.ParamByName('ID').Value := ID;
  DM.delExecStack.Execute;
  DM.dbStack.Requery();
  DBGrid2.Refresh();



end;



// обрабатываем таймер очереди задач, запускаем задачи в стеке поочередно
procedure TfrmMain.TimerStackTimer(Sender: TObject);
begin
//  //перебираем задачи в стеке
//  DM.dbFindStack.Requery();
//  if DM.dbFindStack.RecordCount=0 then exit;
//  DM.dbFindStack.First;
//  if DM.dbFindStackOnExec.AsInteger=1 then
//  begin
//    //DM.setExecStack.Prepared;
//    DM.setExecStack.Parameters.ParamByName('ID').Value := DM.dbFindStackID.AsString;
//    DM.setExecStack.Parameters.ParamByName('OnExec').Value := 0;
//    DM.setExecStack.Execute;
//    DM.dbStack.Requery() ;
//
//    DBGrid1.Refresh;
//
//    StartTask(DM.dbFindStackID.AsString);
//
//  end;

    DM.dbStack.Requery() ;


end;


/// обрабатываем таймер планировщика задач, ищем задачи на выполнение и отправляем в стек
procedure TfrmMain.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  BM: TBookmark;
  NextStart: TDateTime;
begin
  //обновляем грид с задачами
  DM.dbSettingRefresh;

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
        if Trim(DM.ExistStackID.AsString) = Trim(DM.dbFindTaskID.AsString) then
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
    DM.dbStack.Requery() ;

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
    DM.dbSettingRefresh();

  end;

end;


procedure TfrmMain.viewLog(PrefixName:string) ;
var
  FileLog:string;
begin
 ///
  FileLog := DM.pathExe +'Logs\' + PrefixName + '.log';
  if DirectoryExists(DM.pathExe+'Logs') and
     FileExists(FileLog) then
    memLog.Lines.LoadFromFile(FileLog);

end;

//создаем и настраиваем форму
procedure TfrmMain.FormCreate(Sender: TObject);
begin


  //включаем таймеры
  //timerTask.Enabled := true;
  timerStack.Enabled := true;

  // отмечаем создание формы в DM
  DM.startMain := true;
  
end;





end.


