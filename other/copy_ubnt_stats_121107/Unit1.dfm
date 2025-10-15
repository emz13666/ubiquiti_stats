object Form1: TForm1
  Left = 232
  Top = 145
  Width = 979
  Height = 780
  Caption = 'Ubiquiti Statistics (C) EMZ ('#1045#1074#1075#1077#1085#1080#1081' '#1052#1080#1093#1072#1081#1083#1086#1074#1080#1095' '#1047#1080#1085#1086#1074#1100#1077#1074')'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 483
    Width = 971
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 486
    Width = 971
    Height = 260
    Align = alBottom
    TabOrder = 0
    object Chart1: TChart
      Left = 1
      Top = 33
      Width = 969
      Height = 226
      AnimatedZoomSteps = 6
      BackWall.Brush.Color = clWhite
      BackWall.Brush.Style = bsClear
      MarginTop = 0
      Title.Text.Strings = (
        'TChart')
      OnClickSeries = Chart1ClickSeries
      View3D = False
      Align = alClient
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object Series1: TPointSeries
        ColorEachPoint = True
        Marks.ArrowLength = 8
        Marks.BackColor = clWhite
        Marks.Font.Charset = DEFAULT_CHARSET
        Marks.Font.Color = clBlack
        Marks.Font.Height = -8
        Marks.Font.Name = 'Arial'
        Marks.Font.Style = []
        Marks.Visible = False
        SeriesColor = clRed
        ShowInLegend = False
        Pointer.InflateMargins = False
        Pointer.Style = psCircle
        Pointer.Visible = True
        XValues.DateTime = True
        XValues.Name = 'X'
        XValues.Multiplier = 1
        XValues.Order = loAscending
        YValues.DateTime = False
        YValues.Name = 'Y'
        YValues.Multiplier = 1
        YValues.Order = loNone
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 969
      Height = 32
      Align = alTop
      TabOrder = 1
      object Label3: TLabel
        Left = 427
        Top = 11
        Width = 74
        Height = 13
        Caption = #1050#1042#1040#1056#1062#1048#1058#1053#1040#1071
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        OnDblClick = Label3DblClick
      end
      object Label4: TLabel
        Left = 521
        Top = 11
        Width = 22
        Height = 13
        Caption = #1043#1041#1052
        Color = 808080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 193
        Top = 11
        Width = 97
        Height = 13
        Caption = #1044#1048#1057#1055#1045#1058#1063#1045#1056#1057#1050#1040#1071
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 312
        Top = 11
        Width = 98
        Height = 13
        Caption = #1055#1054#1044#1057#1058#1040#1053#1062#1048#1071' '#8470'9'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 7
        Top = 10
        Width = 164
        Height = 13
        Caption = #1052#1054#1041#1048#1051#1068#1053#1067#1049' '#1056#1045#1058#1056#1040#1053#1057#1051#1071#1058#1054#1056
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object ProgressBar1: TProgressBar
        Left = 592
        Top = 8
        Width = 369
        Height = 17
        Min = 0
        Max = 100
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 571
        Top = 7
        Width = 17
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 483
    Align = alClient
    TabOrder = 1
    object Splitter3: TSplitter
      Left = 669
      Top = 1
      Width = 3
      Height = 481
      Cursor = crHSplit
      Align = alRight
    end
    object Panel4: TPanel
      Left = 672
      Top = 1
      Width = 298
      Height = 481
      Align = alRight
      TabOrder = 0
      object Button2: TButton
        Left = 88
        Top = 376
        Width = 105
        Height = 25
        Caption = #1043#1088#1072#1092#1080#1082' '#1074' EXCEL'
        TabOrder = 0
        OnClick = EXCEL1Click
      end
      object Button1: TButton
        Left = 8
        Top = 376
        Width = 75
        Height = 25
        Caption = #1057#1090#1088#1086#1080#1090#1100
        TabOrder = 1
        OnClick = Button1Click
      end
      object MonthCalendar1: TMonthCalendar
        Left = 56
        Top = 8
        Width = 169
        Height = 169
        Date = 41178.6017552778
        TabOrder = 2
      end
      object CheckBox1: TCheckBox
        Left = 56
        Top = 208
        Width = 161
        Height = 17
        Caption = #1057#1090#1088#1086#1080#1090#1100' '#1079#1072' '#1074#1077#1089#1100' '#1087#1077#1088#1080#1086#1076
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object GroupBox1: TGroupBox
        Left = 40
        Top = 232
        Width = 225
        Height = 89
        TabOrder = 4
        object Label5: TLabel
          Left = 12
          Top = 37
          Width = 6
          Height = 13
          Caption = #1089
        end
        object Label6: TLabel
          Left = 6
          Top = 67
          Width = 12
          Height = 13
          Caption = #1087#1086
        end
        object CheckBox3: TCheckBox
          Left = 25
          Top = 11
          Width = 136
          Height = 17
          Caption = #1057#1090#1088#1086#1080#1090#1100' '#1079#1072' '#1087#1077#1088#1080#1086#1076
          TabOrder = 0
          OnClick = CheckBox3Click
        end
        object DateTimePicker1: TDateTimePicker
          Left = 22
          Top = 33
          Width = 84
          Height = 20
          CalAlignment = dtaLeft
          Date = 41178.8715084259
          Time = 41178.8715084259
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 1
          OnChange = DateTimePicker1Change
        end
        object DateTimePicker2: TDateTimePicker
          Left = 21
          Top = 65
          Width = 86
          Height = 20
          CalAlignment = dtaLeft
          Date = 41178.8715084259
          Time = 41178.8715084259
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkDate
          ParseInput = False
          TabOrder = 2
          OnChange = DateTimePicker1Change
        end
        object DateTimePicker3: TDateTimePicker
          Left = 120
          Top = 32
          Width = 57
          Height = 21
          CalAlignment = dtaLeft
          Date = 41188
          Format = 'HH:mm'
          Time = 41188
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkTime
          ParseInput = False
          TabOrder = 3
          OnChange = DateTimePicker1Change
        end
        object DateTimePicker4: TDateTimePicker
          Left = 120
          Top = 63
          Width = 58
          Height = 21
          CalAlignment = dtaLeft
          Date = 41188.9999884259
          Format = 'HH:mm'
          Time = 41188.9999884259
          DateFormat = dfShort
          DateMode = dmComboBox
          Kind = dtkTime
          ParseInput = False
          TabOrder = 4
          OnChange = DateTimePicker1Change
        end
      end
      object btnMAC: TButton
        Left = 200
        Top = 376
        Width = 89
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' MAC'
        Enabled = False
        TabOrder = 5
        OnClick = btnMACClick
      end
      object Button3: TButton
        Left = 104
        Top = 336
        Width = 75
        Height = 25
        Caption = 'MAC ACL'
        Enabled = False
        TabOrder = 6
        OnClick = Button3Click
      end
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 416
        Width = 113
        Height = 58
        Caption = #1055#1086#1082#1072#1079#1072#1090#1100
        ItemIndex = 0
        Items.Strings = (
          #1042#1089#1077' '#1084#1086#1076#1077#1084#1099
          #1042#1089#1077' '#1056#1058#1061)
        TabOrder = 7
        OnClick = RadioGroup1Click
      end
      object Button4: TButton
        Left = 176
        Top = 432
        Width = 105
        Height = 25
        Caption = #1058#1072#1073#1083#1080#1094#1091' '#1074' EXCEL'
        TabOrder = 8
        OnClick = Button4Click
      end
      object CheckBox4: TCheckBox
        Left = 57
        Top = 184
        Width = 120
        Height = 17
        Caption = #1040#1074#1090#1086#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
        Checked = True
        State = cbChecked
        TabOrder = 9
        OnClick = CheckBox4Click
      end
      object Button5: TButton
        Left = 192
        Top = 464
        Width = 75
        Height = 25
        Caption = 'avg_table'
        TabOrder = 10
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 192
        Top = 336
        Width = 75
        Height = 25
        Caption = 'ARP Script'
        Enabled = False
        TabOrder = 11
        OnClick = Button6Click
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 668
      Height = 481
      Align = alClient
      TabOrder = 1
      object ToolTipsDBGrid1: TToolTipsDBGrid
        Left = 1
        Top = 1
        Width = 666
        Height = 479
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = ToolTipsDBGrid1DrawColumnCell
        OnDblClick = ToolTipsDBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #1048#1084#1103
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ip_address'
            Title.Caption = 'IP '#1084#1086#1076#1077#1084#1072
            Width = 91
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'mac_address'
            Title.Caption = 'MAC '#1084#1086#1076#1077#1084#1072
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'place_install'
            Title.Caption = #1052#1077#1089#1090#1086' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
            Width = 122
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'power'
            Title.Caption = #1052#1086#1097#1072', dBm'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prim'
            Title.Caption = #1055#1088#1080#1084'. '#1084#1086#1076#1077#1084
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'serial'
            Title.Caption = 'PTX s/n'
            Width = 131
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ip_address_1'
            Title.Caption = 'IP PTX'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'mac_address_1'
            Title.Caption = 'mac_ptx'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'os_ver'
            Title.Caption = 'PTX OS_VER'
            Width = 133
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dispatch_ver'
            Title.Caption = 'PTX Dispatch_Ver'
            Width = 131
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'oem_driver_ver'
            Title.Caption = 'PTX OEM_Driver_ver'
            Width = 141
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'prim_1'
            Title.Caption = #1055#1088#1080#1084'. PTX'
            Width = 163
            Visible = True
          end>
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Modems
    Left = 112
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 112
    object C1: TMenuItem
      Caption = 'C'#1090#1088#1086#1080#1090#1100
      OnClick = C1Click
    end
    object N1: TMenuItem
      Caption = #1055#1077#1088#1077#1088#1080#1089#1086#1074#1072#1090#1100
      OnClick = N1Click
    end
    object Updatemac1: TMenuItem
      Caption = 'Update mac'
      OnClick = Updatemac1Click
    end
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 344
    Top = 88
  end
  object DBConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=mysql' +
      '_ubiquiti'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 112
    Top = 112
  end
  object Query_3: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 248
    Top = 168
  end
  object Modems: TADOQuery
    Connection = DBConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select * from modems as t1 LEFT OUTER JOIN ptx as t2 ON t1.id_mo' +
        'dem=t2.id_modem')
    Left = 232
    Top = 304
    object Modemsid_modem: TLargeintField
      FieldName = 'id_modem'
      ReadOnly = True
    end
    object Modemsis_access_point: TSmallintField
      FieldName = 'is_access_point'
    end
    object Modemsname: TWideStringField
      FieldName = 'name'
      Size = 50
    end
    object Modemsip_address: TWideStringField
      FieldName = 'ip_address'
      Size = 50
    end
    object Modemsmac_address: TWideStringField
      FieldName = 'mac_address'
      Size = 50
    end
    object Modemsplace_install: TWideStringField
      FieldName = 'place_install'
      Size = 255
    end
    object Modemspower: TSmallintField
      FieldName = 'power'
    end
    object Modemsprim: TWideStringField
      FieldName = 'prim'
      Size = 255
    end
    object Modemscolor: TLargeintField
      FieldName = 'color'
    end
    object Modemsonline: TSmallintField
      FieldName = 'online'
    end
    object Modemsid_ptx: TLargeintField
      FieldName = 'id_ptx'
      ReadOnly = True
    end
    object Modemsid_modem_1: TLargeintField
      FieldName = 'id_modem_1'
    end
    object Modemsserial: TWideStringField
      FieldName = 'serial'
    end
    object Modemsip_address_1: TWideStringField
      FieldName = 'ip_address_1'
      Size = 15
    end
    object Modemsos_ver: TWideStringField
      FieldName = 'os_ver'
      Size = 50
    end
    object Modemsdispatch_ver: TWideStringField
      FieldName = 'dispatch_ver'
      Size = 50
    end
    object Modemsoem_driver_ver: TWideStringField
      FieldName = 'oem_driver_ver'
      Size = 50
    end
    object Modemsprim_1: TWideStringField
      FieldName = 'prim_1'
      Size = 255
    end
    object Modemsmac_address_1: TWideStringField
      FieldName = 'mac_address_1'
    end
  end
  object modems_avg: TADOQuery
    Connection = DBConnection
    OnCalcFields = modems_avg1CalcFields
    Parameters = <>
    SQL.Strings = (
      
        'select * from modems as t1 LEFT OUTER JOIN ptx as t2 ON t1.id_mo' +
        'dem=t2.id_modem')
    Left = 232
    Top = 380
    object LargeintField1: TLargeintField
      FieldName = 'id_modem'
      ReadOnly = True
    end
    object SmallintField1: TSmallintField
      FieldName = 'is_access_point'
    end
    object WideStringField1: TWideStringField
      FieldName = 'name'
      Size = 50
    end
    object WideStringField2: TWideStringField
      FieldName = 'ip_address'
      Size = 50
    end
    object WideStringField3: TWideStringField
      FieldName = 'mac_address'
      Size = 50
    end
    object WideStringField4: TWideStringField
      FieldName = 'place_install'
      Size = 255
    end
    object SmallintField2: TSmallintField
      FieldName = 'power'
    end
    object WideStringField5: TWideStringField
      FieldName = 'prim'
      Size = 255
    end
    object LargeintField2: TLargeintField
      FieldName = 'color'
    end
    object SmallintField3: TSmallintField
      FieldName = 'online'
    end
    object LargeintField3: TLargeintField
      FieldName = 'id_ptx'
      ReadOnly = True
    end
    object LargeintField4: TLargeintField
      FieldName = 'id_modem_1'
    end
    object WideStringField6: TWideStringField
      FieldName = 'serial'
    end
    object WideStringField7: TWideStringField
      FieldName = 'ip_address_1'
      Size = 15
    end
    object WideStringField8: TWideStringField
      FieldName = 'os_ver'
      Size = 50
    end
    object WideStringField9: TWideStringField
      FieldName = 'dispatch_ver'
      Size = 50
    end
    object WideStringField10: TWideStringField
      FieldName = 'oem_driver_ver'
      Size = 50
    end
    object WideStringField11: TWideStringField
      FieldName = 'prim_1'
      Size = 255
    end
    object WideStringField12: TWideStringField
      FieldName = 'mac_address_1'
    end
    object modems_avgavg_signal: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'avg_signal'
      Calculated = True
    end
  end
  object Query: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 392
    Top = 192
  end
  object DataSource2: TDataSource
    DataSet = Query
    Left = 352
    Top = 168
  end
end
