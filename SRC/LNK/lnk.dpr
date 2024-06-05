program lnk;

uses
  Forms,
  lnk_main in 'lnk_main.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
