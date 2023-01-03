program ArcFold;

uses
  Forms,
  Main in 'Forms\Main.pas' {frmMain},
  SetTask in 'Forms\SetTask.pas' {frmSetTask},
  sevenzip in 'sevenzip.pas',
  unitDM in 'unitDM.pas' {DM: TDataModule},
  Func in 'Func.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Резервное копирование';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetTask, frmSetTask);
  Application.Run;

end.
