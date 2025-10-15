program get_stats_status;

uses
  Forms,
  windows,
  MainUnit in 'MainUnit.pas',
  MyTimer in 'MyTimer.pas' {$R *.res},
  ScorpioDB in 'ScorpioDB.pas';

{$R *.res}

begin
 {if mmm then
  begin
//      MessageBox(Application.Handle,PChar('Одна копия программы уже запущена!'),PChar('Ошибка'),MB_OK);
      halt; //завершить программу не создавая ничего.
  end; }
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  ShowWindow(Application.Handle,SW_HIDE);
  Application.Run;

end.
