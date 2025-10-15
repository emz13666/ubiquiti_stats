unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, Provider, SqlExpr, DB, ExtCtrls, TeeProcs, TeEngine,
  Chart, StdCtrls, Grids, DBGrids, TTDBGrid, DBClient, DBLocal, DBLocalS,
  FMTBcd, Series, BubbleCh, ComCtrls, Clipbrd, ComObj, ActiveX, Menus, snmpsend,asn1util,
  ADODB;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    ToolTipsDBGrid1: TToolTipsDBGrid;
    Button1: TButton;
    Chart1: TChart;
    Series1: TPointSeries;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MonthCalendar1: TMonthCalendar;
    Button2: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter3: TSplitter;
    Panel5: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    C1: TMenuItem;
    N1: TMenuItem;
    Label7: TLabel;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    btnMAC: TButton;
    Updatemac1: TMenuItem;
    Button3: TButton;
    Timer1: TTimer;
    RadioGroup1: TRadioGroup;
    Button4: TButton;
    CheckBox4: TCheckBox;
    Button5: TButton;
    Button6: TButton;
    DBConnection: TADOConnection;
    Query_3: TADOQuery;
    Modems: TADOQuery;
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
    Modemsid_ptx: TLargeintField;
    Modemsid_modem_1: TLargeintField;
    Modemsserial: TWideStringField;
    Modemsip_address_1: TWideStringField;
    Modemsos_ver: TWideStringField;
    Modemsdispatch_ver: TWideStringField;
    Modemsoem_driver_ver: TWideStringField;
    Modemsprim_1: TWideStringField;
    Modemsmac_address_1: TWideStringField;
    modems_avg: TADOQuery;
    LargeintField1: TLargeintField;
    SmallintField1: TSmallintField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    SmallintField2: TSmallintField;
    WideStringField5: TWideStringField;
    LargeintField2: TLargeintField;
    SmallintField3: TSmallintField;
    LargeintField3: TLargeintField;
    LargeintField4: TLargeintField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    modems_avgavg_signal: TIntegerField;
    Query: TADOQuery;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EXCEL1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ToolTipsDBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Chart1ClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolTipsDBGrid1DblClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btnMACClick(Sender: TObject);
    procedure Updatemac1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure modems_avg1CalcFields(DataSet: TDataSet);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  NamesModems: Array of string;
implementation

{$R *.dfm}

function convert_s(s: string):string;
var i: byte;
    ch: char;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
//  Modems.CommandText := 'select * from modems as t1 LEFT OUTER JOIN ptx as t2 ON t1.id_modem=t2.id_modem';
  Modems.Open;
  Query.SQL.Text := 'select place_install, color from modems where is_access_point=1';
  MonthCalendar1.Date := Date;
  DateTimePicker2.Date := date;
  Query.Open;
  if Query.RecordCount < 4 then exit;
  Label1.Caption := Query.Fields[0].AsString;
  Label1.Color := Query.Fields[1].AsInteger;
  Query.Next;
  Label2.Caption := Query.Fields[0].AsString;
  Label2.Color := Query.Fields[1].AsInteger;
  Query.Next;
  Label3.Caption := Query.Fields[0].AsString;
  Label3.Color := Query.Fields[1].AsInteger;
  Query.Next;
  Label4.Caption := Query.Fields[0].AsString;
  Label4.Color := Query.Fields[1].AsInteger;
  Query.Close;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Modems.Close;
  DBConnection.Close;
end;

function IsOLEObjectInstalled(Name: String): boolean;
var
  ClassID: TCLSID;
  Rez : HRESULT;
begin
  // »щем CLSID OLE-объекта
  Rez := CLSIDFromProgID(PWideChar(WideString(Name)), ClassID);
  if Rez = S_OK then  // ќбъект найден
    Result := true
  else
    Result := false;
end;

procedure TForm1.EXCEL1Click(Sender: TObject);
var clpbrd : TClipboard;
var image1: TImage;  ExcelApp, WorkBook: Variant;
begin
ToolTipsDBGrid1.Tag := 1;
//установлен ли EXCEL
  if not IsOLEObjectInstalled('Excel.Application') then
  begin
    ShowMessage('Ёкспорт невозможен. Excel не установлен.');
    exit;
  end;

  clpbrd := Clipboard;
