unit ScorpioDB;

interface

uses Classes, ADODB;

type TMyADOConnection=class(TADOConnection)
     public
     constructor Create(AOwner:TComponent; connString:WideString);
end;

type TMyADOQuery=class(TADOQuery)
     public
     constructor Create(AOwner:TComponent; conn:TADOConnection);
     procedure Open;
end;

implementation

constructor TMyADOConnection.Create(AOwner: TComponent; connString:widestring);
begin
     inherited Create(Aowner);
     connectionString:=connString;
     KeepConnection:=false;
     LoginPrompt:=false;
end;

{ TMyADOQuery }

constructor TMyADOQuery.Create(AOwner: TComponent; conn: TADOConnection);
begin
  inherited Create(AOwner);
  Connection:=conn;
end;

procedure TMyADOQuery.Open;
begin
     inherited;
     Last;
     First;
end;


end.
