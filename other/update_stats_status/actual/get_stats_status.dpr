program get_stats_status;

uses
  Forms,
  windows,
  MainUnit in 'MainUnit.pas' {Form1};

{$R *.res}

begin
 {if mmm then
  begin
//      MessageBox(Application.Handle,PChar('���� ����� ��������� ��� ��������!'),PChar('������'),MB_OK);
      halt; //��������� ��������� �� �������� ������.
  end; }
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  ShowWindow(Application.Handle,SW_HIDE);
  Application.Run;

end.
