program ArcFold;

uses
  Forms,
  Main in 'Forms\Main.pas' {frmMain},
  SetTask in 'Forms\SetTask.pas' {frmSetTask};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '��������� �����������';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetTask, frmSetTask);
  Application.Run;

end.
