object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
  Height = 640
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
    Left = 344
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Go'
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
    Left = 152
    Top = 136
  end
  object Stats: TSQLClientDataSet
    Aggregates = <>
    Options = [poAllowCommandText]
    ObjectView = True
    Params = <>
    DBConnection = SQLConnection1
    Left = 216
    Top = 240
  end
  object Query1: TSQLQuery
    SQLConnection = SQLConnection1
    Params = <>
    Left = 216
    Top = 168
  end
end
