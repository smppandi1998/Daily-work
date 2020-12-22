; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=My Program
AppVersion=1.5
WizardStyle=modern
DefaultDirName={autopf}\My Program
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe
Compression=lzma2
SolidCompression=yes
OutputDir=userdocs:Inno Setup Examples Output
; "ArchitecturesAllowed=x64" specifies that Setup cannot run on
; anything but x64.
ArchitecturesAllowed=x64
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64

[Files]
Source: "MyProg-x64.exe"; DestDir: "{app}"; DestName: "MyProg.exe"
;Source: "MyProg.chm"; DestDir: "{app}"
Source: "Readme.txt"; DestDir: "{app}"; DestName: "readme-muthu.txt"; Flags: isreadme

[Icons]
Name: "{group}\My Program"; Filename: "{app}\MyProg.exe"

[Code]
function CreateBatch(): boolean;
var
  fileName : string;
  lines : TArrayOfString;
  datetime : string;
begin
  Result := true;
  fileName :='E:\example-edits\Readme.txt';
  datetime :=GetDateTimeString('dd-mm-yyyy hh-nn-ss', '-', ':');
  SetArrayLength(lines, 3);
  lines[0] := datetime
  lines[1] := 'pause';
  lines[2] := 'exit';
  Result := SaveStringsToFile(filename,lines,true);

end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if  CurStep=ssPostInstall then
    begin
         CreateBatch();
    end
end;