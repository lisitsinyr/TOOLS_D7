{$APPTYPE CONSOLE}
program setini;

uses INIFiles, SysUtils;

var
   IniFileName : string;
   INIFile : TINIFile;
   WinDir : string;
   s : string;
begin
   { ParamStr(1) - <>.ini  }
   { ParamStr(2) - <group> }
   { ParamStr(3) - <parameter> }
   { ParamStr(4) - <value> }
   if not (ParamCount in [3..4]) then begin
      WriteLN('SETINI: setini <ini_file> <group> <parameter> <value>');
      end
   else begin
      {
      WinDir := GetEnvVar('WinDir');
      s := ExtractFilePath(ParamStr(0))+';'+WinDir;
      INIFileName := FileSearch(Paramstr(1), S);
      }
      INIFileName := Paramstr(1);
      if not FileExists(INIFileName) then begin
         WriteLN('SETINI: ini_file '+Paramstr(1)+' not found.');
         end
      else begin
         INIFile := TINIFile.Create(INIFileName);
         INIFile.WriteString(ParamStr(2), ParamStr(3), ParamStr(4));
         IniFile.Free;
      end;
   end;
end.
