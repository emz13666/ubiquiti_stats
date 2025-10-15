unit MyTimer;

interface
uses Windows, Classes, messages, Sysutils, Variants, forms,snmpsend,asn1util, controls, DateUtils, iniFiles, graphics ;

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

  // Время задержки между основными выполнениями программы
  var sleeptime:integer;
  // Количество смен, которые будет просматривать программа для импорта gps координат.
  // Задается в модуле MainUnit
     shiftcount:Byte;
  // Имя сетевой папки с файлами gps
     netFolderName:string;
  // Путь к папке, где лежит программа
     apppath:string;
  // ini файл с статистикой
     statfile:TIniFile;
implementation

uses MainUnit;

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
// Функция возвращает последнее вхождение подстроки
function LastPos(substring, str: string): word;
var s:string;
    a, asum, c:integer;
    f:boolean;
begin
     c:=length(substring);
     f:=false;
     s:=str;
     asum:=0;
     while not f do begin
           a:=pos(substring, s);
           if a>0 then begin
              delete(s,1,a+c-1);
              asum:=asum+a+c-1;
           end else f:=true;
     end;
     result:=asum-c+1;
end;

// Функция для определения файла смены по дате и времени
function getShiftFileName(dt:TDate; tm:TTime):string;
var dt1:TDate;
var prefix:string;
begin
         if tm>=StrToTime('19:30') then dt1:=dt+1 else dt1:=dt;
         if (tm>=StrToTime('7:30')) and (tm<StrToTime('19:30')) then prefix:='d' else prefix:='n';
         result:='gps'+FormatDateTime('yymmdd',dt1)+prefix+'.dat';
end;

{ **** UBPFD *********** by delphibase.endimus.com ****
***************************************************** }
// Количество строк в текстовом файле
function LinesCount(const Filename: string): Integer;
var
  HFile: THandle;
  FSize, WasRead, i: Cardinal;
  Buf: array[1..4096] of byte;
