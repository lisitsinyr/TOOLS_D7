{$APPTYPE CONSOLE}
program bac32;

uses
  Sysutils, Windows,
  LUScanDir, LUSupport, LUStrUtils;

const
   Switch = ['-', '/'];
   Delta: Integer = 3;
   CheckSize: Boolean = True;
   Log: Boolean = True;
var
   CheckSizeS: string;
   LogS: string;
   DeltaS: string;

begin
   if (ParamCount < 2) then begin
      WriteLN('USAGE: bac32 <file> <path> [-s <Y/N>] [-d <Delta>] [-l <Y/N>]');
      end
   else begin
      CheckSizeS := GetCmdLineArg('s', Switch);
      LogS := GetCmdLineArg('l', Switch);
      DeltaS := GetCmdLineArg('d', Switch);
      if (CheckSizeS <> '') and (UpperCase(CheckSizeS)='N') then CheckSize := False;
      if (LogS       <> '') and (UpperCase(LogS)      ='N') then Log       := False;
      try
         Delta := StrToInt(DeltaS);
      except
      end;
      BacCopy(ParamStr(1), ParamStr(2), CheckSize, Log, Delta);
   end;
     
end.
