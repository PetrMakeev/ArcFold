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
  // ��������� ������
  dbStack.Append;
  dbStack.FieldByName('ID').AsString := DateTimeToStr(Now());
  dbStack.FieldByName('NameTask').AsString := '�������� ������';
  dbStack.FieldByName('StartTime').AsDateTime := Now();
  dbStack.FieldByName('OnExec').AsString := '�������';

  dbStack.Post;

end;

procedure TfrmMain.popEditClick(Sender: TObject);
begin
  // ����������� ��������������
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
  //������� � ������ �����
  ShowWindow(Handle,SW_HIDE);  // �������� ���������
  ShowWindow(Application.Handle,SW_HIDE);  // �������� ������ � TaskBar'�
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
  GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));
end;



procedure TfrmMain.Button1Click(Sender: TObject);
begin
// ���������
    TaskToStack(dbSettingID.AsString, dbSettingNameTask.AsString, dbSettingNextStart.AsDateTime);
end;




procedure TfrmMain.dbSettingCalcFields(DataSet: TDataSet);
begin
  // ������� ����������� ����
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger = 1, '+', ' ')  ;

end;


function TfrmMain.ExistRecStack():boolean;
begin
   //��������� ������� ����� � �����
   if existStack.Active then existStack.Close;
   existStack.Open;
   if existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

end;

procedure TfrmMain.popAddClick(Sender: TObject);
begin
  // ��������� ������
  frmSetTask.modeEdit := 'ADD';
  frmSetTask.initADD();
  frmSetTask.ShowModal ;

end;

