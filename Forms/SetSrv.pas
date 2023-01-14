unit SetSrv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;


type
  TfrmSetSrv = class(TForm)
    tmpMemo: TMemo;
    btnStartAgent: TButton;
    Пользователь: TLabel;
    txtUser: TEdit;
    Label1: TLabel;
    txtPass: TEdit;

  procedure CheckAgent();
    procedure btnStartAgentClick(Sender: TObject);



  private
    FOnAgentArcFold: integer;
    procedure SetOnAgentArcFold(const Value: integer);
    { Private declarations }
  public
    property OnAgentArcFold:integer read FOnAgentArcFold write SetOnAgentArcFold;

    { Public declarations }
  end;



var
  frmSetSrv: TfrmSetSrv;

implementation

uses
  Main;

{$R *.dfm}

{ TfrmSetSrv }

function StrOemToAnsi(const S: AnsiString): AnsiString;
begin
  SetLength(Result, Length(S));
  OemToAnsiBuff(@S[1], @Result[1], Length(S));
end;


procedure TfrmSetSrv.btnStartAgentClick(Sender: TObject);
begin
  if onAgentArcFold=0 then
  begin
    //запускаем службы
    frmMain.startAgent();
  end
  else
  begin
    //останавливаем службы
  end;
end;

procedure TfrmSetSrv.CheckAgent;
var
  tmpStr:string;
  pathStr:string;
  tmpFile: string;
begin
//  //настраиваем форму

  tmpMemo.Lines.LoadFromFile('ArcFold.tmp');

  tmpStr := StrOemToAnsi(tmpMemo.Text);


  if (pos('ArcFoldAgentCheck', tmpStr )>0) and (pos('ArcFoldServiceCheck', tmpStr)>0) then
  begin
    btnStartAgent.Caption := 'Остановить Агент';
    OnAgentArcFold := 1;
  end
  else
  begin
    btnStartAgent.Caption := 'Запустить Агент';
    OnAgentArcFold := 0;
  end;

end;

procedure TfrmSetSrv.SetOnAgentArcFold(const Value: integer);
begin
  FOnAgentArcFold := Value;
end;

end.
