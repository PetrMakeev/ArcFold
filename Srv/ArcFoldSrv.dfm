object frmArcFoldSrv: TfrmArcFoldSrv
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'frmArcFoldSrv'
  ClientHeight = 47
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Scaled = False
  TextHeight = 15
  object Label1: TLabel
    Left = 48
    Top = 16
    Width = 85
    Height = 15
    Caption = 'ArcFold '#1089#1083#1091#1078#1073#1072
  end
  object TimerStack: TTimer
    Interval = 2000
    OnTimer = TimerStackTimer
    Left = 197
    Top = 7
  end
end
