{$APPTYPE CONSOLE}
program cd32;

uses Sysutils,windows;

var i: integer;
begin
   { ParamStr(1) - <group> }
   { ParamStr(2) - <parameter> }
   { ParamStr(3) - <value> }
   if ParamCount <> 1 then begin
      WriteLN('CD32: cd32 <path>');
      end
   else begin
   {
      MkDir('d:\1\1');
      }
      i := WinExec(PChar('c:\winnt\system32\command.com /C "c:" '), 1);
      i := WinExec(PChar('c:\winnt\system32\command.com /C "cd \app" '), 1);
      {
      SetCurrentDirectory(PChar(ParamStr(1)));
      }
      Writeln(GetCurrentDir);
   end;
end.
