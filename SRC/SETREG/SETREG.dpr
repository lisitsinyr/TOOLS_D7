{$APPTYPE CONSOLE}
program SETREG;

uses Registry, Windows;

var
   Reg : TRegistry;

begin
   { ParamStr(1) - <group> }
   { ParamStr(2) - <parameter> }
   { ParamStr(3) - <value> }
   if ParamCount <> 3 then begin
      WriteLN('SETREG: setreg <path> <key> <value>');
      end
   else begin
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.OpenKey(ParamStr(1),True);
      Reg.WriteString(ParamStr(2), ParamStr(3));
      Reg.Free;
   end;
end.
