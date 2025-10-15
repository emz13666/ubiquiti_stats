program local_to_mysql;

uses
  Forms,
  windows,
  MainUnit in 'MainUnit.pas' {Form1};

{$R *.res}

begin
 

  Application.Initialize;

  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
