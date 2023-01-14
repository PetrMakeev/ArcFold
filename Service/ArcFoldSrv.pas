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

// �������� ����� �� ��������� ����� � ���������� �����
procedure TService1.ControlCopy(ToZip, FindCopy: string; kolCopy: integer);
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

function TService1.ExistRecStack: boolean;
begin
   //��������� ������� ����� � �����
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

//������ ���������
procedure TService1.StartTask(ID: string);
var
  NameTask, PrefixName, PrefixNameDT, FromZip, ToZip, CryptWord, Log, SelDay, SelMonth: string ;
  TipTask, CompressZip, CryptZip, KolCopy, DayMonthTask: integer;
  NextStart, TimeTask: TDateTime;
  strLog: string;
begin

  // ������ ������
  if DM.qStartTask.Active then DM.qStartTask.Close;
  //DM.qStartTask.Prepared;
  DM.qStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.qStartTask.Open;

  //��������� ������� ����
  if not DirectoryExists(DM.qStartTaskFromZip.AsString) then
  begin
    LogZip(DM.pathExe + 'Logs',
           DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
           '������ <' + DM.qStartTaskNameTask.AsString + '> - ���� ��������� �� ������, ������ ���������' );

    //���� �� ������ ��������� ������
    DM.setOnTask.Parameters.ParamByName('ID').Value := ID;
    DM.setOnTask.Parameters.ParamByName('OnTask').Value := 0;
    DM.setOnTask.Execute;

    exit;
  end;


  //��������� ����� �������
  DM.setLastStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.setLastStartTask.Parameters.ParamByName('LastStart').Value := DateTimeToStr(Now());
  DM.setLastStartTask.Execute;


  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ �������� - ' + DateTimeToStr(Now());

  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\'+ DM.qStartTaskPrefixName.AsString + '.log',
         strLog);


  //����������
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



  //����������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  strLog := '������ ��������� - ' + DateTimeToStr(Now());
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
         strLog);
  strLog := '----------------------';
  logZip(DM.pathExe + 'Logs',
         DM.pathExe + 'Logs\' + DM.qStartTaskPrefixName.AsString + '.log',
         strLog);

  // �������� ���������� �����
  ControlCopy(ToZip, ToZip + '\' + PrefixName + '*.zip', kolCopy);
//
  //����� ���������� ������ ���������� ��������� ����� ������
  NextStart := FindNextStart( TipTask,
                              TimeTask,
                              SelDay,
                              SelMonth,
                              DayMonthTask);

  DM.setNextStartTask.Parameters.ParamByName('ID').Value := ID;
  DM.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
  DM.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
  DM.setNextStartTask.execute;


  //����� ���������� ������������� ������� �� ����� ������
  DM.delExecStack.Parameters.ParamByName('ID').Value := ID;
  DM.delExecStack.Execute;

end;

//�������� ����� ����� �� ���������� � ������ ����� �� �������
procedure TService1.TimerStackTimer(Sender: TObject);
begin
  //���������� ������ � �����
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

//�������� ������� � ���������� � ���� ����� �� ����������
procedure TService1.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  BM: TBookmark;
  NextStart: TDateTime;
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
        if (Trim(DM.ExistStackID.AsString) = Trim(DM.dbFindTaskID.AsString))   then
        begin
          //������ ��� ���� � �����
          exit;
        end;
        DM.ExistStack.Next;
      end;

    end;

    //��������� ������ � ����
    DM.addExecTask.Prepared;
    DM.addExecTask.Parameters.ParamByName('ID').Value := DM.dbFindTaskID.AsString;
    DM.addExecTask.Parameters.ParamByName('NameTask').Value := DM.dbFindTaskNameTask.AsString;
    DM.addExecTask.Parameters.ParamByName('StartTime').Value := DM.dbFindTaskNextStart.AsDateTime;
    DM.addExecTask.Parameters.ParamByName('onExec').Value := 1 ;   // ������ � ��������...
    DM.addExecTask.Execute;


    DM.dbFindTask.Next;

    //������������� ��������� ������

    //����� ���������� ������ ���������� ��������� ����� ������
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