//  clpbrd.Assign(Chart1.);
  image1 := TImage.Create(Form1);
try

  image1.Parent := Form1;
  image1.Width := Chart1.Width;
  image1.Height := Chart1.Height;
  Chart1.PaintTo(image1.Canvas,0,0);
  clpbrd.Assign(image1.Picture.Bitmap);


 // —оздание Excel
  ExcelApp := CreateOleObject('Excel.Application');


  WorkBook := ExcelApp.WorkBooks.Add;
  Workbook.WorkSheets[1].Paste;
  ExcelApp.visible := true;
finally
  image1.Free;
end;//try
ToolTipsDBGrid1.Tag := 0;
end;//procedure

procedure TForm1.Button1Click(Sender: TObject);
var tmpDateTime: TDateTime;
begin
  ToolTipsDBGrid1.Tag := 1;
  Query.Close;
    if CheckBox1.Checked then
      Query.sql.Text := 'select date, time, signal_level, color, name from statss, modems where statss.id_modem='+
        Modemsid_modem.AsString+' and statss.mac_ap=modems.mac_address'
    else
    begin
      Query.sql.Text := 'select date, time, signal_level, color, name from statss, modems where statss.id_modem='+
          Modemsid_modem.AsString;
      if CheckBox3.Checked then
      begin
        Query.sql.Text := Query.sql.Text +
            ' and statss.date >= '+QuotedStr(FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date))+
            ' and statss.date <= '+QuotedStr(FormatDateTime('yyyy-mm-dd',DateTimePicker2.Date));
        Query.sql.Text := Query.sql.Text +
         ' and statss.time >= '+ QuotedStr(FormatDateTime('hh:nn:00',DateTimePicker3.Time)) +
         ' and statss.time <= '+ QuotedStr(FormatDateTime('hh:nn:00',DateTimePicker4.Time));
      end
      else
      begin
        Query.sql.Text := Query.sql.Text +
          ' and statss.date='+QuotedStr(FormatDateTime('yyyy-mm-dd',MonthCalendar1.Date));
      end;
      Query.sql.Text := Query.sql.Text + ' and statss.mac_ap=modems.mac_address order by date, time';
    end;
  Query.Open;
  Query.FindLast;
  if Query.RecordCount = 0 then exit;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := Query.RecordCount;
  Query.First;
  Chart1.Series[0].Clear;
  Chart1.Title.Text.Clear;
  Chart1.Title.Text.Add('√рафик изменени€ уровн€ сигнала wi-fi дл€ '+Modemsname.Asstring);
  Chart1.Series[0].Active:= false;
  SetLength(NamesModems,0);
  while not Query.Eof do
  begin
    if CheckBox2.Checked then
    begin
      ProgressBar1.Position := ProgressBar1.Position +1;
      Application.ProcessMessages;
    end;
      SetLength(NamesModems,Length(NamesModems)+1);
      if Query.Fields[2].AsInteger=156 then
      begin
        tmpDateTime := StrToDateTime(Query.Fields[0].AsString+' '+Query.Fields[1].AsString);
        Chart1.Series[0].AddXY(tmpDateTime,(Query.FieldByName('signal_level').AsInteger-256),'',clYellow);
        NamesModems[High(NamesModems)] := '';
      end
      else
      begin
        tmpDateTime := StrToDateTime(Query.Fields[0].AsString+' '+Query.Fields[1].AsString);
        Chart1.Series[0].AddXY(tmpDateTime,Query.FieldByName('signal_level').AsInteger-256,'',Query.FieldByName('color').AsInteger);
        NamesModems[High(NamesModems)] := Query.FieldByName('name').AsString + ' ';
      end;
    Query.Next;
  end;
  ProgressBar1.Position := 0;
  Query.Close;

  Chart1.Series[0].Active := true;
  ToolTipsDBGrid1.Tag := 0;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then CheckBox3.Checked := false;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
   if CheckBox3.Checked then CheckBox1.Checked := false;
end;


procedure TForm1.ToolTipsDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);

begin
   if Modemsonline.AsInteger=1 then
      begin
        ToolTipsDBGrid1.Canvas.Brush.Color := clLime;
        ToolTipsDBGrid1.Canvas.Font.Color := clBlack;
      end
   else
      begin
        ToolTipsDBGrid1.Canvas.Brush.Color := clRed;
        ToolTipsDBGrid1.Canvas.Font.Color := clBlack;
      end;

