program ArcFoldAgent;

uses
  Vcl.Forms,
  Agent in 'Agent\Agent.pas' {frmAgent},
  unitDMAgent in 'Agent\unitDMAgent.pas' {DMA: TDataModule},
  Func in 'Agent\Func.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMA, DMA);
  Application.CreateForm(TfrmAgent, frmAgent);
  Application.Run;
end.
