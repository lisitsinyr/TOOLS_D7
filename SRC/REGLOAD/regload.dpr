{$APPTYPE CONSOLE}
program regload;

uses Registry, Windows, IniFiles, SysUtils, Classes;

var
   Reg : TRegistry;
   Ini : TIniFile;
   Roots: TStringList;
   SectionValues: TStringList;
   I: Integer;
   FileName : string;
   RootName : string;
   PathName : string;
   KeyName : string;
   KeyValue : string;
   BeginPath: Integer;

   procedure SetKey;
   var
      J: Integer;
   begin
      for j:=0 to SectionValues.Count-1 do begin
         KeyName := SectionValues.Names[j];
         KeyValue := SectionValues.Values[KeyName];
         if KeyName[1] = '"' then begin
            Delete(KeyName,Length(KeyName),1);
            Delete(KeyName,1,1);
         end;
         Reg.WriteString(KeyName, KeyValue);
      end;
   end;

begin
   { ParamStr(1) - <group> }
   { ParamStr(2) - <parameter> }
   { ParamStr(3) - <value> }
   if ParamCount <> 1 then begin
      WriteLN('REGLOAD: regload <regfile>');
      end
   else begin
      FileName := ExpandFileName(ParamStr(1));
      if not FileExists(FileName) then begin
         WriteLN('REGLOAD: File '+FileName+' not exists.');
         end
      else begin
         Reg := TRegistry.Create;
         Ini := TINIFile.Create(FileName);
         Roots := TStringList.Create;;
         Ini.ReadSections(Roots);
         for i:=0 to Roots.Count-1 do begin
            BeginPath := Pos('\',Roots.Strings[i]);
            if BeginPath > 0 then begin
               SectionValues := TStringList.Create;;
               RootName := Copy(Roots.Strings[i], 1, BeginPath-1);
               PathName := Copy(Roots.Strings[i], BeginPath+1, Length(Roots.Strings[i])-BeginPath);
               Ini.ReadSectionValues(Roots.Strings[i], SectionValues);
               if SectionValues.Count > 0 then begin
                  if RootName = 'HKEY_LOCAL_MACHINE' then begin
                     Reg.RootKey := HKEY_LOCAL_MACHINE;
                     Reg.OpenKey(PathName,True);
                     SetKey;
                     Reg.CloseKey;
                     end
                  else
                  if RootName = 'HKEY_CURRENT_USER' then begin
                     Reg.RootKey := HKEY_CURRENT_USER;
                     Reg.OpenKey(PathName,True);
                     SetKey;
                     Reg.CloseKey;
                     end
                  else begin
                     WriteLN('REGLOAD: Root '+RootName+' not work.');
                  end;
               end;
               SectionValues.Free;
            end;
         end;
         Roots.Free;
         Ini.Free;
         Reg.Free;
      end;
   end;
end.
