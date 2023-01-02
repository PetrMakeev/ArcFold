unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Vcl.AppEvnts, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.DBCtrls, System.StrUtils, Vcl.ComCtrls,
  System.DateUtils, Data.Win.ADODB, System.ImageList, Vcl.ImgList;

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
    dbFindStack: TADOQuery;
    qStartTask: TADOQuery;
    delExecStack: TADOCommand;
    dbStack: TADOQuery;
    dbStackKeyStr: TAutoIncField;
    dbStackID: TWideStringField;
    dbStackNameTask: TWideStringField;
    dbStackStartTime: TDateTimeField;
    addExecTask: TADOCommand;
    TimerStack: TTimer;
    setExecStack: TADOCommand;
    ImageList: TImageList;
    popStack: TPopupMenu;
    popDelStack: TMenuItem;
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
    setOnTask: TADOCommand;
    dbStackonExec: TSmallintField;
    dbStackOnExecV: TStringField;
    existStackKeyStr: TAutoIncField;
    existStackID: TWideStringField;
    existStackNameTask: TWideStringField;
    existStackStartTime: TDateTimeField;
    existStackonExec: TSmallintField;
    dbFindStackID: TWideStringField;
    dbFindStackNameTask: TWideStringField;
    dbFindStackStartTime: TDateTimeField;
    dbFindStackonExec: TSmallintField;
    setLastStartTask: TADOCommand;
    dbSettingkolCopy: TSmallintField;
    qStartTaskkolCopy: TSmallintField;
    qCurrTask: TADOQuery;
    qCurrTaskKeyStr: TAutoIncField;
    qCurrTaskID: TWideStringField;
    qCurrTaskNameTask: TWideStringField;
    qCurrTaskFromZip: TWideStringField;
    qCurrTaskToZip: TWideStringField;
    qCurrTaskPrefixName: TWideStringField;
    qCurrTaskFormatZip: TSmallintField;
    qCurrTaskCompressZip: TSmallintField;
    qCurrTaskCryptZip: TSmallintField;
    qCurrTaskCryptWord: TWideStringField;
    qCurrTaskCryptFileName: TSmallintField;
    qCurrTaskTipTask: TSmallintField;
    qCurrTaskTimeTask: TDateTimeField;
    qCurrTaskDayMonthTask: TSmallintField;
    qCurrTaskOnTask: TSmallintField;
    qCurrTaskSelDay: TWideStringField;
    qCurrTaskSelMonth: TWideStringField;
    qCurrTaskLogTask: TWideMemoField;
    qCurrTaskNextStart: TDateTimeField;
    qCurrTaskLastStart: TWideStringField;
    qCurrTaskNextStartStr: TWideStringField;
    qCurrTaskkolCopy: TSmallintField;
    upLogTask: TADOCommand;
    tmpMemo: TMemo;
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
                       modeEdit:integer;
                       kolCopy:integer);

    function ExistRecStack():boolean;

    procedure logZip(PrefixName, StrLog:string);
    procedure ControlCopy(ToZip, FindCopy:string; kolCopy:integer );

    procedure popDelClick(Sender: TObject);
    procedure popOnClick(Sender: TObject);
    procedure popOffClick(Sender: TObject);
    procedure popEditClick(Sender: TObject);
    procedure dbSettingCalcFields(DataSet: TDataSet);
    procedure TimerTaskTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerStackTimer(Sender: TObject);
    procedure popStackPopup(Sender: TObject);
    procedure dbStackCalcFields(DataSet: TDataSet);
    procedure dbSettingAfterScroll(DataSet: TDataSet);
    procedure dbStackAfterScroll(DataSet: TDataSet);
    procedure pgTaskChange(Sender: TObject);


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
                      dbSettingSelMonth.AsString,
                      dbSettingKolCopy.AsInteger    )  ;

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



procedure TfrmMain.ControlCopy(ToZip, FindCopy: string; kolCopy: integer);
var
  SearchRec: TSearchRec; // ���������� � ����� ��� ��������
  massiv: Array [1..30] of String;
  n, i: LongInt;

begin
  //������� ������ ����� ���� ���������� ������ ����������
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

procedure TfrmMain.dbSettingAfterScroll(DataSet: TDataSet);
begin
  //������� ��� � ���� ����� �������� �� �������
  memLog.Lines.Clear;
  memLog.Lines.Add(dbSettingLogTask.AsString);

end;

procedure TfrmMain.dbSettingCalcFields(DataSet: TDataSet);
begin
  // ������� ����������� ����
  dbSettingOnTaskv.AsString := ifthen(dbSettingOnTask.AsInteger = 1, 'V', ' ')  ;
end;