{  if (gdSelected in State) then
  begin
    ToolTipsDBGrid1.Canvas.Brush.Color := clBlue;
    ToolTipsDBGrid1.Canvas.Font.Color :=  clWhite;
  end;}

  ToolTipsDBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TForm1.Chart1ClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:TPoint;
begin
  Chart1.Hint := namesModems[ValueIndex]+IntToStr(Trunc(Chart1.Series[0].YValue[ValueIndex]))+' dBm '+
    FormatDateTime('dd.mm.yyyy hh:nn:ss',Chart1.Series[0].XValue[ValueIndex]);
   pt := chart1.ClientToScreen(Point(X,Y)) ;
   Application.ActivateHint(pt) ;
end;

procedure TForm1.ToolTipsDBGrid1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
Button1.Click;
end;

procedure TForm1.N1Click(Sender: TObject);
var Book_Mark: Pointer;
begin
  Book_Mark := Modems.GetBookmark;
  Modems.Close;
  Modems.Open;
  Modems.GotoBookmark(Book_Mark);
end;

procedure TForm1.btnMACClick(Sender: TObject);
var s1,s4:string;
   snmp : tsnmpsend;
begin
  ToolTipsDBGrid1.Tag := 1;
  Modems.First;
  while not Modems.Eof do
  begin
     snmp := tsnmpsend.Create;
     try
       snmp.Query.Clear;
       snmp.Query.Community:='ubnt_mlink54';
       snmp.TargetHost := Modemsip_address.AsString;
       snmp.Query.PDUType := PDUGetRequest;
       s1:='1.2.840.10036.1.1.1.1.5';
       snmp.Query.MIBAdd(s1,'',ASN1_NULL);
       if snmp.SendRequest then
         begin
           Application.ProcessMessages;
           s4:=snmp.Reply.MIBGet(s1);
           Query_3.Close;
           Query_3.SQL.Text := 'Update modems set mac_address='+QuotedStr(s4)+' where id_modem='+Modemsid_modem.AsString;
           Query_3.ExecSQL;
           Query_3.Close;
         end;
     finally
       snmp.Free;
     end;
     Modems.Next;
  end;
  ToolTipsDBGrid1.Tag := 0;
end;

procedure TForm1.Updatemac1Click(Sender: TObject);
 var s1,s4:string;
   snmp : tsnmpsend;
begin
     ToolTipsDBGrid1.Tag := 1;
     snmp := tsnmpsend.Create;
     try
       snmp.Query.Clear;
       snmp.Query.Community:='ubnt_mlink54';
       snmp.TargetHost := Modemsip_address.AsString;
       snmp.Query.PDUType := PDUGetRequest;
       s1:='1.2.840.10036.1.1.1.1.5';
       snmp.Query.MIBAdd(s1,'',ASN1_NULL);
       if snmp.SendRequest then
         begin
           Application.ProcessMessages;
           s4:=snmp.Reply.MIBGet(s1);
           Query_3.Close;
           Query_3.SQL.Text := 'Update modems set mac_address='+QuotedStr(s4)+' where id_modem='+Modemsid_modem.AsString;
           Query_3.ExecSQL;
           Query_3.Close;
         end;
     finally
       snmp.Free;
     end;
     ToolTipsDBGrid1.Tag := 0;
end;


procedure TForm1.Button3Click(Sender: TObject);
var S: TStringList; counter:byte;
begin
  ToolTipsDBGrid1.Tag := 1;
  S := TStringList.Create;
  S.Add('wireless.1.mac_acl.status=disabled');
  S.Add('wireless.1.mac_acl.policy=allow');
  Modems.First;
  counter := 1;
  while not Modems.Eof do
  begin
    if Length(Modemsmac_address.AsString) > 5 then
    begin
      S.Add('wireless.1.mac_acl.'+IntToStr(counter)+'.comment='+Modemsname.AsString);
      S.Add('wireless.1.mac_acl.'+IntToStr(counter)+'.mac='+Modemsmac_address.AsString);
      S.Add('wireless.1.mac_acl.'+IntToStr(counter)+'.status=enabled');
      inc(counter);
    end;
    Application.ProcessMessages;
    Modems.Next;
  end;
  S.SaveToFile(ExtractFilePath(Application.ExeName)+'mac_acl.txt');
  S.Free;
  ToolTipsDBGrid1.Tag := 0;
