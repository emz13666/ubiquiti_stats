unit MyTimer;

interface
uses Classes, forms,snmpsend,asn1util, controls ;

type
  TMyTimerThread = class(TThread)
  private
    { Private declarations }
  protected
    Procedure DoWork;
    Procedure AddToBDB;
    procedure Execute; override;
  public

  end;

  var sleeptime:integer;

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

{ TMyTimerThread }
function convert_s(s: string):string;
var i: byte;
    ch: char;
begin
  if s='' then Result := ''
  else
  begin
    Result := '';
    for i:=1 to Length(s)-1 do
    begin
    ch := s[i];
    Result := Result+IntToHex(ord(ch),2)+':';
    end;
    ch := s[Length(s)];
    Result := Result+IntToHex(ord(ch),2);
  end;
end;

//‘ункци€ получени€ количества секунд, прошедших с начала смены по фактическому времени tm
function TimeToShiftSec(tm:TTime):integer;
var tm1:TTime;
begin
     if tm>=strtotime('7:30') then tm1:=tm-StrToTime('7:30') else tm1:=tm+StrToTime('4:30');
     if tm1>=StrToTime('12:00') then tm1:=tm1-StrToTime('12:00');
     // 86400 - количество секунд в сутках
     result:=round(tm1*86400);
end;

// ‘ункци€ дл€ определени€ номера смены по дате и времени
function DateToShift(dt:TDate; tm:TTime):integer;
var shift:integer;
begin
         shift:=round((int(dt)-int(strToDate('01.01.1970')))*2);
         if tm>=StrToTime('7:30') then shift:=shift+1;
         if tm>=StrToTime('19:30') then shift:=shift+1;
         result:=shift;
end;

procedure TMyTimerThread.AddToBDB;
var shift, sec, i,j : integer;
    eqmt:string;
    tm, starttm, endtm:TTime;
    tm1:TDateTime;
begin
  with Form1 do
  begin
      starttm:=Time;
      if Query.Active then Query.Active:=false;

      query.SQL.Clear;
      query.SQL.Add('select count(id) as num from statss where status=0');
      try
         query.Active:=true;
      except
      end;
      sleeptime:=60000;
      if query.fieldbyName('num').AsInteger>100000 then sleeptime:=40000;
      if query.fieldbyName('num').AsInteger>500000 then sleeptime:=30000;
      lcount.Caption:=query.fieldbyName('num').AsString;
      query.Active:=false;
      query.SQL.Clear;
      query.SQL.Add('select s.id, s.signal_level, s.date, s.time, s.status, m.name from statss s, modems m ');
      query.SQL.Add('where (s.status=0) and (s.id_modem=m.id_modem) order by s.date limit 0, 10000');
      try
         query.Active:=true;
      except
      end;
      query.First;
      i:=0;
      j:=0;
      try
      // ƒл€ каждой записи с нулевым статусом ищем статус
      while (not query.Eof) and (i<10000) do begin
         shift:=DateToShift(query.FieldByName('date').AsDateTime,strtotime(Query.FieldByName('time').AsString));
         //showmessage(Query.FieldByName('time').AsString+'   '+FloatToStr(strtotime(Query.FieldByName('time').AsString)));
         sec:=TimeToShiftSec(StrToTime(Query.FieldByName('time').AsString));
         eqmt:=Query.FieldByName('name').AsString;
         if (query.FieldByName('name').AsString='EX130') then begin
            if (query.FieldByName('date').AsDateTime<StrToDate('16.11.2012')) then eqmt:='EX128';
         end;
         if (query.FieldByName('name').AsString='EX139') then begin
            if (query.FieldByName('date').AsDateTime<StrToDate('19.02.2013')) then eqmt:='EX120';
         end;
         if qryStatusEvents.Active then qryStatusEvents.Active:=false;
         qryStatusEvents.SQL.Clear;
         qryStatusEvents.SQL.Add('select status from hist_statusevents');
         qryStatusEvents.SQL.Add('where (shiftindex='+inttostr(shift)+') and (eqmt='+#39+eqmt+#39+') ');
         qryStatusEvents.SQL.Add('and (starttime<='+inttostr(sec)+') and (endtime>='+inttostr(sec)+')');
         //memo1.Text:=qryStatusEvents.SQL.Text;
         //sleep(10000);
         qryStatusEvents.Open;
         qryStatusEvents.Last;
         // ≈сли статус нашелс€ в Powerview, то внести его в базу данных
         if qryStatusEvents.RecordCount>0 then begin
            inc(j);
            if qryUpdate.Active then qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('Update statss set status='+qryStatusEvents.fieldByName('status').AsString+' where id='+Query.fieldByName('id').AsString);
            qryUpdate.ExecSQL;
            qryUpdate.Close;
         end else begin
            // ≈сли статус не найден и давность записи более половины дн€, то записывать статус -1
            if ((now-strtodate(query.FieldByName('date').AsString)-strtotime(query.FieldByName('time').AsString))>0.5) then begin
               inc(j);
               if qryUpdate.Active then qryUpdate.Close;
               qryUpdate.SQL.Clear;
               qryUpdate.SQL.Add('Update statss set status=-1 where id='+Query.fieldByName('id').AsString);
               qryUpdate.ExecSQL;
               qryUpdate.Close;
            end;
         end;
         qryStatusEvents.Close;
         Query.Next;
         inc(i);
      end;
      except
      end; //конец try
      label4.Caption:=inttostr(strtoint(label4.Caption)+i);
      label5.Caption:=inttostr(strtoint(label5.Caption)+j);
      endtm:=Time;
      tm:=endtm-starttm;
      //ShowMessage('¬ыполнено за '+TimeToStr(tm));
  end;
end;

procedure TMyTimerThread.DoWork;
begin
   AddToBDB;
   //Synchronize(AddToBDB);
end;


procedure TMyTimerThread.Execute;
begin
  { Place thread code here }
  FreeOnTerminate := True;
  repeat
    DoWork;
    Sleep(sleeptime);
  until Terminated;
end;

end.

