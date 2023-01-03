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

    function FindNextStart(TipTask:integer;
                          TimeTask:TDateTime;
                          SelDay:string;
                          SelMonth:string;
                          DayMonthTask:word
                          ):TDateTime;

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

    procedure logZip(PrefixName, StrLog:string);
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


  private
    FexecIDTask: string;
    FpathExe: string;
    procedure SetexecIDTask(const Value: string);
    procedure SetpathExe(const Value: string);
    { Private declarations }

  public
    { Public declarations }
    property execIDTask: string read FexecIDTask write SetexecIDTask;
    property pathExe:string read FpathExe write SetpathExe;

  end;

var
  frmMain: TfrmMain;

implementation

uses
  SetTask, sevenzip, unitDM;

{$R *.dfm}

procedure TfrmMain.SetexecIDTask(const Value: string);
begin
  FexecIDTask := Value;
end;


procedure TfrmMain.SetpathExe(const Value: string);
begin
  FpathExe := Value;
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

function TfrmMain.ExistRecStack():boolean;
begin
   //��������� ������� ����� � �����
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
  // ��������� ������
  frmSetTask.modeEdit := 'ADD';
  frmSetTask.initADD();
  frmSetTask.ShowModal ;

end;

procedure TfrmMain.popDelClick(Sender: TObject);
begin

  if MessageDlg('������� ������?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
    begin
      DM.dbSetting.Delete;
    end;

end;

procedure TfrmMain.popOffClick(Sender: TObject);
begin
    //��������� ������
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;
    DM.dbSetting.Requery();

end;

procedure TfrmMain.popOnClick(Sender: TObject);
begin
    //��������� ������
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.dbSettingID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 1;
    DM.setOnTask.Execute;
    DM.dbSetting.Requery();

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
  //����������� popTask
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

procedure TfrmMain.SaveSetting(ID, NameTask, FromZip, ToZip, PrefixName: string;
  FormatZip, CompressZip, CryptZip: integer; CryptWord: string; CryptFileName,
  TipTask: integer; TimeTask: TDatetime; DayMonthTask: Word; OnTask: integer; SelDay,
  SelMonth: string; modeEdit:integer; KolCopy:integer);
var
  tmpDT:Tdatetime;
begin
  // ��������� �������
  if modeEdit=0 then
  begin
    //��������� ������
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
    DM.addTask.Parameters.ParamByName('LastStart').Value := '�������' ;
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
    DM.dbSetting.Requery();
  end;
end;



// ������ ������ � ��������� ������
procedure TfrmMain.StartTask(ID:string);
var
  oneMoreThread: TOneMoreThread;
  strLog, PrefixName: string;
  begin

  // ������ ������
  if DM.qStartTask.Active then DM.qStartTask.Close;
  DM.qStartTask.Prepared;
  DM.qStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.qStartTask.Open;

  //��������� ������� ����
  if not DirectoryExists(DM.qStartTaskFromZip.AsString) then
  begin
    LogZip(DM.qStartTaskPrefixName.AsString, '������ <' + DM.qStartTaskNameTask.AsString + '> - ���� ��������� �� ������, ������ ���������' );

    //��������� ������
    DM.setOnTask.Parameters.ParamByName('ID').Value := DM.qStartTaskID.AsString;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;
    DM.dbSetting.Requery();
    exit;
  end;


  //��������� ����� �������
  DM.setLastStartTask.Parameters.ParamByName('ID').Value := DM.qStartTaskID.AsString;
  DM.setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  DM.setLastStartTask.Execute;


  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ �������� - ' + DateTimeToStr(Now());

  logZip(DM.qStartTaskPrefixName.AsString, strLog);



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
  DM.dbFindStack.Requery();
  if DM.dbFindStack.RecordCount=0 then exit;
  DM.dbFindStack.First;
  if DM.dbFindStackOnExec.AsInteger=1 then
  begin
    DM.setExecStack.Prepared;
    DM.setExecStack.Parameters.ParamByName('ID').Value := DM.dbFindStackID.AsString;
    DM.setExecStack.Parameters.ParamByName('OnExec').Value := 0;
    DM.setExecStack.Execute;
    DM.dbStack.Requery() ;

    DBGrid1.Refresh;

    StartTask(DM.dbFindStackID.AsString);

  end;



end;

procedure TfrmMain.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  statusStr:integer;

begin
  //���������� ������ ���������� � ������ ��� �����
  DM.dbFindTask.Requery();
  if DM.dbFindTask.RecordCount=0 then exit;

  DM.dbFindTask.First;
  while not DM.dbFindTask.Eof do
  begin
    //��������� � ���� ������

    flFind := ExistRecStack();
    //��������� ������� � ����� �����
    if flFind then
    begin
      // ��������� �� �������� ������                     !!!!!!!!!!!!!!!!!!
      DM.existStack.Requery();
      DM.ExistStack.First;
      while not DM.ExistStack.Eof do
      begin
        if Trim(DM.ExistStackID.AsString) = Trim(DM.dbFindTaskID.AsString) then
        begin
          //������ ��� ���� � �����
          exit;
        end;
        DM.ExistStack.Next;
      end;

    end;

    //memLog.Lines.Add('��������� ������ -' + dbFindTaskNameTask.AsString + ' - ' + DateTimeToStr(dbFindTaskNextStart.AsDateTime));


    statusStr := 1;

    DM.addExecTask.Prepared;
    DM.addExecTask.Parameters.ParamByName('ID').Value := DM.dbFindTaskID.AsString;

    DM.addExecTask.Parameters.ParamByName('NameTask').Value := DM.dbFindTaskNameTask.AsString;

    DM.addExecTask.Parameters.ParamByName('StartTime').Value := DM.dbFindTaskNextStart.AsDateTime;

    DM.addExecTask.Parameters.ParamByName('onExec').Value := statusStr ;

    DM.addExecTask.Execute;
    DM.dbStack.Requery() ;
    DBGrid1.Refresh;


    DM.dbFindTask.Next;
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
begin
  //��������� ���� � ������������ �����
  frmMain.pathExe := ExtractFilePath(Application.ExeName);

  //��������� ������ � �����
  if DM.dbStack.RecordCount>0 then
  begin
    // ���� ������������� �������
    if DM.dbStack.RecordCount>0 then
      if MessageDlg('� ������� ����� ���� �� ���������� � ������� ������. �������� ������� �����?' ,mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        //�������
        DM.clearStack.Execute ;
      end
      else
      begin
        DM.dbStack.First;
        if DM.dbStackOnExec.AsInteger=0 then
        begin
          //��������� ������� ����� � ��������
          DM.setExecStack.Parameters.ParamByName('ID').Value := DM.dbStackID.AsString;
          DM.setExecStack.Parameters.ParamByName('OnExec').Value := 1;
          DM.setExecStack.Execute;
        end;
      end;


    DM.dbStack.Requery();
    DM.dbStack.First;


  end;

  //�������� ������
//  timerTask.Enabled := true;
//  timerStack.Enabled := true;


end;



procedure TfrmMain.logZip(PrefixName, StrLog: string);
var
  ListLog : TStringList;
  logStr    : string;
  pathLog:string;
  LogName:string;
begin
  pathLog := frmMain.pathExe + '\Logs';
  logName :=  frmMain.pathExe +'\' + DM.qStartTaskPrefixName.AsString + '.log';

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
  DM.delExecStack.Parameters.ParamByName('ID').Value := ID;
  DM.delExecStack.Execute;
  DM.dbStack.Requery();

  //�����������
  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ ��������� - ' + DateTimeToStr(Now());
  frmMain.logZip(PrefixName, strLog);
  strLog := '----------------------';
  frmMain.logZip(PrefixName, strLog);


  frmMain.ControlCopy(ToZip, ToZip + '\' + PrefixName + '*.zip', kolCopy);


end;



end.