end;

procedure TForm1.Label3DblClick(Sender: TObject);
begin
  Button3.Enabled := true;
  btnMAC.Enabled := true;
  Button6.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if ToolTipsDBGrid1.Tag = 0 then
    N1Click(Sender);
end;

procedure TForm1.DateTimePicker1Change(Sender: TObject);
begin
  CheckBox3.Checked := true;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
ToolTipsDBGrid1.Tag := 1;
  Modems.Close;
  case RadioGroup1.ItemIndex of
   0: Modems.SQL.Text := 'select * from modems as t1 LEFT OUTER JOIN ptx as t2 ON t1.id_modem=t2.id_modem';
   1: Modems.SQL.Text := 'select * from modems as t1 RIGHT OUTER JOIN ptx as t2 ON t1.id_modem=t2.id_modem';
  end;
  Modems.Open;
  ToolTipsDBGrid1.tag :=0;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
 Timer1.Enabled :=   CheckBox4.Checked;
end;

procedure ExportToExcel(Var Grid: TToolTipsDBGrid);
var
  bm: TBookmark;
  col, row: Integer;
  sline: string;
  mem: TMemo;
  Layout: array[0.. KL_NAMELENGTH] of char;
  ExcelApp, WorkBook: Variant;
begin
//установлен ли EXCEL
  if not IsOLEObjectInstalled('Excel.Application') then
  begin
    ShowMessage('Ёкспорт невозможен. Excel не установлен.');
    exit;
  end;

 // —оздание Excel
  ExcelApp := CreateOleObject('Excel.Application');


  WorkBook := ExcelApp.WorkBooks.Add;
  Screen.Cursor := crHourglass;
  Grid.DataSource.DataSet.DisableControls;
  bm := Grid.DataSource.DataSet.GetBookmark;
  Grid.DataSource.DataSet.First;

  // —перва отправл€ем данные в memo
  // работает быстрее, чем отправл€ть их напр€мую в Excel
  mem := TMemo.Create(Form1);
  mem.Parent := Form1;
  mem.Visible := false;
  mem.Clear;
  sline := '';

  // добавл€ем информацию дл€ имЄн колонок
  for col := 0 to Grid.Columns.Count-1 do
    sline := sline + Grid.Columns[col].Title.Caption + #9;
  mem.Lines.Add(sline);

  // получаем данные из DBGrid
  for row := 0 to Grid.DataSource.DataSet.RecordCount-1 do
  begin
    sline := '';
    for col := 0 to Grid.Columns.Count-1 do
      if Grid.Columns[col].Field.AsString='30.12.1899' then
        sline := sline + #9
      else
        sline := sline + Grid.Columns[col].Field.AsString + #9;
    mem.Lines.Add(sline);
    Grid.DataSource.DataSet.Next;
  end;

  // копируем данные в clipboard
  mem.SelectAll;
  // переключаем раскладку на русский
  LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
  mem.CopyToClipboard;
  mem.Free;


  // отправл€ем их в Excel

  Workbook.WorkSheets[1].Paste;
  Workbook.WorkSheets[1].Range['A1','AA1'].Font.Size := 11;
  Workbook.WorkSheets[1].Range['A1','AA1'].Font.Bold := true;
  Workbook.WorkSheets[1].Columns.AutoFit;
  Workbook.WorkSheets[1].Range['A1',EmptyParam].Select;

  ExcelApp.Visible := true;

  Grid.DataSource.DataSet.GotoBookmark(bm);
  Grid.DataSource.DataSet.FreeBookmark(bm);
  Grid.DataSource.DataSet.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ToolTipsDBGrid1.Tag := 1;
  ExportToExcel(ToolTipsDBGrid1);
  ToolTipsDBGrid1.Tag := 0;
end;

