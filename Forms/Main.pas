unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls, System.StrUtils, Vcl.ComCtrls,
  System.DateUtils, Data.Win.ADODB;

type

  TOneMoreThread=class(tthread)
  protected
    procedure execute; override;
  end;

  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    TrayIcon: TTrayIcon;
    popTray: TPopupMenu;
    popRestore: TMenuItem;
    AppEvents: TApplicationEvents;
    dsSetting: TDataSource;
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
    dsStack: TDataSource;
    TimerTask: TTimer;
    Button1: TButton;
    ADOConn: TADOConnection;
    dbSetting: TADOTable;
    dbSettingNameTask: TWideStringField;
    dbSettingFromZip: TWideStringField;
    dbSettingToZip: TWideStringField;
    dbSettingPrefixName: TWideStringField;
    dbSettingFormatZip: TSmallintField;
    dbSettingCompressZip: TSmallintField;
    dbSettingCryptZip: TSmallintField;
    dbSettingCryptWord: TWideStringField;
    dbSettingCryptFileName: TSmallintField;
    dbSettingTipTask: TSmallintField;
    dbSettingTimeTask: TDateTimeField;
    dbSettingDayMonthTask: TSmallintField;
    dbSettingOnTask: TSmallintField;
    dbSettingSelDay: TWideStringField;
    dbSettingSelMonth: TWideStringField;
    dbSettingLogTask: TWideMemoField;
    dbSettingNextStart: TDateTimeField;
    dbSettingLastStart: TWideStringField;
    dbSettingNamtTaskV: TStringField;
    dbSettingOnTaskV: TStringField;
    dbSettingNextStartStr: TWideStringField;
    dbSettingKeyStr: TAutoIncField;
    dbSettingID: TWideStringField;
    dbFindTask: TADOQuery;
    dbFindTaskID: TWideStringField;
    dbFindTaskNameTask: TWideStringField;
    dbFindTaskNextStart: TDateTimeField;
    clearStack: TADOCommand;
    existStack: TADOQuery;
    existStackKeyStr: TAutoIncField;
    existStackID: TWideStringField;
    existStackNameTask: TWideStringField;
    existStackStartTime: TDateTimeField;
    existStackonExec: TWideStringField;
    dbFindStack: TADOQuery;
    dbFindStackID: TWideStringField;
    dbFindStackNameTask: TWideStringField;
    dbFindStackStartTime: TDateTimeField;
    dbFindStackonExec: TWideStringField;
    qStartTask: TADOQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    DateTimeField1: TDateTimeField;
    qStartTaskKeyStr: TAutoIncField;
    qStartTaskFromZip: TWideStringField;
    qStartTaskToZip: TWideStringField;
    qStartTaskPrefixName: TWideStringField;
    qStartTaskFormatZip: TSmallintField;
    qStartTaskCompressZip: TSmallintField;
    qStartTaskCryptZip: TSmallintField;
    qStartTaskCryptWord: TWideStringField;
    qStartTaskCryptFileName: TSmallintField;
    qStartTaskTipTask: TSmallintField;
    qStartTaskTimeTask: TDateTimeField;
    qStartTaskDayMonthTask: TSmallintField;
    qStartTaskOnTask: TSmallintField;
    qStartTaskSelDay: TWideStringField;
    qStartTaskSelMonth: TWideStringField;
    qStartTaskLogTask: TWideMemoField;
    qStartTaskLastStart: TWideStringField;
    qStartTaskNextStartStr: TWideStringField;
    delExecTask: TADOCommand;
    dbStack: TADOQuery;
    dbStackKeyStr: TAutoIncField;
    dbStackID: TWideStringField;
    dbStackNameTask: TWideStringField;
    dbStackStartTime: TDateTimeField;
    dbStackonExec: TWideStringField;
    addExecTask: TADOCommand;
    procedure popRestoreClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure popTaskPopup(Sender: TObject);
    procedure popAddClick(Sender: TObject);

    procedure AddSetting();

    procedure StartTask(ID:string);

    function FindNextStart(TipTask:integer;
                          TimeTask:TDateTime;
                          SelDay:string;
                          SelMonth:string;
                          DayMonthTask:word
                          ):TDateTime;

    procedure SaveSetting(NameTask:string;
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
                       modeEdit:integer);

    function ExistRecStack():boolean;

    procedure TaskToStack(ID:string;
                          NameTask:string;
                          StartTime:TDatetime);

    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure dbSettingCalcFields(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure TimerTaskTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);


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
  SetTask, sevenzip;

