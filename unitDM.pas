unit unitDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Forms,
  system.StrUtils;

type
  TDM = class(TDataModule)
    ADOConn: TADOConnection;
    dbSetting: TADOQuery;
    dbSettingKeyStr: TAutoIncField;
    dbSettingID: TWideStringField;
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
    dbSettingNextStartStr: TWideStringField;
    dbSettingkolCopy: TSmallintField;
    dbSettingOnTaskV: TStringField;
    dsSetting: TDataSource;
    setOnTask: TADOCommand;
    addTask: TADOCommand;
    upTask: TADOCommand;
    setLastStartTask: TADOCommand;
    dbFindTask: TADOQuery;
    dbFindTaskID: TWideStringField;
    dbFindTaskNameTask: TWideStringField;
    dbFindTaskNextStart: TDateTimeField;
    qStartTask: TADOQuery;
    qStartTaskKeyStr: TAutoIncField;
    qStartTaskID: TWideStringField;
    qStartTaskNameTask: TWideStringField;
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
    qStartTaskNextStart: TDateTimeField;
    qStartTaskLastStart: TWideStringField;
    qStartTaskNextStartStr: TWideStringField;
    qStartTaskkolCopy: TSmallintField;
    dbStack: TADOQuery;
    dbStackKeyStr: TAutoIncField;
    dbStackID: TWideStringField;
    dbStackNameTask: TWideStringField;
    dbStackStartTime: TDateTimeField;
    dbStackonExec: TSmallintField;
    dbStackOnExecV: TStringField;
    dsStack: TDataSource;
    dbFindStack: TADOQuery;
    dbFindStackID: TWideStringField;
    dbFindStackNameTask: TWideStringField;
    dbFindStackStartTime: TDateTimeField;
    dbFindStackonExec: TSmallintField;
    existStack: TADOQuery;
    existStackKeyStr: TAutoIncField;
    existStackID: TWideStringField;
    existStackNameTask: TWideStringField;
    existStackStartTime: TDateTimeField;
    existStackonExec: TSmallintField;
    addExecTask: TADOCommand;
    setExecStack: TADOCommand;
    clearStack: TADOCommand;
    delExecStack: TADOCommand;
    setNextStartTask: TADOCommand;
    qTask: TADOQuery;
    qTaskTipTask: TSmallintField;
    qTaskTimeTask: TDateTimeField;
    qTaskDayMonthTask: TSmallintField;
    qTaskSelDay: TWideStringField;
    qTaskSelMonth: TWideStringField;
    qTaskID: TWideStringField;
    dbFindTaskTipTask: TSmallintField;
    dbFindTaskTimeTask: TDateTimeField;
    dbFindTaskSelDay: TWideStringField;
    dbFindTaskSelMonth: TWideStringField;
    dbFindTaskDayMonthTask: TSmallintField;
    procedure dbSettingCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dbStackCalcFields(DataSet: TDataSet);
    procedure dbSettingAfterScroll(DataSet: TDataSet);

    procedure dbSettingRefresh();

  private
    FpathExe: string;
    FstartMain: boolean;
    procedure SetpathExe(const Value: string);
    procedure SetstartMain(const Value: boolean);
    { Private declarations }
  public
    { Public declarations }

    property pathExe:string read FpathExe write SetpathExe;
    property startMain:boolean read FstartMain write SetstartMain;

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Main, Func;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  NextStart:TDateTime;
  TipTask: integer;
  TimeTask: TDateTime;
  SelDay, SelMonth :string;
  DayMonthTask :Word;

begin

  DM.startMain := false;

  DM.pathExe := ExtractFilePath(Application.ExeName);

  if AdoConn.Connected then  AdoConn.Close;

  ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + pathExe + 'arcFold.mdb;Persist Security Info=False;';
  ADOConn.Connected := true;
  if not dbSetting.Active then dbSetting.Active := true;

  if not DM.dbStack.Active then DM.dbStack.Active := true;
  if not DM.dbFindTask.Active then DM.dbFindTask.Active := true;
  if not DM.dbFindStack.Active then DM.dbFindStack.Active := true;


  //удаляем стек задач
  //clearStack.Execute ;      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  dbStack.Requery();

  // пересчитываем время запуска задач в планировщике
  if qTask.Active then qTask.Close;
  qTask.Open;
  while not qTask.Eof do
  begin
    TipTask := qTaskTipTask.asInteger;
    TimeTask := qTaskTimeTask.asDatetime;
    SelDay := qTaskSelDay.asString;
    SelMonth := qTaskSelMonth.asString;
    DayMonthTask := qTaskDayMonthTask.asInteger;

    NextStart := FindNextStart( TipTask,
                                TimeTask,
                                SelDay,
                                SelMonth,
                                DayMonthTask);

    setNextStartTask.Parameters.ParamByName('ID').Value := qTaskID.asString;
    setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
    setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
    setNextStartTask.execute;
    qTask.Next;
  end;

  dbSetting.Requery();

end;

procedure TDM.dbSettingAfterScroll(DataSet: TDataSet);
begin
  if DM.startMain then
    frmMain.viewLog(dbSettingPrefixName.AsString)
end;

procedure TDM.dbSettingCalcFields(DataSet: TDataSet);
begin
  // готовим вычисляемые поля
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger = 1, 'V', ' ')  ;
end;

procedure TDM.dbSettingRefresh;
var
  BM: TBookMark;
begin
  // обновляем датасет с сохранение позиции курсора
  BM := dbSetting.GetBookMark;
  dbSetting.Requery() ;
  dbSetting.GotoBookmark(BM);

end;

procedure TDM.dbStackCalcFields(DataSet: TDataSet);
begin
  if dbStackOnExec.AsInteger=0 then
    dbStackOnExecV.AsString := 'Выполняется'
  else
    dbStackOnExecV.AsString := 'В очереди...';
end;



// -------------------------
procedure TDM.SetpathExe(const Value: string);
begin
  FpathExe := Value;
end;

procedure TDM.SetstartMain(const Value: boolean);
begin
  FstartMain := Value;
end;

end.