procedure TfrmMain.dbStackAfterScroll(DataSet: TDataSet);
begin
  //������� ��� � ���� ����� �������� �� �������
  if (pgTask.ActivePageIndex=1) and (not dbStack.Eof) then
  begin
    if qCurrTask.Active then qCurrTask.Close;
    qCurrTask.Parameters.ParamByName('ID').Value := dbStackID.AsString;
    qCurrTask.Open;
    qCurrTask.First;
    if not qCurrTask.Eof then
    begin
      memLog.Lines.Clear;
      memLog.Lines.Add(qCurrTaskLogTask.AsString);
    end
    else
      memLog.Lines.Clear;
  end
  else
    memLog.Lines.Clear;
end;

procedure TfrmMain.dbStackCalcFields(DataSet: TDataSet);
begin
  if dbStackOnExec.AsInteger=0 then
    dbStackOnExecV.AsString := '�����������'
  else
    dbStackOnExecV.AsString := '� �������...';
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

procedure TfrmMain.pgTaskChange(Sender: TObject);
begin
  memLog.Lines.Clear;

  //������� ��� � ���� ����� �������� �� �������
  if (pgTask.ActivePageIndex=1) then
  begin
    if (not dbStack.Eof) then
    begin
      if qCurrTask.Active then qCurrTask.Close;
      qCurrTask.Parameters.ParamByName('ID').Value := dbStackID.AsString;
      qCurrTask.Open;
      qCurrTask.First;
      if not qCurrTask.Eof then memLog.Lines.Add(qCurrTaskLogTask.AsString);
    end;
  end
  else
  begin
    //������� ��� � ���� ����� �������� �� �������
    if not dbSetting.Eof then  memLog.Lines.Add(dbSettingLogTask.AsString)
    else
    begin
      if dbSetting.Eof and (dbSetting.RecordCount>0) then dbSetting.Last;
      memLog.Lines.Clear;
      memLog.Lines.Add(dbSettingLogTask.AsString);
    end;


  end;


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

procedure TfrmMain.popStackPopup(Sender: TObject);
begin
  //����������� popTask
  if (dbStack.Eof) then
  begin
    popDelStack.Enabled := false;
   end
  else
  begin
    if dbStackOnExec.AsInteger = 0 then
      popDelStack.Enabled := false
    else
      popDelStack.Enabled := true;
  end;

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
  SelMonth: string; modeEdit:integer; KolCopy:integer);
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
  dbSetting.FieldByName('KolCopy').AsInteger := KolCopy;

  dbSetting.Post;
end;



// ������ ������ � ��������� ������
procedure TfrmMain.StartTask(ID:string);
var
  oneMoreThread: TOneMoreThread;
  strLog, PrefixName: string;
  begin

  // ������ ������
  if qStartTask.Active then qStartTask.Close;
  qStartTask.Prepared;
  qStartTask.Parameters.ParamByName('ID').Value := ID;
  qStartTask.Open;

  //��������� ������� ����
  if not DirectoryExists(qStartTaskFromZip.AsString) then
  begin
    LogZip(qStartTaskPrefixName.AsString, '������ <' + qStartTaskNameTask.AsString + '> - ���� ��������� �� ������, ������ ���������' );

    //��������� ������
    setOnTask.Parameters.ParamByName('ID').Value := qStartTaskID.AsString;
    setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    setOnTask.Execute;
    dbSetting.Requery();
    exit;
  end;


  //��������� ����� �������
  setLastStartTask.Parameters.ParamByName('ID').Value := qStartTaskID.AsString;
  setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  setLastStartTask.Execute;


  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ �������� - ' + DateTimeToStr(Now());

  logZip(qStartTaskPrefixName.AsString, strLog);



  //��������� ������������� � ��������� ������
  execIDTask := ID;
  oneMoreThread := TOneMoreThread.Create(false); // << false �������� ���� ������ ������
  oneMoreThread.FreeOnTerminate := true; // << ����������� ����� ����������
  //oneMoreThread.Resume;



end;



// ������������ ������ ������, ���� ������ �� ���������� � ���������� � ����
procedure TfrmMain.TimerStackTimer(Sender: TObject);
begin
  //���������� ������ � �����
  dbFindStack.Requery();
  if dbFindStack.RecordCount=0 then exit;
  dbFindStack.First;
  if dbFindStackOnExec.AsInteger=1 then
  begin
    setExecStack.Prepared;
    setExecStack.Parameters.ParamByName('ID').Value := dbFindStackID.AsString;
    setExecStack.Parameters.ParamByName('OnExec').Value := 0;
    setExecStack.Execute;
    dbStack.Requery() ;

    DBGrid1.Refresh;

    StartTask(dbFindStackID.AsString);

  end;



end;

procedure TfrmMain.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  statusStr:integer;