{$R *.dfm}

procedure TfrmMain.SetexecIDTask(const Value: string);
begin
  FexecIDTask := Value;
end;


//-----------------------------------------------

procedure TfrmMain.ADDSetting();
begin
  // добавляем данные
  dbStack.Append;
  dbStack.FieldByName('ID').AsString := DateTimeToStr(Now());
  dbStack.FieldByName('NameTask').AsString := 'Название задачи';
  dbStack.FieldByName('StartTime').AsDateTime := Now();
  dbStack.FieldByName('OnExec').AsString := 'Ожидает';

  dbStack.Post;

end;

procedure TfrmMain.popEditClick(Sender: TObject);
begin
  // настраиваем редактирование
  frmSetTask.modeEdit := 'EDIT';
  frmSetTask.initEDIT(dbSettingNameTask.AsString,
                      dbSettingFromZip.AsString,
                      dbSettingToZip.AsString,
                      dbSettingPrefixName.AsString,

                      dbSettingFormatZip.AsInteger,
                      dbSettingCompressZip.AsInteger,
                      dbSettingCryptZip.AsInteger,
                      dbSettingCryptWord.AsString,
                      dbSettingCryptFileName.AsInteger,

                      dbSettingTipTask.AsInteger,
                      dbSettingTimeTask.AsDateTime,
                      dbSettingDayMonthTask.AsInteger,
                      dbSettingOnTask.AsInteger,
                      dbSettingSelDay.AsString,
                      dbSettingSelMonth.AsString    )  ;

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



procedure TfrmMain.Button1Click(Sender: TObject);
begin
// выполняем
    TaskToStack(dbSettingID.AsString, dbSettingNameTask.AsString, dbSettingNextStart.AsDateTime);
end;




procedure TfrmMain.dbSettingCalcFields(DataSet: TDataSet);
begin
  // готовим вычисляемые поля
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger = 1, '+', ' ')  ;

end;


function TfrmMain.ExistRecStack():boolean;
begin
   //проверяем наличие задач в стеке
   if existStack.Active then existStack.Close;
   existStack.Open;
   if existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

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
      dbSetting.Delete;
    end;

end;

procedure TfrmMain.popOffClick(Sender: TObject);
begin
  dbSetting.Edit;
  dbSetting.FieldByName('OnTask').AsInteger := 0;
  dbSetting.Post;

end;

procedure TfrmMain.popOnClick(Sender: TObject);
begin
  dbSetting.Edit;
  dbSetting.FieldByName('OnTask').AsInteger := 1;
  dbSetting.Post;

end;

procedure TfrmMain.popRestoreClick(Sender: TObject);
begin
  // восстанавливаем окно из трея
  TrayIcon.ShowBalloonHint;
  ShowWindow(Handle,SW_RESTORE);
  SetForegroundWindow(Handle);
  TrayIcon.Visible:=False;
end;

procedure TfrmMain.popTaskPopup(Sender: TObject);
begin
  //настраиваем popTask
  if (dbSetting.Eof) then
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


  if dbSettingOnTask.AsInteger = 1 then
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

procedure TfrmMain.SaveSetting(NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime; DayMonthTask: Word; OnTask: integer; SelDay,
  SelMonth: string; modeEdit:integer);
var
  tmpDT:Tdatetime;
