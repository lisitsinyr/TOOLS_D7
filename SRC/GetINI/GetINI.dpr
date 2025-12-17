program GetINI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
    Classes, SysUtils, IniFiles,
    LUSupport;

var
    GIniFileName: string;
    GINIFile: TINIFile;
    GSection: string;
    GParameter: string;

procedure CheckParameter (const ASection, AParameter: string);
var
    LValue : string;
begin
    LValue := GINIFile.ReadString(ASection, AParameter, '');
    WriteLN (AParameter+'='+LValue);
end;

procedure CheckSection (const ASection: string);
var
    LParameter : string;
    LParameters: TStringList;
    i: integer;
begin
    LParameters := TStringList.Create;
    LParameters.Clear;
    GINIFile.ReadSection (ASection, LParameters);
    for i:=0 to LParameters.Count-1 do begin
        LParameter := LParameters.Strings[i];
        CheckParameter (ASection, LParameter);
    end;
    LParameters.Free;
end;

procedure CheckSections;
var
    LSection : string;
    LSections: TStringList;
    j: integer;
begin
    LSections := TStringList.Create;
    LSections.Clear;
    GINIFile.ReadSections(LSections);
    for j:=0 to LSections.Count-1 do begin
        LSection := LSections.Strings[j];
        // CheckSection (LSection);
        WriteLN (LSection);
    end;
    LSections.Free;
end;

begin
    { ParamStr(1) - <>.ini  }
    { ParamStr(2) - <Section> }
    { ParamStr(3) - <parameter> }
    if not (ParamCount in [1..3]) then begin
        WriteLN('GETINI: setini <ini_file> <Section> <parameter>');
        end
    else begin
        GINIFileName := SysUtils.ExpandFileName(Paramstr(1));
        GSection := ParamStr(2);
        GParameter := ParamStr(3);

        if not FileExists(GINIFileName) then begin
            WriteLN ('GETINI: ini_file '+Paramstr(1)+' not found...');
            end
        else begin
            GINIFile := TINIFile.Create(GINIFileName);
            if GParameter <> '' then begin
                CheckParameter (GSection, GParameter);
                end
            else
            if GSection <> '' then begin
                CheckSection (GSection);
                end
            else begin
                CheckSections;
            end;
            GIniFile.Free;
        end;
    end;
end.
