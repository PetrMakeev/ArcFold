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

  //перебираем задачи попадающие в запрос для стека
  DMA.dbFindTask.Requery();
  if DMA.dbFindTask.RecordCount=0 then exit;

  DMA.dbFindTask.First;
  while not DMA.dbFindTask.Eof do
  begin
    //добавляем в стек задачу

    flFind := ExistRecStack();
    //проверяем наличие в стеке задач
    if flFind then
    begin
      // проверяем на повторый запуск                     !!!!!!!!!!!!!!!!!!
      DMA.existStack.Requery();
      DMA.ExistStack.First;
      while not DMA.ExistStack.Eof do
      begin
        if (Trim(DMA.ExistStackID.AsString) = Trim(DMA.dbFindTaskID.AsString)) and
           (SecondsBetween(DMA.existStackStartTime.asDateTime, DMA.dbFindStackStartTime.asDateTime ) < 60)  then
        begin
          //задача уже есть в стеке
          exit;
        end;
        DMA.ExistStack.Next;
      end;

    end;

    //Добавляем задачу в стек
    DMA.addExecTask.Prepared;
    DMA.addExecTask.Parameters.ParamByName('ID').Value := DMA.dbFindTaskID.AsString;
    DMA.addExecTask.Parameters.ParamByName('NameTask').Value := DMA.dbFindTaskNameTask.AsString;
    DMA.addExecTask.Parameters.ParamByName('StartTime').Value := DMA.dbFindTaskNextStart.AsDateTime;
    DMA.addExecTask.Parameters.ParamByName('onExec').Value := 1 ;   // статус В ожидании...
    DMA.addExecTask.Execute;
    DMA.dbStack.Requery() ;

    DMA.dbFindTask.Next;

    //пересчитываем следующий запуск

    //после выполнения задачи определяем следующий старт задачи
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

// проверка стека
function TfrmAgent.ExistRecStack():boolean;
begin
   //проверяем наличие задач в стеке
   if DMA.existStack.Active then DMA.existStack.Close;
   DMA.existStack.Open;
   if DMA.existStack.RecordCount>0 then
     Result := true
   else
     Result := false;

end;


end.