begin
  // Сохраняем даныные
  if modeEdit=0 then
    dbSetting.Append
  else
    dbSetting.Edit;
  dbSetting.FieldByName('ID').AsString := DateTimeToStr(Now());
  dbSetting.FieldByName('NameTask').AsString := NameTask;
  dbSetting.FieldByName('FromZip').AsString := FromZip;
  dbSetting.FieldByName('ToZip').AsString := ToZip;
  dbSetting.FieldByName('PrefixName').AsString := PrefixName;

  dbSetting.FieldByName('FormatZip').AsInteger := FormatZip;
  dbSetting.FieldByName('CompressZip').AsInteger := CompressZip;
  dbSetting.FieldByName('CryptZip').AsInteger := CryptZip;
  dbSetting.FieldByName('CryptWord').AsString := CryptWord;
  dbSetting.FieldByName('CryptFileName').AsInteger := CryptFileName;

  dbSetting.FieldByName('TipTask').AsInteger := TipTask;
  dbSetting.FieldByName('TimeTask').AsDateTime := TimeTask;
  dbSetting.FieldByName('DayMonthTask').AsLargeInt := DayMonthTask;
  dbSetting.FieldByName('OnTask').AsInteger := OnTask;
  dbSetting.FieldByName('SelDay').AsString := SelDay;
  dbSetting.FieldByName('SelMonth').AsString := SelMonth;

  tmpDT := FindNextStart(TipTask, TimeTask, SelDay, SelMonth, DayMonthTask)  ;

  dbSetting.FieldByName('NextStart').AsDateTime := tmpDT; //!!!!!!!!!!!!!
  dbSetting.FieldByName('NextStartStr').AsString := DateTimeToStr(tmpDT);
  if modeEdit=0 then
    dbSetting.FieldByName('LastStart').AsString := 'Никогда' ;
  dbSetting.Post;
end;



// Запуск задачи в отдельном потоке
procedure TfrmMain.StartTask(ID:string);
var
  oneMoreThread: TOneMoreThread;
begin
  // Запуск задачи
  if qStartTask.Active then qStartTask.Close;
  qStartTask.Prepared;
  qStartTask.Parameters.ParamByName('ID').Value := ID;
  qStartTask.Open;

  //Запускаем архивирование в отдельном потоке
  execIDTask := ID;
  //oneMoreThread := TOneMoreThread.Create(false); // << false означает авто запуск потока
  //oneMoreThread.FreeOnTerminate := true; // << Уничтожение после выполнения

  memLog.Lines.Add('start');

  sleep(1000) ;

  memLog.Lines.Add('end');

  //после выполнения архивирования удаляем из стека задачу
  delExecTask.Parameters.ParamByName('ID').Value := ID;
  delExecTask.Execute;
  dbStack.Requery();


end;

// перед добавлением в стек проверяем задачу на дублирование
// если задач в стеке небыло вызываем запуск задачи
procedure TfrmMain.TaskToStack(ID:string; NameTask:string; StartTime:TDatetime);
var
  flFind: boolean;
  statusStr:string;
begin
  flFind := ExistRecStack();
  //проверяем наличие в стеке задач
  if flFind then
  begin
    // проверяем на повторый запуск                     !!!!!!!!!!!!!!!!!!
    ExistStack.First;
    while not ExistStack.Eof do
    begin
      if Trim(ExistStackID.AsString) = Trim(ID) then
      begin
        //задача уже есть в стеке
        exit;
      end;
      ExistStack.Next;
    end;

  end;

  memLog.Lines.Add('добавляем задачу -' + NameTask + ' - ' + DateTimeToStr(StartTime));


  if not flFind then
    //стек пуст запускаем задачу
    statusStr := 'Выполняется'
  else
    statusStr := 'В очереди...';

  addExecTask.Prepared;
  addExecTask.Parameters.ParamByName('ID').Value := ID;

  addExecTask.Parameters.ParamByName('NameTask').Value := NameTask;

  addExecTask.Parameters.ParamByName('StartTime').Value := StartTime;

  addExecTask.Parameters.ParamByName('onExec').Value := statusStr ;

  addExecTask.Execute;
  dbStack.Requery() ;

  // запускаем задачу если стек был пуст
  if not flFind then
    StartTask(ID);

end;


// обрабатываем таймер задачи, ищем задачи на выполнение и отправляем в стек
procedure TfrmMain.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
begin
  //перебираем задачи попадающие в запрос для стека
  dbFindTask.Requery();
  if dbFindTask.RecordCount=0 then exit;

  dbFindTask.First;
  while not dbFindTask.Eof do
  begin
    //добавляем в стек задачу
    taskToStack(dbFindTaskID.AsString, dbFindTaskNameTask.AsString, dbFindTaskNextStart.AsDateTime);
    dbFindTask.Next;
  end;

