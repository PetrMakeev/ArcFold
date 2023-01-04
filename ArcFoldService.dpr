program ArcFoldService;

uses
  Vcl.Forms,
  ArcFoldSrv in 'Srv\ArcFoldSrv.pas' {frmArcFoldSrv},
  sevenzip in 'Srv\sevenzip.pas',
  Func in 'Srv\Func.pas',
  unitDMSrv in 'Srv\unitDMSrv.pas' {DMS: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmArcFoldSrv, frmArcFoldSrv);
  Application.CreateForm(TDMS, DMS);
  Application.Run;
end.
