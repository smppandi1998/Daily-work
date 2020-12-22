

[Setup]
AppName=Hello_world
AppVersion=1.5
WizardStyle=modern
DefaultDirName={autopf}\Hello_world
DefaultGroupName=Hello_world

Compression=lzma2
SolidCompression=yes

#define FileNamePattern  GetDateTimeString('dd-mm-yyyy hh-nn-ss', '-', ':');
[Files]
Source: "inno.exe"; DestDir: "{app}";
Source: "inno.txt"; DestDir: "{app}";Flags:isreadme

[Code]
 

 procedure MyBeforeInstall();
 
 begin

     SaveStringToFile('E:\Inno_helloworld\inno.txt', 'Muthu', False) ;
 end;









