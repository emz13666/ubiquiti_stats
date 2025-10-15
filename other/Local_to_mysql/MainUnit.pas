unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, DBXpress, Provider, SqlExpr, DB, DBClient,
  DBLocal, DBLocalS, Grids, DBGrids, TTDBGrid, FMTBcd, ExtCtrls, RXShell,
  ADODB, SyncThread;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Query: TADOQuery;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    Label2: TLabel;
    statss_local: TClientDataSet;
    statss_localid: TAutoIncField;
    statss_localid_modem: TIntegerField;
    statss_localmac_ap: TWideStringField;
    statss_localsignal_level: TSmallintField;
    statss_localdate: TDateField;
    statss_localtime: TTimeField;
    statss_localstatus: TSmallintField;
    statss_localx: TSmallintField;
    statss_localy: TSmallintField;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Win_Exec_wait(cmd_line:string);

function GetWord2Eq(s: string):string;

var
  Form1: TForm1;
  MySyncThread: TMySyncThread;
  ArrayID: TStringList;

implementation

{$R *.dfm}
procedure Win_Exec_wait(cmd_line:string);
var ExecInfo: TShellExecuteInfo;
begin
  ZeroMemory(@ExecInfo, sizeOf(ExecInfo));
  with ExecInfo do
  begin
    cbSize := sizeOf(ExecInfo);
    lpVerb := 'open';
    lpFile := PChar(ExtractFilePath(Application.ExeName)+ cmd_line);
    lpParameters := '';
    nShow := SW_HIDE;
    fMask := SEE_MASK_NOCLOSEPROCESS;
  end;

  ShellExecuteEx(@ExecInfo);
  WaitForSingleObject(ExecInfo.hProcess, {INFINITE}5000);
  CloseHandle(ExecInfo.hProcess);
end;

function GetFirstWord(s: string):string;
var i:byte;
begin
  i:=1;
  Result :='';
  while (s[i]<>' ')and(i<Length(s)) do begin Result:=Result+s[i]; inc(i); end;
end;

function GetWord2Eq(s: string):string;
var i:byte;
begin
  i:=1;
  //ищем знак =
  while (s[i]<>'=')and(i<Length(s)) do inc(i);
  //ищем второй знак =
  inc(i);
  while (s[i]<>'=')and(i<Length(s)) do inc(i);
  inc(i);
  Result :='';
  while (s[i]<>' ')and(i<Length(s)) do begin Result:=Result+s[i]; inc(i); end;
end;



procedure Oem2Ansi(st: TStringList);
var i: byte;
    N: PChar;

begin
  for i:=0 to st.Count-1 do
  begin
   if st[i]='' then  Continue;
    n := PChar(st[i]);
    OemToAnsi(n,n);
    st[i]:=n;
  end;
end;

(*procedure TForm1.Timer1Timer(Sender: TObject);
var
//  f: TSearchRec;
  File_name,s1,s3,s4:string;
 // f1:TextFile;
  buf: TStringList;
begin
//for debug
//Timer1.Enabled:=False;   exit;

while ArrayID.Count>7 do
begin
  try
    Memo1.Lines.Clear;
    DataSource1.DataSet := nil;
    SQLClientDataSet2.Open;
    SQLClientDataSet2.First;
  except
    SQLClientDataSet2.Close;
    Break;
  end;
  while not SQLClientDataSet2.Eof do
  begin
    File_name :=ExtractFilePath(Application.ExeName)+StringReplace(SQLClientDataSet2ip_address.AsString,'.','_',[rfReplaceAll])+'.'+ArrayID[0];
    if FileExists(File_name) then
    begin
       buf := TStringList.Create;
       try
       buf.LoadFromFile(File_name);
       Oem2Ansi(buf);
       DeleteFile(File_name);
       //дата и время
       s1 := buf[0];

       if GetFirstWord(buf[7])='Ответ' then
       begin
         //17 последних символов  - мак адрес точки доступа
         s3 := trim(Buf[20]);
         s3 := copy(s3,Length(s3)-16,17);
         s4 := buf[25];
         //берем слово после второго знака= Это уровень сигнала
         s4 := GetWord2Eq(s4);
         Memo1.Lines.Add(s1+' '+SQLClientDataSet2ip_address.AsString+' '+s3+' '+s4);
         Query.Close;
         Query.SQL.Text := 'Insert into stats(id_modem,date_time,mac_ap,signal_level) values('+SQLClientDataSet2id_modem.AsString+
           ','+QuotedStr(s1)+','+QuotedStr(s3)+','+s4+')';
         Query.ExecSQL;
         Query.Close;
         Query.SQL.Text := 'Update modems set online=1 where id_modem='+SQLClientDataSet2id_modem.AsString;
         Query.ExecSQL;
         Query.Close;
       end
       else
       begin
         s3 := '00:00:00:00:00:00';
         s4:='-100';
         Memo1.Lines.Add(s1+' '+SQLClientDataSet2ip_address.AsString+' '+s3+' '+s4);
         Query.Close;
         Query.SQL.Text := 'Insert into stats(id_modem,date_time,mac_ap,signal_level) values('+SQLClientDataSet2id_modem.AsString+
           ','+QuotedStr(s1)+','+QuotedStr(s3)+','+s4+')';
         Query.ExecSQL;
         Query.Close;
         Query.SQL.Text := 'Update modems set online=0 where id_modem='+SQLClientDataSet2id_modem.AsString;
         Query.ExecSQL;
         Query.Close;
       end;
       except
       end;
       buf.Free;
    end;
    SQLClientDataSet2.Next;
  end;
  SQLClientDataSet2.Close;
  ArrayID.Delete(0);
  DataSource1.DataSet := SQLClientDataSet2;
  DBConnection.Close;
end;
end; *)


procedure TForm1.FormCreate(Sender: TObject);
var i: byte;
begin
  statss_local.FileName := ExtractFilePath(Application.ExeName)+'statss_local.cds';
  statss_local.Open;
 // statss_local.LogChanges := false;
  ADOConnection1.Open;
  Label4.Caption := IntToStr(statss_local.RecordCount);


end;




procedure TForm1.FormDestroy(Sender: TObject);
var i: byte;
begin

if Assigned(MySyncThread) then
  begin
    MySyncThread.Terminate;
  end;
  statss_local.SaveToFile;
  statss_local.Close;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  MySyncThread := TMySyncThread.Create(true);
  statss_local.Open;
  MySyncThread.Resume;
end;

end.