end;


//Определяем дату и время следующего старта задачи
function TfrmMain.FindNextStart(TipTask: integer; TimeTask: TDateTime; SelDay,
  SelMonth: string; DayMonthTask: word): TDateTime;
var
  tmpHour, tmpMinute, tmpSecond, tmpMSec: Word;
  tmpDateTime, DateTimeStart, currDateTime:TDateTime;
  currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec: Word;
  currDayWeek, currMonthYear: word;
  I: Word;
begin

  //определяем время следующего старта задачи
  DecodeTime(TimeTask, tmpHour, tmpMinute, tmpSecond, tmpMSec);

  //фиксируем текущие дату и время
  DecodeDateTime(Now(), currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);
  currDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, 0, 0);
  DateTimeStart := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);

  //ежедневно
  if TipTask=0 then
  begin
    tmpDateTime := EncodeDateTime(currYear, currMonth, currDay, tmpHour, tmpMinute, 0, 0);
    //проверяем прошло время запуска сегодня или нет
    if currDateTime > tmpDateTime then
      tmpDateTime := EncodeDateTime(currYear, CurrMonth, CurrDay + 1, tmpHour, tmpMinute, 0, 0);

    DateTimeStart := tmpDateTime;  
  end;

  //Еженедельно
  if TipTask=1 then
  begin

    // определяем текущий день недели
    currDayWeek := DayOfTheWeek(Now());

    // принимаем точку поиска за дату и время позже на 14 дней
    DateTimeStart := IncDay(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 14-CurrDayWeek);

    //перебираем дни недели для определения дня старта задачи
    for I := 1 to 7 do
    begin

      // проверить есть ли на данный день недели старт задачи
      if midStr(SelDay, I, 1) = '1' then
      begin
        //формируем на день недели дату и время старта
        tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I );
 
        // если старт задачи  прошел то определяем его на следующую неделю
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);

        // если найденное tmpDateTime позже currDateTime и DateTimeStart раньше определенного как самое крайнее сохраняем его
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;

    end;

   end;

   //ежемесячно
   if TipTask=2 then
   begin

    // определяем текущий месяц
    currMonthYear := MonthOfTheYear(Now());

    // принимаем точку поиска за дату и время позже на 24 месяцев
    DateTimeStart := IncMonth(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 24-currMonthYear);

    // перебираем месяцы для определения дня старта задачи
    for I := 1 to 12 do
    begin
      // проверить есть ли на данный день недели старт задачи
      if midStr(SelMonth, I, 1) = '1' then
      begin

        //формируем на день недели дату и время старта
        tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 0); // -currMonthYear + I );

        // если старт задачи  прошел то определяем его на следующий месяц
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 12); //-currMonthYear + I + 12);

        // если найденное tmpDateTime позже currDateTime и DateTimeStart раньше определенного как самое крайнее сохраняем его
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;
    end;

   end;


  Result := DateTimeStart;

end;

//создаем и настраиваем форму
procedure TfrmMain.FormCreate(Sender: TObject);
var
  pathExe:string;
begin
  pathExe := ExtractFilePath(Application.ExeName);
  if AdoConn.Connected then AdoConn.Close;

  AdoConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + pathExe + 'arcFold.mdb;Persist Security Info=False;';
  AdoConn.Connected := true;
  if not dbSetting.Active then dbSetting.Active := true;
  clearStack.Execute ;
  if not dbStack.Active then dbStack.Active := true;
  if not dbFindTask.Active then dbFindTask.Active := true;
  if not dbFindStack.Active then dbFindStack.Active := true;
end;



{ TOneMoreThread }

procedure TOneMoreThread.execute;
var
  PrefixName, FromZip, ToZip, CryptWord: string ;
  CompressZip, CryptZip: integer;
  Arch: I7zOutArchive;
begin
  inherited;

    //архивируем в отдельном потоке


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
  Arch.SaveToFile(ToZip);

end;



end.
