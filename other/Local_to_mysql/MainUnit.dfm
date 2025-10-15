object Form1: TForm1
  Left = 462
  Top = 179
  Width = 761
  Height = 461
  Caption = 'Local_To_Mysql'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 400
    Width = 69
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1089#1090#1088#1086#1082':'
  end
  object Label2: TLabel
    Left = 88
    Top = 401
    Width = 18
    Height = 13
    Caption = '000'
  end
  object Label3: TLabel
    Left = 192
    Top = 400
    Width = 122
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1074' '#1083#1086#1082#1072#1083#1100#1085#1086#1081' '#1041#1044':'
  end
  object Label4: TLabel
    Left = 326
    Top = 401
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Button1: TButton
    Left = 456
    Top = 394
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 753
    Height = 385
    Align = alTop
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Query: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 200
    Top = 296
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=mysql' +
      '_ubiquiti'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 136
    Top = 240
  end
  object statss_local: TClientDataSet
    Aggregates = <>
    FileName = 'Z:\projects\ubiquiti_stats\sbor_stats\statss_local.cds'
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faReadonly]
        DataType = ftAutoInc
      end
      item
        Name = 'id_modem'
        DataType = ftInteger
      end
      item
        Name = 'mac_ap'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'signal_level'
        DataType = ftSmallint
      end
      item
        Name = 'date'
        DataType = ftDate
      end
      item
        Name = 'time'
        DataType = ftTime
      end
      item
        Name = 'status'
        DataType = ftSmallint
      end
      item
        Name = 'x'
        DataType = ftSmallint
      end
      item
        Name = 'y'
        DataType = ftSmallint
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 160
    object statss_localid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object statss_localid_modem: TIntegerField
      FieldName = 'id_modem'
    end
    object statss_localmac_ap: TWideStringField
      FieldName = 'mac_ap'
    end
    object statss_localsignal_level: TSmallintField
      FieldName = 'signal_level'
    end
    object statss_localdate: TDateField
      FieldName = 'date'
    end
    object statss_localtime: TTimeField
      FieldName = 'time'
    end
    object statss_localstatus: TSmallintField
      FieldName = 'status'
    end
    object statss_localx: TSmallintField
      FieldName = 'x'
    end
    object statss_localy: TSmallintField
      FieldName = 'y'
    end
  end
end
