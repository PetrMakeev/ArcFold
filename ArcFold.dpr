program ArcFold;

uses
  Forms,
  Main in 'Forms\Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Резервное копирование';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
