object frmSetSrv: TfrmSetSrv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1072#1075#1077#1085#1090#1072' '#1088#1077#1079#1077#1088#1074#1085#1086#1075#1086' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 200
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Пользователь: TLabel
    Left = 109
    Top = 24
    Width = 77
    Height = 15
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  end
  object Label1: TLabel
    Left = 125
    Top = 80
    Width = 42
    Height = 15
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object tmpMemo: TMemo
    Left = 213
    Top = 14
    Width = 128
    Height = 25
    Lines.Strings = (
      'tmpMemo')
    TabOrder = 0
    Visible = False
  end
  object btnStartAgent: TButton
    Left = 61
    Top = 152
    Width = 169
    Height = 25
    Caption = 'btnStartAgent'
    TabOrder = 3
    OnClick = btnStartAgentClick
  end
  object txtUser: TEdit
    Left = 61
    Top = 45
    Width = 170
    Height = 23
    TabOrder = 1
  end
  object txtPass: TEdit
    Left = 61
    Top = 101
    Width = 169
    Height = 23
    TabOrder = 2
  end
end