begin
  //���������� ������ ���������� � ������ ��� �����
  dbFindTask.Requery();
  if dbFindTask.RecordCount=0 then exit;

  dbFindTask.First;
  while not dbFindTask.Eof do
  begin
    //��������� � ���� ������

    flFind := ExistRecStack();
    //��������� ������� � ����� �����
    if flFind then
    begin
      // ��������� �� �������� ������                     !!!!!!!!!!!!!!!!!!
      ExistStack.First;
      while not ExistStack.Eof do
      begin
        if Trim(ExistStackID.AsString) = Trim(dbFindTaskID.AsString) then
        begin
          //������ ��� ���� � �����
          exit;
        end;
        ExistStack.Next;
      end;

    end;

    //memLog.Lines.Add('��������� ������ -' + dbFindTaskNameTask.AsString + ' - ' + DateTimeToStr(dbFindTaskNextStart.AsDateTime));


//    if not flFind then
//      //���� ���� ������ ������ ��������� ��� �����������
//      statusStr := 0
//    else
      statusStr := 1;

    addExecTask.Prepared;
    addExecTask.Parameters.ParamByName('ID').Value := dbFindTaskID.AsString;

    addExecTask.Parameters.ParamByName('NameTask').Value := dbFindTaskNameTask.AsString;

    addExecTask.Parameters.ParamByName('StartTime').Value := dbFindTaskNextStart.AsDateTime;

    addExecTask.Parameters.ParamByName('onExec').Value := statusStr ;

    addExecTask.Execute;
    dbStack.Requery() ;
    DBGrid1.Refresh;


    dbFindTask.Next;
  end;

//  // ��������� ������ ���� ���� ��� ����
//  if not flFind then
//  begin
//    dbFindTask.First;
//    StartTask(dbFindTaskID.AsString);
//  end;

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

  if not dbStack.Active then dbStack.Active := true;
  if not dbFindTask.Active then dbFindTask.Active := true;
  if not dbFindStack.Active then dbFindStack.Active := true;

  //��������� ������ � �����
  if dbStack.RecordCount>0 then
  begin
    // ���� ������������� �������
    if dbStack.RecordCount>0 then
      if MessageDlg('� ������� ����� ���� �� ���������� � ������� ������. �������� ������� �����?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        //�������
        clearStack.Execute ;
      end
      else
      begin
        dbStack.First;
        if dbStackOnExec.AsInteger=0 then
        begin
          //��������� ��� ������� ����� � ��������
          setExecStack.Parameters.ParamByName('ID').Value := dbStackID.AsString;
          setExecStack.Parameters.ParamByName('OnExec').Value := 1;
          setExecStack.Execute;
        end;
      end;


    dbStack.Requery();
    dbStack.First;


  end;

  //�������� ������
  timerTask.Enabled := true;
  timerStack.Enabled := true;


end;



procedure TfrmMain.logZip(PrefixName, StrLog: string);
var
  ListLog : TStringList;
  logStr    : string;
  pathLog:string;
  LogName:string;
begin
  pathLog := ExtractFilePath(Application.ExeName) + '\Logs';
  logName :=  pathLog +'\' + qStartTaskPrefixName.AsString + '.log';

  if not DirectoryExists(pathLog) then CreateDir(pathLog);

  ListLog := TStringList.Create; //������ ����������

  if FileExists(logName) then
    ListLog.LoadFromFile(logName)
  else
    ListLog.Clear;;

  ListLog.Add(strLog ); //���� ���� �������� ������ � ����� �����

  ListLog.SaveToFile(logName); //�������� � ���� �� ����
  ListLog.Free; //���� ����������


end;

{ TOneMoreThread }

procedure TOneMoreThread.execute;
var
  ID, NAmeTask, PrefixName, PrefixNameDT, FromZip, ToZip, CryptWord, Log: string ;
  CompressZip, CryptZip, KolCopy: integer;
  Arch: I7zOutArchive;

  strLog: string;
begin
  inherited;

  //���������� � ��������� ������
  ID:= frmMain.execIDTask;
  frmMain.qStartTask.First;
  NameTask := frmMain.qStartTaskNameTask.AsString;
  PrefixName := frmMain.qStartTaskPrefixName.AsString;
  PrefixNameDT := frmMain.qStartTaskPrefixName.AsString + ReplaceStr(DateTimeToStr(Now()), ':', '.');
  FromZip := frmMain.qStartTaskFromZip.AsString;
  ToZip := frmMain.qStartTaskToZip.AsString;
  CryptWord := frmMain.qStartTaskCryptWord.AsString;
  CryptZip := frmMain.qStartTaskCryptZip.AsInteger;
  CompressZip := frmMain.qStartTaskCompressZip.AsInteger  ;
  KolCopy := frmMain.qStartTaskKolCopy.AsInteger  ;
  Log := frmMain.qStartTaskLogTask.AsString;

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

  //����� ���������� ������������� ������� �� ����� ������
  frmMain.delExecStack.Parameters.ParamByName('ID').Value := ID;
  frmMain.delExecStack.Execute;
  frmMain.dbStack.Requery();

  //�����������
  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ ��������� - ' + DateTimeToStr(Now());
  frmMain.logZip(PrefixName, strLog);


  frmMain.ControlCopy(ToZip, ToZip + '\' + PrefixName + '*.zip', kolCopy);


end;



end.


