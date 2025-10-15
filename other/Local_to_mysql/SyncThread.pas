unit SyncThread;

interface
uses Windows, Classes, forms,snmpsend,asn1util;

type
  TMySyncThread = class(TThread)
  private
    { Private declarations }
    rec_count_local_statss: longint;
    id_statss_local, id_modem_statss_local: longint;
     mac_ap_statss_local, date_statss_local, time_statss_local: string;
     sig_lev_statss_local, f_online_statss_local: integer;
     flag_ok: boolean;
  protected
    Procedure DoWork;
    procedure GetCountLocalStatss;
    procedure GetStatss_local;
    procedure PutToMySQL;
    procedure DeleteFromStatsLocal;
    procedure Execute; override;

  public
  end;



implementation

uses SysUtils, MainUnit;

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TMyTimerThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }


procedure TMySyncThread.DeleteFromStatsLocal;
begin
    Form1.statss_local.First;
    if Form1.statss_local.Locate('id',id_statss_local,[]) then Form1.statss_local.Delete;
end;

procedure TMySyncThread.DoWork;
var t1: cardinal;
begin
  t1 := GetTickCount;
  Synchronize(GetCountLocalStatss);
  with Form1 do
    while (rec_count_local_statss>0)and(GetTickCount-t1 < 25000) do
    begin
       Synchronize(GetStatss_local);
       Synchronize (PutToMySQL);
       Synchronize(DeleteFromStatsLocal);
       Synchronize(GetCountLocalStatss);
    end;
end;


procedure TMySyncThread.Execute;
begin
  { Place thread code here }
  FreeOnTerminate := True;
  repeat
    DoWork;
    Sleep(5000);
  until Terminated;
end;




procedure TMySyncThread.GetCountLocalStatss;
begin
  rec_count_local_statss := Form1.statss_local.RecordCount;
  Form1.Label4.Caption := IntToStr(rec_count_local_statss);
end;

procedure TMySyncThread.GetStatss_local;
begin
  with form1 do
  begin
    statss_local.first;
    id_statss_local := statss_localid.AsInteger;
    id_modem_statss_local := statss_localid_modem.AsInteger;
    sig_lev_statss_local := statss_localsignal_level.AsInteger;
    date_statss_local := FormatDateTime('yyyy-mm-dd',statss_localdate.AsDateTime);
    time_statss_local := FormatDateTime('hh:nn:ss',statss_localtime.AsDateTime);
    mac_ap_statss_local := statss_localmac_ap.AsString;
  end;
end;

procedure TMySyncThread.PutToMySQL;
begin
  with form1 do
  begin
    Query.Close;
    Query.SQL.Text := 'Insert into statss(id_modem, date, mac_ap,signal_level, time) values('+
            IntToStr(id_modem_statss_local)+','+
            QuotedStr(date_statss_local)+','+
            QuotedStr(mac_ap_statss_local)+','+
            QuotedStr(IntToStr(sig_lev_statss_local))+','+
            QuotedStr(time_statss_local)+')';
    flag_ok := true;
    try
      Query.ExecSQL;
    except
      ADOConnection1.Close;
      flag_ok := false;
    end;
    Query.Close;

 end;
end;

end.

