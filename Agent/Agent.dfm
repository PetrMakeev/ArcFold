object frmAgent: TfrmAgent
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'ArcFoldAgent'
  ClientHeight = 46
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Scaled = False
  TextHeight = 15
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 85
    Height = 15
    Caption = #1040#1075#1077#1085#1090' ArcFolder'
  end
  object TimerTask: TTimer
    OnTimer = TimerTaskTimer
    Left = 165
  end
end
