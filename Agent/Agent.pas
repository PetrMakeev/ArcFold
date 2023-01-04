unit Agent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, System.DateUtils,
  Vcl.StdCtrls;

type
  TfrmAgent = class(TForm)
    TimerTask: TTimer;
    Label1: TLabel;
    procedure TimerTaskTimer(Sender: TObject);

    function ExistRecStack():boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAgent: TfrmAgent;

implementation

uses
  unitDMAgent, Func;

{$R *.dfm}

procedure TfrmAgent.TimerTaskTimer(Sender: TObject);
var
  recNo:integer;
  flFind: boolean;
  BM: TBookmark;
  NextStart: TDateTime;
begin

  //���������� ������ ���������� � ������ ��� �����
  DMA.dbFindTask.Requery();
  if DMA.dbFindTask.RecordCount=0 then exit;

  DMA.dbFindTask.First;
  while not DMA.dbFindTask.Eof do
  begin
    //��������� � ���� ������

    flFind := ExistRecStack();
    //��������� ������� � ����� �����
    if flFind then
    begin
      // ��������� �� �������� ������                     !!!!!!!!!!!!!!!!!!
      DMA.existStack.Requery();
      DMA.ExistStack.First;
      while not DMA.ExistStack.Eof do
      begin
        if (Trim(DMA.ExistStackID.AsString) = Trim(DMA.dbFindTaskID.AsString)) and
           (SecondsBetween(DMA.existStackStartTime.asDateTime, DMA.dbFindStackStartTime.asDateTime ) < 60)  then
        begin
          //������ ��� ���� � �����
          exit;
        end;
        DMA.ExistStack.Next;
      end;

    end;

    //��������� ������ � ����
    DMA.addExecTask.Prepared;
    DMA.addExecTask.Parameters.ParamByName('ID').Value := DMA.dbFindTaskID.AsString;
    DMA.addExecTask.Parameters.ParamByName('NameTask').Value := DMA.dbFindTaskNameTask.AsString;
    DMA.addExecTask.Parameters.ParamByName('StartTime').Value := DMA.dbFindTaskNextStart.AsDateTime;
    DMA.addExecTask.Parameters.ParamByName('onExec').Value := 1 ;   // ������ � ��������...
    DMA.addExecTask.Execute;
    DMA.dbStack.Requery() ;

    DMA.dbFindTask.Next;

    //������������� ��������� ������

    //����� ���������� ������ ���������� ��������� ����� ������
    NextStart := FindNextStart( DMA.dbFindTaskTipTask.asInteger,
                                DMA.dbFindTaskTimeTask.asDateTime,
                                DMA.dbFindTaskSelDay.asString,
                                DMA.dbFindTaskSelMonth.asString,
                                DMA.dbFindTaskDayMonthTask.asInteger);

    DMA.setNextStartTask.Parameters.ParamByName('ID').Value := DMA.dbFindTaskID.AsString;
    DMA.setNextStartTask.Parameters.ParamByName('NextStart').Value := NextStart;
    DMA.setNextStartTask.Parameters.ParamByName('NextStartStr').Value := DateTimeToStr(NextStart);
    DMA.setNextStartTask.execute;


  end;

end;

// �������� �����
function TfrmAgent.ExistRecStack():boolean;
begin
   //��������� ������� ����� � �����
   if DMA.existStack.Active then DMA.existStack.Close;
   DMA.existStack.Open;
   if DMA.existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

end;


end.
