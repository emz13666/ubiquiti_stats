unit MoveToStatss_oldThread;

interface
uses Windows, Classes, forms,snmpsend,asn1util;

type
  TMoveToStatss_oldThreadThread = class(TThread)
  private
    { Private declarations }
  protected
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



procedure TMoveToStatss_oldThreadThread.Execute;
var date_old: TDateTime; count_row: longint;
begin
  { Place thread code here }
  FreeOnTerminate := True;
  repeat
    Sleep(1200000);//20 minutes

    //в 8 утра перемещаем данные в stats_old, если еще не переместили
    if FormatDateTime('hh',now)='08' then

     with form1 do begin
       date_old:=date - 70;//70 days
       {Query1.Close;
       Query1.SQL.Text := 'select count(*) as cnt0 from statss where date <= '+QuotedStr(FormatDateTime('yyyy-mm-dd',date_old));
       try
         Query1.Open;
       except
         Query1.Close;
       end;
       count_row := Query1.FieldByName('cnt0').AsInteger;

       Query1.Close;

       if count_row=0 then continue;

       Query1.SQL.Text := 'Insert into statss_old(id_modem, date, mac_ap,signal_level, time,status,x,y) '+
         'select id_modem, date, mac_ap,signal_level, time,status,x,y from statss where date <= '+QuotedStr(FormatDateTime('yyyy-mm-dd',date_old));

       try Query1.ExecSQL;finally Query1.Close; end;}
       Query1.SQL.Text := 'delete from statss where date <= '+QuotedStr(FormatDateTime('yyyy-mm-dd',date_old));
       try Query1.ExecSQL; except ADOConnection1.Close;  end;
       Query1.Close;

     end;

  until Terminated;
end;

end.

