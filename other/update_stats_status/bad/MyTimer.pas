unit MyTimer;

interface
uses Classes, forms,snmpsend,asn1util, controls, ActiveX, ScorpioDB ;

type
  TMyTimerThread = class(TThread)
  ModularModems:TStringList;  // Список идентификаторов модемов из БД Ubiquiti
  private
    { Private declarations }
    FProcessedCount:integer;
    FUpdatedCount:integer;
  protected
    procedure WriteStatuses(id_modem:integer);
    procedure getModularModems; // Получение списка модемов, которые стоят на самосвалах и экскаваторах
    function getCountUnknown:integer;   // Получение количества точек статистики с нулевыми значениями
    Procedure DoWork;
    Procedure AddToBDB;
    procedure Execute; override;
  public
    constructor Create(CreateSuspended:boolean);
    destructor Destroy;
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

//Функция получения количества секунд, прошедших с начала смены по фактическому времени tm
function TimeToShiftSec(tm:TTime):integer;
var tm1:TTime;
begin
     if tm>=strtotime('7:30') then tm1:=tm-StrToTime('7:30') else tm1:=tm+StrToTime('4:30');
     if tm1>=StrToTime('12:00') then tm1:=tm1-StrToTime('12:00');
     // 86400 - количество секунд в сутках
     result:=round(tm1*86400);
end;

// Функция для определения номера смены по дате и времени
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
    countUnknown:integer;
  k: integer;
begin
  with Form1 do
  begin
      starttm:=Time;
      try
        getModularModems;
        countUnknown:=getCountUnknown;
      except
        exit;
      end;
      lcount.Caption:=IntToStr(countUnknown);
      if countUnknown<0 then exit;
      sleeptime:=60000;
      if countUnknown>100000 then sleeptime:=40000;
      if countUnknown>500000 then sleeptime:=30000;
      k:=0;
      // Для каждого модема записываем статусы
      while k< ModularModems.Count do begin
           try
            WriteStatuses(strtoint(ModularModems[k]));
            label4.Caption:=inttostr(FProcessedCount);
            label5.Caption:=inttostr(FUpdatedCount);
           except
            exit;
           end;
           inc(k);
      end;
      endtm:=Time;
      tm:=endtm-starttm;
      //ShowMessage('Выполнено за '+TimeToStr(tm));
  end;
end;

constructor TMyTimerThread.Create(CreateSuspended:boolean);
begin
     inherited;
     CoInitialize(nil);
     ModularModems:=TStringList.Create;
     FProcessedCount:=0;
     FUpdatedCount:=0;
end;

destructor TMyTimerThread.Destroy;
begin
     FreeAndNil(ModularModems);
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
    Sleep(sleeptime);
    DoWork;
  until Terminated;
end;

function TMyTimerThread.getCountUnknown: integer;
var
  i: Integer;
  qry:TMyADOQuery;
  colcount:integer;
begin
    colcount:=0;
    try
       qry:=TMyADOQuery.Create(Form1,Form1.ADOConnection1);
       i:=0;
         while i< ModularModems.Count do begin
            if qry.Active then qry.Close;
            qry.SQL.Clear;
            qry.SQL.Add('select count(*) as col from statss where (id_modem='+ModularModems[i]+') and (status=0)');
            try
               qry.Open;
            except
               result:=-1;
               exit;
            end;
            colcount:=colcount+qry.FieldByName('col').AsInteger;
            inc(i);
         end;
         result:=colcount;
    finally
       FreeAndNil(qry);
    end;


end;

procedure TMyTimerThread.getModularModems;
var qry:TMyADOQuery;
begin
      ModularModems.Clear;
      try
        qry:=TMyADOQuery.Create(Form1,Form1.ADOConnection1);
          qry.SQL.Clear;
          // Получаем список модемов самосвалов и экскаваторов
          qry.SQL.Add('select m.id_modem from modems m, equipment e where (e.equipment_type in (1,2))  and (e.id=m.id_equipment) order by m.id_modem');
          qry.Open;
          while not qry.Eof do begin
              ModularModems.Add(qry.FieldByName('id_modem').AsString);
              qry.Next;
          end;
      finally
        FreeAndNil(qry);
      end;
end;

procedure TMyTimerThread.WriteStatuses(id_modem: integer);
var qry:TMyADOQuery;
    qryStatuses:TMyADOQuery;
    qryUpd:TMyADOQuery;
  i: Integer;
  j: Integer;
  shift: Integer;
  sec: Integer;
  eqmt: string;
begin
      try
          qry:=TMyADOQuery.Create(Form1,Form1.ADOConnection1);
          qryStatuses:=TMyADOQuery.Create(Form1,Form1.ADOConPowerView);
          qryUpd:=TMyADOQuery.Create(Form1,Form1.ADOConnection1);
          qry.SQL.Clear;
          qry.SQL.Add('select s.id, s.signal_level, s.date, s.time, s.status, m.name from statss s');
          qry.SQL.Add('where (s.id_modem='+IntToStr(id_modem)+') and (s.status=0) order by s.date');
          try
             qry.Open;
          except

          end;
          i:=0;
          j:=0;
          try
            // Для каждой записи с нулевым статусом ищем статус
            while (not qry.Eof) and (i<1000) do begin
               shift:=DateToShift(qry.FieldByName('date').AsDateTime,strtotime(qry.FieldByName('time').AsString));
               //showmessage(qry.FieldByName('time').AsString+'   '+FloatToStr(strtotime(qry.FieldByName('time').AsString)));
               sec:=TimeToShiftSec(StrToTime(qry.FieldByName('time').AsString));
               eqmt:=qry.FieldByName('name').AsString;
               if qryStatuses.Active then qryStatuses.Close;
               qryStatuses.SQL.Clear;
               qryStatuses.SQL.Add('select status from hist_statusevents');
               qryStatuses.SQL.Add('where (shiftindex='+inttostr(shift)+') and (eqmt='+#39+eqmt+#39+') ');
               qryStatuses.SQL.Add('and (starttime<='+inttostr(sec)+') and (endtime>='+inttostr(sec)+')');
               //memo1.Text:=qryStatuses.SQL.Text;
               //sleep(10000);
               qryStatuses.Open;
               qryStatuses.Last;
               // Если статус нашелся в Powerview, то внести его в базу данных
               if qryStatuses.RecordCount>0 then begin
                  inc(j);
                  if qryUpd.Active then qryUpd.Close;
                  qryUpd.SQL.Clear;
                  qryUpd.SQL.Add('Update statss set status='+qryStatuses.fieldByName('status').AsString+' where id='+qry.fieldByName('id').AsString);
                  qryUpd.ExecSQL;
                  qryUpd.Close;
               end else begin
                  // Если статус не найден и давность записи более половины дня, то записывать статус -1
                  if ((now-strtodate(qry.FieldByName('date').AsString)-strtotime(qry.FieldByName('time').AsString))>0.5) then begin
                     inc(j);
                     if qryUpd.Active then qryUpd.Close;
                     qryUpd.SQL.Clear;
                     qryUpd.SQL.Add('Update statss set status=-1 where id='+qry.fieldByName('id').AsString);
                     qryUpd.ExecSQL;
                     qryUpd.Close;
                  end;
               end;
               qryStatuses.Close;
               qry.Next;
               inc(i);
            end;
          except
          end; //конец try
      finally
          FreeAndNil(qry);
          FreeAndNil(qryStatuses);
          FreeAndNil(qryUpd);
          FProcessedCount:=FProcessedCount+i;
          FUpdatedCount:=FUpdatedCount+j;
      end;

end;

end.

