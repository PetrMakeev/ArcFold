object frmSetTask: TfrmSetTask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1047#1072#1076#1072#1095#1072
  ClientHeight = 518
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 92
    Height = 15
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1079#1072#1076#1072#1095#1080
  end
  object Label2: TLabel
    Left = 8
    Top = 53
    Width = 118
    Height = 15
    Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1072#1088#1093#1080#1074#1072#1094#1080#1080
  end
  object Label3: TLabel
    Left = 8
    Top = 101
    Width = 165
    Height = 15
    Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1072#1088#1093#1080#1074#1072
  end
  object Label4: TLabel
    Left = 8
    Top = 149
    Width = 124
    Height = 15
    Caption = #1055#1088#1077#1092#1080#1082' '#1080#1084#1077#1085#1080' '#1072#1088#1093#1080#1074#1072
  end
  object Label7: TLabel
    Left = 13
    Top = 455
    Width = 143
    Height = 15
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1086#1087#1080#1081' '#1072#1088#1093#1080#1074#1072
  end
  object txtNameTask: TEdit
    Left = 8
    Top = 24
    Width = 489
    Height = 23
    MaxLength = 100
    TabOrder = 0
  end
  object txtFromZip: TEdit
    Left = 8
    Top = 72
    Width = 458
    Height = 23
    TabStop = False
    MaxLength = 500
    ReadOnly = True
    TabOrder = 1
  end
  object txtToZip: TEdit
    Left = 8
    Top = 122
    Width = 458
    Height = 23
    TabStop = False
    MaxLength = 500
    ReadOnly = True
    TabOrder = 3
  end
  object txtPrefixName: TEdit
    Left = 8
    Top = 170
    Width = 489
    Height = 23
    MaxLength = 100
    TabOrder = 5
  end
  object btnFromZip: TButton
    Left = 467
    Top = 71
    Width = 30
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = btnFromZipClick
  end
  object btnToZip: TButton
    Left = 467
    Top = 121
    Width = 30
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = btnToZipClick
  end
  object pgSet: TPageControl
    Left = 9
    Top = 208
    Width = 489
    Height = 233
    ActivePage = tabTime
    TabOrder = 6
    object tabTime: TTabSheet
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077' '#1072#1088#1093#1080#1074#1072#1094#1080#1080
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 481
        Height = 203
        Align = alClient
        Brush.Color = clBtnFace
        ExplicitHeight = 201
      end
      object Label9: TLabel
        Left = 12
        Top = 11
        Width = 104
        Height = 15
        Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1079#1072#1076#1072#1085#1080#1077
      end
      object Label10: TLabel
        Left = 294
        Top = 11
        Width = 77
        Height = 15
        Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072
      end
      object gbMonth: TGroupBox
        Left = 12
        Top = 55
        Width = 453
        Height = 138
        TabOrder = 3
        Visible = False
        object sbMonthAllOn: TSpeedButton
          Left = 14
          Top = 7
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            76050000424D7605000000000000360000002800000015000000150000000100
            18000000000040050000120B0000120B00000000000000000000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F01FC3551FC355F0F0F0F0F0F0FCFBF8F0F0
            F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F01FC3551FC3551FC3551FC355F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F01FC35546E28246E28246E28246E2821FC355F0F0F0F0F0
            F0947D5DF0F0F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E1FC3551FC35546E2821FC3551FC35546E28246E2821FC355F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F01FC3551FC355F0F0F0F0F0F01FC35546E28246E2821FC3
            55927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F01FC3551FC3551FC3
            55927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F01FC355F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5E927C5E927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000}
          OnClick = sbMonthAllOnClick
        end
        object sbMonthAllOff: TSpeedButton
          Left = 43
          Top = 7
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            76050000424D7605000000000000360000002800000015000000150000000100
            18000000000040050000120B0000120B00000000000000000000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F073F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F069F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00DF0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F02CF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0FCFBF8F0F0
            F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F074F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0947D5DF0F0F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F067F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F024F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F078F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F069F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F00AF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F074F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5E927C5E927C5EF0F0F0F0F0F0F0F0F077F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F05FF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F044}
          OnClick = sbMonthAllOffClick
        end
        object Label11: TLabel
          Left = 14
          Top = 111
          Width = 194
          Height = 15
          Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100'                   '#1095#1080#1089#1083#1072' '#1084#1077#1089#1103#1094#1072
        end
        object chbMonth01: TCheckBox
          Left = 14
          Top = 35
          Width = 90
          Height = 17
          Caption = #1071#1085#1074#1072#1088#1100
          TabOrder = 0
        end
        object chbMonth02: TCheckBox
          Left = 14
          Top = 58
          Width = 90
          Height = 17
          Caption = #1060#1077#1074#1088#1072#1083#1100
          TabOrder = 1
        end
        object chbMonth03: TCheckBox
          Left = 14
          Top = 81
          Width = 78
          Height = 17
          Caption = #1052#1072#1088#1090
          TabOrder = 2
        end
        object chbMonth04: TCheckBox
          Left = 127
          Top = 35
          Width = 74
          Height = 17
          Caption = #1040#1087#1088#1077#1083#1100
          TabOrder = 3
        end
        object chbMonth05: TCheckBox
          Left = 127
          Top = 58
          Width = 74
          Height = 17
          Caption = #1052#1072#1081
          TabOrder = 4
        end
        object chbMonth06: TCheckBox
          Left = 127
          Top = 81
          Width = 74
          Height = 17
          Caption = #1048#1102#1085#1100
          TabOrder = 5
        end
        object chbMonth07: TCheckBox
          Left = 217
          Top = 35
          Width = 88
          Height = 17
          Caption = #1048#1102#1083#1100
          TabOrder = 6
        end
        object chbMonth08: TCheckBox
          Left = 217
          Top = 58
          Width = 64
          Height = 17
          Caption = #1040#1074#1075#1091#1089#1090
          TabOrder = 7
        end
        object chbMonth09: TCheckBox
          Left = 217
          Top = 81
          Width = 80
          Height = 17
          Caption = #1057#1077#1085#1090#1103#1073#1088#1100
          TabOrder = 8
        end
        object chbMonth10: TCheckBox
          Left = 311
          Top = 35
          Width = 107
          Height = 17
          Caption = #1054#1082#1090#1103#1073#1088#1100
          TabOrder = 9
        end
        object chbMonth11: TCheckBox
          Left = 311
          Top = 58
          Width = 107
          Height = 17
          Caption = #1053#1086#1103#1073#1088#1100
          TabOrder = 10
        end
        object chbMonth12: TCheckBox
          Left = 311
          Top = 81
          Width = 107
          Height = 17
          Caption = #1044#1077#1082#1072#1073#1088#1100
          TabOrder = 11
        end
        object txtDayMonthTask: TNumberBox
          Left = 84
          Top = 109
          Width = 41
          Height = 21
          Alignment = taRightJustify
          Decimal = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          MinValue = 1.000000000000000000
          MaxValue = 31.000000000000000000
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 12
          Value = 1.000000000000000000
          SpinButtonOptions.Placement = nbspCompact
        end
      end
      object gbWeek: TGroupBox
        Left = 12
        Top = 55
        Width = 453
        Height = 138
        TabOrder = 2
        Visible = False
        object sbWeekAllOn: TSpeedButton
          Left = 14
          Top = 7
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            76050000424D7605000000000000360000002800000015000000150000000100
            18000000000040050000120B0000120B00000000000000000000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F01FC3551FC355F0F0F0F0F0F0FCFBF8F0F0
            F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F01FC3551FC3551FC3551FC355F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F01FC35546E28246E28246E28246E2821FC355F0F0F0F0F0
            F0947D5DF0F0F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E1FC3551FC35546E2821FC3551FC35546E28246E2821FC355F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F01FC3551FC355F0F0F0F0F0F01FC35546E28246E2821FC3
            55927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F01FC3551FC3551FC3
            55927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F01FC355F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5E927C5E927C5EF0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000}
          OnClick = sbWeekAllOnClick
        end
        object sbWeekAllOff: TSpeedButton
          Left = 43
          Top = 7
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            76050000424D7605000000000000360000002800000015000000150000000100
            18000000000040050000120B0000120B00000000000000000000F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F073F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F069F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F00DF0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F02CF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0FCFBF8F0F0
            F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F074F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0947D5DF0F0F0927C5E927C5E927C5EF0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F067F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F024F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F078F0F0F0F0F0F0
            F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F069F0F0F0F0F0F0
            F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5EF0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F00AF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5EF0F0F0927C5EF0F0F0F0F0F0F0F0F074F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0927C5EF0F0F0F0F0F0F0F0F06FF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0927C5E927C5E927C5E927C5E927C5E927C
            5E927C5E927C5E927C5E927C5E927C5EF0F0F0F0F0F0F0F0F077F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F009F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F05FF0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0
            F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F044}
          OnClick = sbWeekAllOffClick
        end
        object chbWeek1: TCheckBox
          Left = 14
          Top = 35
          Width = 107
          Height = 17
          Caption = #1055#1086#1085#1077#1076#1077#1083#1100#1085#1080#1082
          TabOrder = 0
        end
        object chbWeek2: TCheckBox
          Left = 14
          Top = 58
          Width = 107
          Height = 17
          Caption = #1042#1090#1086#1088#1085#1080#1082
          TabOrder = 1
        end
        object chbWeek3: TCheckBox
          Left = 14
          Top = 81
          Width = 107
          Height = 17
          Caption = #1057#1088#1077#1076#1072
          TabOrder = 2
        end
        object chbWeek4: TCheckBox
          Left = 127
          Top = 35
          Width = 107
          Height = 17
          Caption = #1063#1077#1090#1074#1077#1088#1075
          TabOrder = 3
        end
        object chbWeek5: TCheckBox
          Left = 127
          Top = 58
          Width = 107
          Height = 17
          Caption = #1055#1103#1090#1085#1080#1094#1072
          TabOrder = 4
        end
        object chbWeek6: TCheckBox
          Left = 127
          Top = 81
          Width = 107
          Height = 17
          Caption = #1057#1091#1073#1073#1086#1090#1072
          TabOrder = 5
        end
        object chbWeek7: TCheckBox
          Left = 217
          Top = 35
          Width = 107
          Height = 17
          Caption = #1042#1086#1089#1082#1088#1077#1089#1077#1085#1100#1077
          TabOrder = 6
        end
      end
      object cmbTipTask: TComboBox
        Left = 131
        Top = 8
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = #1045#1078#1077#1076#1085#1077#1074#1085#1086
        OnChange = cmbTipTaskChange
        Items.Strings = (
          #1045#1078#1077#1076#1085#1077#1074#1085#1086
          #1045#1078#1077#1085#1077#1076#1077#1083#1100#1085#1086
          #1045#1078#1077#1084#1077#1089#1103#1095#1085#1086)
      end
      object txtTimeTask: TTimePicker
        Left = 383
        Top = 8
        Width = 68
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        TabOrder = 1
        Time = 44914.700385277780000000
        TimeFormat = 'h:nn'
      end
    end
    object tabCrypt: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1072#1088#1093#1080#1074#1072
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 481
        Height = 203
        Align = alClient
        Brush.Color = clBtnFace
        ExplicitHeight = 185
      end
      object Label5: TLabel
        Left = 26
        Top = 11
        Width = 59
        Height = 15
        Caption = #1040#1088#1093#1080#1074#1072#1090#1086#1088
      end
      object Label6: TLabel
        Left = 210
        Top = 11
        Width = 116
        Height = 15
        Caption = #1057#1090#1077#1087#1077#1085#1100' '#1082#1086#1084#1087#1088#1077#1089#1089#1080#1080
      end
      object lblCryptWord1: TLabel
        Left = 26
        Top = 89
        Width = 45
        Height = 15
        Caption = #1055#1072#1088#1086#1083#1100' '
        Visible = False
      end
      object lblCryptWord2: TLabel
        Left = 210
        Top = 89
        Width = 87
        Height = 15
        Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
        Visible = False
      end
      object cmbFormatZip: TComboBox
        Left = 26
        Top = 32
        Width = 137
        Height = 23
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'zip'
        Items.Strings = (
          'zip'
          '7zip')
      end
      object cmbCompressZip: TComboBox
        Left = 210
        Top = 32
        Width = 153
        Height = 23
        Style = csDropDownList
        ItemIndex = 3
        MaxLength = 2
        TabOrder = 1
        Text = #1085#1086#1088#1084#1072#1083#1100#1085#1072#1103
        Items.Strings = (
          #1073#1077#1079' '#1089#1078#1072#1090#1080#1103
          #1089#1082#1086#1088#1086#1089#1090#1085#1072#1103
          #1073#1099#1089#1090#1088#1072#1103
          #1085#1086#1088#1084#1072#1083#1100#1085#1072#1103
          #1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103
          #1091#1083#1100#1090#1088#1072)
      end
      object chbCryptZip: TCheckBox
        Left = 26
        Top = 67
        Width = 137
        Height = 17
        Caption = #1064#1080#1092#1088#1086#1074#1072#1090#1100' '#1072#1088#1093#1080#1074
        TabOrder = 2
        OnClick = chbCryptZipClick
      end
      object chbCryptFileName: TCheckBox
        Left = 210
        Top = 67
        Width = 201
        Height = 17
        Caption = #1064#1080#1092#1088#1086#1074#1072#1090#1100' '#1080#1084#1077#1085#1072' '#1092#1072#1081#1083#1086#1074
        TabOrder = 3
        Visible = False
      end
      object txtCryptWord1: TEdit
        Left = 26
        Top = 109
        Width = 153
        Height = 23
        MaxLength = 100
        PasswordChar = '*'
        TabOrder = 4
        Visible = False
        OnExit = txtCryptWord1Exit
      end
      object txtCryptWord2: TEdit
        Left = 210
        Top = 109
        Width = 153
        Height = 23
        MaxLength = 100
        PasswordChar = '*'
        TabOrder = 5
        Visible = False
        OnExit = txtCryptWord1Exit
      end
    end
  end
  object btnSave: TButton
    Left = 288
    Top = 485
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 8
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 401
    Top = 485
    Width = 97
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = btnCancelClick
  end
  object chbOnTask: TCheckBox
    Left = 13
    Top = 489
    Width = 88
    Height = 17
    TabStop = False
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 10
  end
  object txtKolCopy: TNumberBox
    Left = 162
    Top = 452
    Width = 45
    Height = 23
    Alignment = taRightJustify
    Decimal = 0
    MinValue = 1.000000000000000000
    MaxValue = 10.000000000000000000
    TabOrder = 7
    Value = 1.000000000000000000
    SpinButtonOptions.ArrowWidth = 10
    SpinButtonOptions.Placement = nbspCompact
  end
  object txtID: TEdit
    Left = 138
    Top = 487
    Width = 121
    Height = 23
    TabOrder = 11
    Visible = False
  end
  object txtLastStart: TEdit
    Left = 288
    Top = 443
    Width = 121
    Height = 23
    TabOrder = 12
    Visible = False
  end
  object SelectFolder: TFileOpenDialog
    DefaultFolder = 'c:\'
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders, fdoPathMustExist]
    Left = 208
  end
end
