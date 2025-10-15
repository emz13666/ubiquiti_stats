unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, DBXpress, Provider, SqlExpr, DB, DBClient,
   Grids, DBGrids, TTDBGrid, FMTBcd, ExtCtrls, RXShell,MyTimer,
  ADODB;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Modems: TADOTable;
    Query: TADOQuery;
    ADOConnection1: TADOConnection;
    Modemsid_modem: TLargeintField;
    Modemsis_access_point: TSmallintField;
    Modemsname: TWideStringField;
    Modemsip_address: TWideStringField;
    Modemsmac_address: TWideStringField;
    Modemsplace_install: TWideStringField;
    Modemspower: TSmallintField;
    Modemsprim: TWideStringField;
    Modemscolor: TLargeintField;
    Modemsonline: TSmallintField;
    Label1: TLabel;
    lcount: TLabel;
    TrayIcon1: TTrayIcon;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    ADOConPowerView: TADOConnection;
    qryStatusEvents: TADOQuery;
    qryUpdate: TADOQuery;
    QModems: TADOQuery;
    procedure RxTrayIcon1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Hide_appl(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Win_Exec_wait(cmd_line:string);
function GetWord2Eq(s: string):string;

var
  Form1: TForm1;
  MyTimerThread: TMyTimerThread;
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



{procedure Oem2Ansi(st: TStringList);
var i: byte;
    N: PChar;
    n1:PANSIChar;

begin
  for i:=0 to st.Count-1 do
  begin
   if st[i]='' then  Continue;
    n := PChar(st[i]);
    OemToAnsi(n,n1);
    st[i]:=n1;
  end;
end;
 }

procedure TForm1.RxTrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := false;
  ShowWindow(Application.Handle,SW_SHOW);
  ShowWindow(Handle,SW_SHOW);
  Application.Restore;
  Application.BringToFront;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnMinimize := Hide_appl;
  MyTimerThread := TMyTimerThread.Create(false);
end;

procedure TForm1.Hide_appl(Sender: TObject);
begin
  TrayIcon1.Visible := true;
  Application.Minimize;
  //Application.ShowMainForm := false;
  ShowWindow(Application.Handle,SW_HIDE);
//  ShowWindow(Application.MainForm.Handle,SW_HIDE);
end;


procedure TForm1.FormActivate(Sender: TObject);
begin
  Hide_appl(@Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if Assigned(MyTimerThread) then
  begin
    try
        MyTimerThread.Terminate;
    except
    
    end;
  end;
end;



procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if Action=cafree then FormDestroy(sender);
end;

end.

