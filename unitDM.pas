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
    procedure dbSettingAfterScroll(DataSet: TDataSet);
    procedure dbSettingCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dbStackCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Main;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  pathExe:string;
begin
  pathExe := ExtractFilePath(Application.ExeName);

  if AdoConn.Connected then  AdoConn.Close;

  ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + pathExe + 'arcFold.mdb;Persist Security Info=False;';
  ADOConn.Connected := true;
  if not dbSetting.Active then dbSetting.Active := true;

  if not DM.dbStack.Active then DM.dbStack.Active := true;
  if not DM.dbFindTask.Active then DM.dbFindTask.Active := true;
  if not DM.dbFindStack.Active then DM.dbFindStack.Active := true;

end;

procedure TDM.dbSettingAfterScroll(DataSet: TDataSet);
var
  logName, pathLog:string;
begin
  //выводим лог в мемо после движени€ по запис€м
  //frmMain.memLog.Lines.Clear;

  pathLog := ExtractFilePath(Application.ExeName) + '\Logs';
  logName :=  pathLog +'\' + dbSettingPrefixName.AsString + '.log';
  if DirectoryExists(PathLog) and FileExists(logName) then
    frmMain.memLog.Lines.LoadFromFile(logName);
end;

procedure TDM.dbSettingCalcFields(DataSet: TDataSet);
begin
  // готовим вычисл€емые пол€
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger = 1, 'V', ' ')  ;
end;

procedure TDM.dbStackCalcFields(DataSet: TDataSet);
begin
  if dbStackOnExec.AsInteger=0 then
    dbStackOnExecV.AsString := '¬ыполн€етс€'
  else
    dbStackOnExecV.AsString := '¬ очереди...';
end;

end.
