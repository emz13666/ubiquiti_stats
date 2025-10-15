object Form1: TForm1
  Left = 192
  Top = 114
  Width = 979
  Height = 563
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 288
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'MSConnection'
    DriverName = 'MYSQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbexpmysql.dll'
    LoginPrompt = False
    Params.Strings = (
      'BlobSize=-1'
      'Database=ubiquiti'
      'DriverName=MYSQL'
      'ErrorResourceFile='
      'HostName=10.70.20.11'
      'LocaleCode=0000'
      'Password=~ Dig123'
      'User_Name=root')
    VendorLib = 'LIBMYSQL.dll'
    Left = 136
    Top = 64
  end
  object Query: TSQLQuery
    SQLConnection = SQLConnection1
    Params = <>
    Left = 184
    Top = 176
  end
  object Query2: TSQLClientDataSet
    Aggregates = <>
    Options = [poAllowCommandText]
    ObjectView = True
    Params = <>
    DBConnection = SQLConnection1
    Left = 240
    Top = 40
  end
end
