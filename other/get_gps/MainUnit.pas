unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellAPI, DBXpress, Provider, SqlExpr, DB, DBClient,
  DBLocal, DBLocalS, Grids, DBGrids, TTDBGrid, FMTBcd, ExtCtrls, RXShell,MyTimer,
  ADODB;

type
  TForm1 = class(TForm)
    dsgps: TDataSource;
    qrygps: TADOQuery;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    RxTrayIcon1: TRxTrayIcon;
    Label2: TLabel;
    Label6: TLabel;
    LShiftName: TLabel;
    Lstatus: TLabel;
    LRunningTime: TLabel;
    qrystat: TADOQuery;
    Label3: TLabel;
    lcount: TLabel;
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


procedure TForm1.RxTrayIcon1DblClick(Sender: TObject);
begin
  RxTrayIcon1.Active := false;
  ShowWindow(Application.Handle,SW_SHOW);
  ShowWindow(Handle,SW_SHOW);
  Application.Restore;
  Application.BringToFront;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FileName :TSearchRec;

  r :integer;

begin
     r := FindFirst('gps*.dat',faAnyFile,FileName);
     if r = 0 then DeleteFile(FileName.Name);
     while (FindNext(FileName) = 0) do DeleteFile(FileName.Name);
  Application.OnMinimize := Hide_appl;
  MyTimerThread := TMyTimerThread.Create(false);
  //  оличество смен, котрые необходимо просматривать в обратную сторону, начина€ с текущей
  // —ейчас просматриваютс€ текуща€ и предыдуща€.
  MyTimer.shiftcount:=2;
  MyTimer.sleeptime:=3600000;
  MyTimer.netFolderName:='\\10.70.121.3\lgk\';
end;

procedure TForm1.Hide_appl(Sender: TObject);
begin
  RxTrayIcon1.Active := true;
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
     var

  FileName :TSearchRec;

  r :integer;

begin
     if Action=cafree then FormDestroy(sender);
     
     r := FindFirst('*.dat',faAnyFile,FileName);

     if r = 0 then DeleteFile(FileName.Name);

     while (FindNext(FileName) = 0) do DeleteFile(FileName.Name);
end;

end.

