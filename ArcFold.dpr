program ArcFold;

uses
  Forms,
  Main in 'Forms\Main.pas' {frmMain},
  SetTask in 'Forms\SetTask.pas' {frmSetTask},
  sevenzip in 'Forms\sevenzip.pas',
  unitDM in 'Forms\unitDM.pas' {DMA: TDataModule},
  Func in 'Forms\Func.pas',
  SetSrv in 'Forms\SetSrv.pas' {frmSetSrv};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Резервное копирование';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetTask, frmSetTask);
  Application.CreateForm(TfrmSetSrv, frmSetSrv);
  Application.Run;

end.
