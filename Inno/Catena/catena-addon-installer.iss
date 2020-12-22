;*****************************************************************************
;
; Module:  mcci-catena-samd-driver.iss
;
; Function:
;	Inno Setup Uninstall script for the MCCI CATENA SAMD boards driver.
;
; Version:
;	V0.XXa	Thu Dec 11 2020 13:14:00 muthup	Edit level 1
;
; Copyright notice:
;	This file copyright (C) 2020 by
;		MCCI Corporation
;		3520 Krums Corners Road
;		Ithaca, NY  14850
;
;	An unpublished work.  All rights reserved.
;	
;	This file is proprietary information, and may not be disclosed or
;	copied without the prior permission of MCCI Corporation.
; 
; Author:
;	Muthu Pandi P, MCCI Corporation	December 2020
;
; Revision history:
;    0.XXa  Thu Dec 11 2020 13:14:00  muthup
;	Module created. 
;
;*****************************************************************************

[Setup]
AppName=MCCI Catena USB Driver
AppVersion=1.0.0
DefaultDirName={tmp}
DefaultGroupName=Catena
;UninstallDisplayIcon={app}\catenauninstall.exe
Compression=lzma2
SolidCompression=yes
;UninstallFilesDir={app}\MCCI
;OutputDir=userdocs:Inno Setup Examples Output
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
; On all other architectures it will install in "32-bit mode".
ArchitecturesInstallIn64BitMode=x64
; Note: We don't set ProcessorsAllowed because we want this
; installation to run on all architectures (including Itanium,
; since it's capable of running 32-bit code too).
;LicenseFile=Catena_licence.rtf

[Files]
; Place all x64 files here
Source: "source\dpinst-amd64.exe"; DestDir: "{tmp}\drivers"; Check: Is64BitInstallMode; Flags:solidbreak

; Place all the driver INF and CAT files here
Source: "source\mcci-catena-stm32.cat"; DestDir: "{tmp}\drivers"; Flags:solidbreak
Source: "source\mcci-catena-samd.inf"; DestDir: "{tmp}\drivers";

[Run]
Filename: {tmp}\drivers\dpinst-amd64.exe; Description: "64-bit MCCI Catena USB Driver Setup"; Check: Is64BitInstallMode
Filename: {cmd}; Parameters: "/C Mkdir ""{app}\Uninstallers"""; Flags: RunHidden WaitUntilTerminated
Filename: {cmd}; Parameters: "/C Move ""{app}\unins000.exe"" ""{app}\Uninstallers\MCCI Catena USB Driver - uninstall.exe"""; StatusMsg: Installing MCCI Catena USB Driver...; Flags: RunHidden WaitUntilTerminated
Filename: {cmd}; Parameters: "/C Move ""{app}\unins000.dat"" ""{app}\Uninstallers\MCCI Catena USB Driver - uninstall.dat"""; StatusMsg: Installing MCCI Catena USB Driver...; Flags: RunHidden WaitUntilTerminated
Filename: {cmd}; Parameters: "/C Move ""{app}\unins000.msg"" ""{app}\Uninstallers\MCCI Catena USB Driver - uninstall.msg"""; StatusMsg: Installing MCCI Catena USB Driver...; Flags: RunHidden WaitUntilTerminated
Filename: REG.exe; Parameters: "ADD ""HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Windows 8 ContextMenu - MCCI Catena USB Driver_is1"" /V ""UninstallString"" /T ""REG_SZ"" /D ""\""{app}\Uninstallers\MCCI Catena USB Driver- uninstall.exe\"""" /F"; StatusMsg: Installing MCCI Catena USB Driver...; Flags: RunHidden WaitUntilTerminated
Filename: REG.exe; Parameters: "ADD ""HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Windows 8 ContextMenu - MCCI Catena USB Driver_is1"" /V ""QuietUninstallString"" /T ""REG_SZ"" /D ""\""{app}\Uninstallers\MCCI Catena USB Driver- uninstall.exe\"" /SILENT"" /F"; StatusMsg: Installing MCCI Catena USB Driver...; Flags: RunHidden WaitUntilTerminated