procedure TForm1.modems_avg1CalcFields(DataSet: TDataSet);
begin
  ToolTipsDBGrid1.Tag := 1;
  Query.Close;
  Query.sql.Text := 'Select avg(signal_level) from statss where id_modem='+DataSet.Fields[0].AsString+
    ' and date='+QuotedStr(FormatDateTime('yyyy-mm-dd',MonthCalendar1.Date))+' and signal_level>-100';
  Query.Open;
  modems_avgavg_signal.AsInteger := Round(Query.Fields[0].AsFloat);
  Query.Close;
  ToolTipsDBGrid1.Tag := 0;
end;


procedure ExportToExcel_dataset(Var Grid: TADOQuery);
var
  bm: TBookmark;
  col, row: Integer;
  sline: string;
  mem: TMemo;
  Layout: array[0.. KL_NAMELENGTH] of char;
  ExcelApp, WorkBook: Variant;
begin
//установлен ли EXCEL
  if not IsOLEObjectInstalled('Excel.Application') then
  begin
    ShowMessage('Ёкспорт невозможен. Excel не установлен.');
    exit;
  end;

 // —оздание Excel
  ExcelApp := CreateOleObject('Excel.Application');


  WorkBook := ExcelApp.WorkBooks.Add;
  Screen.Cursor := crHourglass;
  Grid.DisableControls;
  bm := Grid.GetBookmark;
  Grid.First;

  // —перва отправл€ем данные в memo
  // работает быстрее, чем отправл€ть их напр€мую в Excel
  mem := TMemo.Create(Form1);
  mem.Parent := Form1;
  mem.Visible := false;
  mem.Clear;
  sline := '';

  // добавл€ем информацию дл€ имЄн колонок
  for col := 0 to Grid.FieldCount-1 do
    sline := sline + Grid.Fields[col].FieldName + #9;
  mem.Lines.Add(sline);

  // получаем данные из DBGrid
  for row := 0 to Grid.RecordCount-1 do
  begin
    sline := '';
    for col := 0 to Grid.FieldCount-1 do
        sline := sline + Grid.Fields[col].AsString + #9;
    mem.Lines.Add(sline);
    Grid.Next;
  end;

  // копируем данные в clipboard
  mem.SelectAll;
  // переключаем раскладку на русский
  LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
  mem.CopyToClipboard;
  mem.Free;


  // отправл€ем их в Excel

  Workbook.WorkSheets[1].Paste;
  Workbook.WorkSheets[1].Range['A1','AA1'].Font.Size := 11;
  Workbook.WorkSheets[1].Range['A1','AA1'].Font.Bold := true;
  Workbook.WorkSheets[1].Columns.AutoFit;
  Workbook.WorkSheets[1].Range['A1',EmptyParam].Select;

  ExcelApp.Visible := true;

  Grid.GotoBookmark(bm);
  Grid.FreeBookmark(bm);
  Grid.EnableControls;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ToolTipsDBGrid1.Tag := 1;
  modems_avg.Open;
  ExportToExcel_Dataset(modems_avg);
  modems_avg.Close;
  ToolTipsDBGrid1.Tag := 0;
end;

procedure TForm1.Button6Click(Sender: TObject);
var s1,s4:string;
   snmp : tsnmpsend;
   s,s_1: TStrings;
begin
  ToolTipsDBGrid1.Tag := 1;
  S := TStringList.Create;
  s_1 := TStringList.Create;
  Modems.First;
  while not Modems.Eof do
  begin
    if (Length(Modemsmac_address.AsString) > 5)and(Length(Modemsmac_address_1.AsString) > 5) then
    begin
      S.Add('arp -s '+Modemsip_address.AsString+' '+Modemsmac_address.AsString);
      s_1.Add('arp -s '+Modemsip_address.AsString+' '+StringReplace(Modemsmac_address.AsString,':','-',[rfReplaceAll]));
      S.Add('arp -s '+Modemsip_address_1.AsString+' '+Modemsmac_address_1.AsString);
      s_1.Add('arp -s '+Modemsip_address_1.AsString+' '+StringReplace(Modemsmac_address_1.AsString,':','-',[rfReplaceAll]));
    end;
    Application.ProcessMessages;
    Modems.Next;
  end;
  S.SaveToFile(ExtractFilePath(Application.ExeName)+'arp_add.sh');
  s_1.SaveToFile(ExtractFilePath(Application.ExeName)+'arp_add.cmd');
  S.Free;
  s_1.Free;
  ToolTipsDBGrid1.Tag := 0;

end;

end.
