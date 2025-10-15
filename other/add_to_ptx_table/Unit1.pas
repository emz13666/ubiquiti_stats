unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, DB, SqlExpr, FMTBcd, StdCtrls, Provider, DBClient,
  DBLocal, DBLocalS;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    Button1: TButton;
    Query: TSQLQuery;
    Query2: TSQLClientDataSet;
    procedure Button1Click(Sender: TObject);
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
var i: byte;
begin
  with Query do
  begin
    for i:= 1 to 30 do
    begin
      Query2.Close;
      Query2.CommandText := 'Select id_modem from modems where ip_address='+QuotedStr('10.70.123.'+IntToStr(i));
      Query2.Open;
      Close;
      SQL.Text := 'insert into ptx(id_modem,ip_address) values('+Query2.Fields[0].AsString+',''10.70.122.'+Inttostr(i)+''')';
      ExecSQL;
      Close;
      Query2.Close;
    end;
    for i:= 60 to 81 do
    begin
      Query2.Close;
      Query2.CommandText := 'Select id_modem from modems where ip_address='+QuotedStr('10.70.123.'+IntToStr(i));
      Query2.Open;
      Close;
      SQL.Text := 'insert into ptx(id_modem,ip_address) values('+Query2.Fields[0].AsString+',''10.70.122.'+Inttostr(i)+''')';
      ExecSQL;
      Close;
      Query2.Close;
    end;
  end;
  ShowMessage('');
end;

end.
