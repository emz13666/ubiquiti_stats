unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Timer1: TTimer;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Timer1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Text := 'DELETE LOW_PRIORITY FROM `statss` WHERE date <''2014-01-01'' limit 10000';
  ADOQuery1.ExecSQL;
  Memo1.Lines.Add(FormatDateTime('hh:mm:ss',now)+'   '+inttostr(ADOQuery1.RowsAffected));
  if ADOQuery1.RowsAffected =0 then
  begin
    Memo1.Lines.Add('Done');
    Timer1.Enabled := false;
  end;
  ADOConnection1.Close;
end;

end.
