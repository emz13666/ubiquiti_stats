unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, Provider, SqlExpr, FMTBcd, StdCtrls, DB, DBClient,
  DBLocal, DBLocalS;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    Stats: TSQLClientDataSet;
    Query1: TSQLQuery;
    Button1: TButton;
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
var i,j: longword;
begin
  for j:=1 to 27 do
  begin
    Stats.CommandText := 'select id, date_time from stats where DAYOFMONTH(date_time)='+IntToStr(j)+' and (time is NULL)';
    Stats.Open;
    i := Stats.RecordCount;
    Button1.Caption := IntToStr(j)+'-'+IntToStr(i);
    while not Stats.Eof do
    begin
      i := i-1;
      Button1.Caption := IntToStr(j)+'-'+IntToStr(i);
      Query1.Close;
      Query1.SQL.Text := 'Update stats set Day='+FormatDateTime('d',Stats.FieldByName('date_time').AsDateTime)+',Month='+
         FormatDateTime('m',Stats.FieldByName('date_time').AsDateTime)+',year='+FormatDateTime('yyyy',Stats.FieldByName('date_time').AsDateTime)+
         ',time='+QuotedStr(FormatDateTime('hh:nn:ss',Stats.FieldByName('date_time').AsDateTime))+' where id='+Stats.fieldByName('id').AsString;
      Query1.ExecSQL(true);
      Application.ProcessMessages;
      Stats.Next;
    end;
    Stats.Close;
  end;
end;

end.