begin
  Result := 0;
  HFile := CreateFile(Pchar(FileName), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if HFile <> INVALID_HANDLE_VALUE then
  begin
    FSize := GetFileSize(HFile, nil);
    if FSize > 0 then
    begin
      Inc(Result);
      ReadFile(HFile, Buf, 4096, WasRead, nil);
      repeat
        for i := WasRead downto 1 do
          if Buf[i] = 10 then
            Inc(Result);
        ReadFile(HFile, Buf, 4096, WasRead, nil);
      until WasRead = 0;
    end;
  end;
  CloseHandle(HFile);
end;

// Основная процедура программы
procedure TMyTimerThread.AddToBDB;
var i,j, countLinesfile, statcount, posstr, secondstime, statid: integer;
    eqmt, fileName, shiftname, lineoffile, gpsx, gpsy :string;
    dt : TDate;
    tm, stattime :TTime;
    dttm, gpsdatetime, gpsdate, gpstime:TDateTime;
    gpsfile : TextFile;
    findstat:boolean;
begin
Form1.Lstatus.Font.Color:=clRed;
Form1.Lstatus.Caption:='Выполняется';
Form1.LRunningTime.Visible:=false;
dttm:=Now;
// Смотрим все смены
for i:=1 to shiftcount do begin
    dt:=DateOf(dttm);
    tm:=TimeOf(dttm);
    fileName:=getShiftFileName(dt,tm);
    shiftname:=copy(filename,1,length(filename)-4);
    form1.lcount.Caption:='0';
    Form1.LShiftName.Caption:=filename;
    //Application.MessageBox(PChar(apppath),'сообщение');
    if FileExists(netFolderName+fileName) then begin
       CopyFile(PChar(netFolderName+fileName),PChar(apppath+filename),false);
       countLinesFile:=LinesCount(apppath+filename);
       statcount:=StrToInt(statfile.ReadString('stat',shiftname,'0'));
       // Если количество строк в файле превышает количество файлов в статистике,
       // то выполняем выгрузку тех строк, которые ранее не были выгружены
       if countLinesFile>statcount then begin
          AssignFile(gpsfile,apppath+fileName);
          reset(gpsfile);
          j:=1;
          // читаем файл до определенной строки
          while j<statcount+1 do begin
              readln(gpsfile, lineoffile);
              inc(j);
          end;
          for j:=statcount+1 to countLinesFile do begin
              readln(gpsfile,lineoffile);
              if Length(lineoffile)>6 then begin
                 posstr:=Pos(':',lineoffile);
                 // Получаем значение даты и времени. Это количество секунд, прошедшее с 01.01.1970
                 secondstime:=StrToInt(copy(lineoffile,1,posstr-1));
                 gpsdatetime:=StrToDateTime('01.01.1970')+(secondstime/(24*3600));
                 //gpsdatetime:=EncodeDateTime(1970,1,1,0,0,0,0)+(secondstime/(24*3600));
                 gpsdate:=DateOf(gpsdatetime);
                 gpstime:=TimeOf(gpsdatetime);
                 delete(lineoffile,1,posstr);
                 // Получаем данные о единице техники
                 posstr:=Pos(':',lineoffile);
                 eqmt:=copy(lineoffile,1,posstr-1);
                 delete(lineoffile,1,posstr);
                 // Данные о координате x
                 posstr:=Pos(':',lineoffile);
                 gpsx:=copy(lineoffile,1,posstr-1);
                 delete(lineoffile,1,posstr);
                 // Данные о координате y
                 posstr:=Pos(':',lineoffile);
                 gpsy:=copy(lineoffile,1,posstr-1);
                 statid:=0;
                 stattime:=0;
                 findstat:=false;
                 // Находим id записи пинга, который был до координаты
                 form1.qrystat.Active:=false;
                 form1.qrystat.SQL.Clear;
                 form1.qrystat.SQL.Add('select max(s.time) as time1 from statss s, modems m ');
                 form1.qrystat.SQL.Add('where (s.date="'+FormatDateTime('yyyy-mm-dd',gpsdate)+'")');
                 form1.qrystat.SQL.Add('and (m.name="'+eqmt+'") and (m.id_modem=s.id_modem) and (s.time<="'+Timetostr(gpstime)+'")');
                 form1.qrystat.Active:=true;
                 form1.qrystat.Last;
                 if form1.qrystat.RecordCount>0 then begin
                    stattime:=form1.qrystat.fieldByName('time1').AsDateTime;
                    form1.qrystat.Active:=false;
                    form1.qrystat.SQL.Clear;
                    form1.qrystat.SQL.Add('select s.id from statss s, modems m ');
                    form1.qrystat.SQL.Add('where (s.date="'+FormatDateTime('yyyy-mm-dd',gpsdate)+'")');
                    form1.qrystat.SQL.Add('and (m.name="'+eqmt+'") and (m.id_modem=s.id_modem) and (s.time="'+Timetostr(stattime)+'")');
                    form1.qrystat.Active:=true;
                    form1.qrystat.Last;
                    statid:=form1.qrystat.fieldByName('id').AsInteger;

                    findstat:=true;
                 end;
                 form1.qrystat.Active:=false;
                 form1.qrystat.SQL.Clear;
                 form1.qrystat.SQL.Add('select min(s.time) as time1 from statss s, modems m ');
                 form1.qrystat.SQL.Add('where (s.date="'+FormatDateTime('yyyy-mm-dd',gpsdate)+'")');
                 form1.qrystat.SQL.Add('and (m.name="'+eqmt+'") and (m.id_modem=s.id_modem) and (s.time>="'+Timetostr(gpstime)+'")');
                 form1.qrystat.Active:=true;
                 form1.qrystat.Last;
                 if form1.qrystat.RecordCount>0 then begin
                    if (not findstat) or ((form1.qrystat.FieldByName('time1').AsDateTime-gpstime)<(gpstime-stattime)) then begin
                       stattime:=form1.qrystat.fieldByName('time1').AsDateTime;
                       form1.qrystat.Active:=false;
                       form1.qrystat.SQL.Clear;
                       form1.qrystat.SQL.Add('select s.id from statss s, modems m ');
                       form1.qrystat.SQL.Add('where (s.date="'+FormatDateTime('yyyy-mm-dd',gpsdate)+'")');
                       form1.qrystat.SQL.Add('and (m.name="'+eqmt+'") and (m.id_modem=s.id_modem) and (s.time="'+Timetostr(stattime)+'")');
                       form1.qrystat.Active:=true;
                       form1.qrystat.Last;
                       statid:=form1.qrystat.fieldByName('id').AsInteger;
                       findstat:=true;
                    end;
                 end;
                 try
                    if findstat then begin
                       form1.qrygps.SQL.Text:='update statss set x='+gpsx+', y='+gpsy+' where id='+inttostr(statid);
                       form1.qrygps.ExecSQL;
                    end;
                 except

                 end;
                 statfile.WriteString('stat', shiftname, inttostr(j));
                 form1.lcount.Caption:=inttostr(j);
              end;
          end;
          CloseFile(gpsfile);
       end;
       // Удаляем скопированный ранее файл
       DeleteFile(apppath+filename);
    end;
    // Чтобы посмотреть другую смену, необходимо отнять 12 часов от предыдущей
    dttm:=dttm-StrToTime('12:00');
end;
Form1.Lstatus.Font.Color:=clGreen;
Form1.Lstatus.Caption:='Ожидание выполнения';
dttm:=Now;
Form1.LRunningTime.Caption:=FormatDateTime('dd.mm.yyyy hh:nn',dttm+1/24);
Form1.LRunningTime.Visible:=true;
end;

procedure TMyTimerThread.DoWork;
begin
   AddToBDB;
   //Synchronize(AddToBDB);
end;

procedure TMyTimerThread.Execute;
var posit:word;
begin
  { Place thread code here }
  FreeOnTerminate := True;
  posit:=LastPos('\',Application.ExeName);
  apppath:=copy(Application.ExeName,1,posit);
  {if not FileExists(apppath+'stat.ini') then begin
      CreateFile(PChar(apppath+'stat.ini') ,GENERIC_ALL, 0, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0 );
  end;}
  statFile:=TIniFile.Create(apppath+'stat.ini');
  repeat
    DoWork;
    Sleep(sleeptime);
  until Terminated;
end;

end.

