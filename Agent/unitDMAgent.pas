unit unitDMAgent;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, Forms,
  system.StrUtils;

type
  TDMA = class(TDataModule)
    ADOConn: TADOConnection;
    setOnTask: TADOCommand;
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
    procedure DataModuleCreate(Sender: TObject);

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
  DMA: TDMA;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Agent, Func;

{$R *.dfm}

procedure TDMA.DataModuleCreate(Sender: TObject);
var
  NextStart:TDateTime;
  TipTask: integer;
  TimeTask: TDateTime;
  SelDay, SelMonth :string;
  DayMonthTask :Word;

begin

  DMA.startMain := false;

  DMA.pathExe := ExtractFilePath(Application.ExeName);

  if AdoConn.Connected then  AdoConn.Close;

  ADOConn.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + pathExe + 'arcFold.mdb;Persist Security Info=False;';
  ADOConn.Connected := true;

  if not dbFindTask.Active then dbFindTask.Active := true;


  // ????????????? ????? ??????? ????? ? ????????????
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


end;




// -------------------------
procedure TDMA.SetpathExe(const Value: string);
begin
  FpathExe := Value;
end;

procedure TDMA.SetstartMain(const Value: boolean);
begin
  FstartMain := Value;
end;

end.