procedure TfrmMain.popDelClick(Sender: TObject);
begin

  if MessageDlg('������� ������?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
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
  // ��������������� ���� �� ����
  TrayIcon.ShowBalloonHint;
  ShowWindow(Handle,SW_RESTORE);
  SetForegroundWindow(Handle);
  TrayIcon.Visible:=False;
end;

procedure TfrmMain.popTaskPopup(Sender: TObject);
begin
  //����������� popTask
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
  // ��������� �������
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
    dbSetting.FieldByName('LastStart').AsString := '�������' ;
  dbSetting.Post;
end;



// ������ ������ � ��������� ������
procedure TfrmMain.StartTask(ID:string);
var
  oneMoreThread: TOneMoreThread;
begin
  // ������ ������
  if qStartTask.Active then qStartTask.Close;
  qStartTask.Prepared;
  qStartTask.Parameters.ParamByName('ID').Value := ID;
  qStartTask.Open;

  //��������� ������������� � ��������� ������
  execIDTask := ID;
  //oneMoreThread := TOneMoreThread.Create(false); // << false �������� ���� ������ ������
  //oneMoreThread.FreeOnTerminate := true; // << ����������� ����� ����������

  memLog.Lines.Add('start');

  sleep(1000) ;

  memLog.Lines.Add('end');

  //����� ���������� ������������� ������� �� ����� ������
  delExecTask.Parameters.ParamByName('ID').Value := ID;
  delExecTask.Execute;
  dbStack.Requery();


end;

// ����� ����������� � ���� ��������� ������ �� ������������
// ���� ����� � ����� ������ �������� ������ ������
procedure TfrmMain.TaskToStack(ID:string; NameTask:string; StartTime:TDatetime);
var
  flFind: boolean;
  statusStr:string;
begin
  flFind := ExistRecStack();
  //��������� ������� � ����� �����
  if flFind then
  begin
    // ��������� �� �������� ������                     !!!!!!!!!!!!!!!!!!
    ExistStack.First;
    while not ExistStack.Eof do
    begin
      if Trim(ExistStackID.AsString) = Trim(ID) then
      begin
        //������ ��� ���� � �����
        exit;
      end;
      ExistStack.Next;
    end;

  end;

  memLog.Lines.Add('��������� ������ -' + NameTask + ' - ' + DateTimeToStr(StartTime));


  if not flFind then
    //���� ���� ��������� ������
    statusStr := '�����������'
  else
    statusStr := '� �������...';

  addExecTask.Prepared;
  addExecTask.Parameters.ParamByName('ID').Value := ID;

  addExecTask.Parameters.ParamByName('NameTask').Value := NameTask;

  addExecTask.Parameters.ParamByName('StartTime').Value := StartTime;

  addExecTask.Parameters.ParamByName('onExec').Value := statusStr ;

  addExecTask.Execute;
  dbStack.Requery() ;

  // ��������� ������ ���� ���� ��� ����
  if not flFind then
    StartTask(ID);

end;


// ������������ ������ ������, ���� ������ �� ���������� � ���������� � ����
procedure TfrmMain.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
begin
  //���������� ������ ���������� � ������ ��� �����
  dbFindTask.Requery();
  if dbFindTask.RecordCount=0 then exit;

  dbFindTask.First;
  while not dbFindTask.Eof do
  begin
    //��������� � ���� ������
    taskToStack(dbFindTaskID.AsString, dbFindTaskNameTask.AsString, dbFindTaskNextStart.AsDateTime);
    dbFindTask.Next;
  end;

end;


//���������� ���� � ����� ���������� ������ ������
function TfrmMain.FindNextStart(TipTask: integer; TimeTask: TDateTime; SelDay,
  SelMonth: string; DayMonthTask: word): TDateTime;
var
  tmpHour, tmpMinute, tmpSecond, tmpMSec: Word;
  tmpDateTime, DateTimeStart, currDateTime:TDateTime;
  currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec: Word;
  currDayWeek, currMonthYear: word;
  I: Word;
begin

  //���������� ����� ���������� ������ ������
  DecodeTime(TimeTask, tmpHour, tmpMinute, tmpSecond, tmpMSec);

  //��������� ������� ���� � �����
  DecodeDateTime(Now(), currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);
  currDateTime := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, 0, 0);
  DateTimeStart := EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec);

  //���������
  if TipTask=0 then
  begin
    tmpDateTime := EncodeDateTime(currYear, currMonth, currDay, tmpHour, tmpMinute, 0, 0);
    //��������� ������ ����� ������� ������� ��� ���
    if currDateTime > tmpDateTime then
      tmpDateTime := EncodeDateTime(currYear, CurrMonth, CurrDay + 1, tmpHour, tmpMinute, 0, 0);

    DateTimeStart := tmpDateTime;  
  end;

  //�����������
  if TipTask=1 then
  begin

    // ���������� ������� ���� ������
    currDayWeek := DayOfTheWeek(Now());

    // ��������� ����� ������ �� ���� � ����� ����� �� 14 ����
    DateTimeStart := IncDay(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 14-CurrDayWeek);

    //���������� ��� ������ ��� ����������� ��� ������ ������
    for I := 1 to 7 do
    begin

      // ��������� ���� �� �� ������ ���� ������ ����� ������
      if midStr(SelDay, I, 1) = '1' then
      begin
        //��������� �� ���� ������ ���� � ����� ������
        tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I );
 
        // ���� ����� ������  ������ �� ���������� ��� �� ��������� ������
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncDay(EncodeDateTime(currYear, CurrMonth, currDay, tmpHour, tmpMinute, 0, 0), -currDayWeek + I + 1);

        // ���� ��������� tmpDateTime ����� currDateTime � DateTimeStart ������ ������������� ��� ����� ������� ��������� ���
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;

    end;

   end;

   //����������
   if TipTask=2 then
   begin

    // ���������� ������� �����
    currMonthYear := MonthOfTheYear(Now());

    // ��������� ����� ������ �� ���� � ����� ����� �� 24 �������
    DateTimeStart := IncMonth(EncodeDateTime(currYear, currMonth, currDay, currHour, currMinute, currSecond, currMSec), 24-currMonthYear);

    // ���������� ������ ��� ����������� ��� ������ ������
    for I := 1 to 12 do
    begin
      // ��������� ���� �� �� ������ ���� ������ ����� ������
      if midStr(SelMonth, I, 1) = '1' then
      begin

        //��������� �� ���� ������ ���� � ����� ������
        tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 0); // -currMonthYear + I );

        // ���� ����� ������  ������ �� ���������� ��� �� ��������� �����
        if (currDateTime > tmpDateTime) then
          tmpDateTime := IncMonth(EncodeDateTime(currYear, I, DayMonthTask, tmpHour, tmpMinute, 0, 0), 12); //-currMonthYear + I + 12);

        // ���� ��������� tmpDateTime ����� currDateTime � DateTimeStart ������ ������������� ��� ����� ������� ��������� ���
        if (tmpDateTime < DateTimeStart) then
          if (tmpDateTime > currDateTime) then
            DateTimeStart := tmpDateTime;

      end;
    end;

   end;


  Result := DateTimeStart;

end;

//������� � ����������� �����
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

    //���������� � ��������� ������


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
