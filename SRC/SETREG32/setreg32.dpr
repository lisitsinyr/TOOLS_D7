{$APPTYPE CONSOLE}
program setreg32;

uses Registry, Windows, SysUtils, LUSupport;

const
   SetRegParams = '{HKLM|HKCU} <раздел> <параметр> {b|d|dt|t|i|s|se} <значение>';
var
   p1,p2,p3,p4,P5: string;
   P: PChar;

begin
   if ParamCount <> WordCountNew(SetRegParams, [' ']) then begin
      P := StrAlloc(Length(SetRegParams)+1);
      StrPCopy(P, SetRegParams);
      CharToOEM(P,P);
      WriteLN('setreg32.exe '+StrPas(P));
      StrDispose(P);
      end
   else begin
      p1 := ParamStr(1);
      p2 := ParamStr(2);
      p3 := ParamStr(3);
      p4 := ParamStr(4);
      p5 := ParamStr(5);
      SetKey(P1,P2,P3,P4,P5)
   end;
end.
