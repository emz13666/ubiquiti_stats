object Form1: TForm1
  Left = 270
  Top = 150
  Width = 1037
  Height = 464
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
    Left = 136
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 448
    Top = 32
    Width = 513
    Height = 273
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 344
    Top = 216
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=mysql' +
      '_ubiquiti'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 120
    Top = 32
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 232
    Top = 64
  end
end
