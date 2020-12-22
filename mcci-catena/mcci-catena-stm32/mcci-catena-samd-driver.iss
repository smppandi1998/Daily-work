;*****************************************************************************
;
; Module:  mcci-catena-samd-driver.iss
;
; Function:
;	Inno Setup install script for the MCCI CATENA SAMD boards driver.
;
; Version:
;	V0.XXa	Thu Dec 10 2020 14:01:00 muthup	Edit level 1
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
;    0.XXa  Thu Dec 10 2020 14:01:00  muthup
;	Module created. 
;
;*****************************************************************************

[Setup]
AppName=MCCI Catena USB Driver
AppVersion=1.0.0.0
DefaultDirName={tmp}
DefaultGroupName=MCCI Catena

OutputBaseFilename=MCCI-CATENA-SAMD-DRIVER-INSTALLER
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
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
;SetupIconFile={#PATHICON}MCCI-square-M-icon.ico
WizardImageStretch=no
WizardImageAlphaFormat=none

;WizardImageFile={#PATHWIF}MCCI-logo-bitmap.bmp

[Files]
; Place all x64 files here
Source: "dpinst-amd64.exe"; DestDir: "{tmp}\drivers"; Check: Is64BitInstallMode;

; Place all the driver INF and CAT files here
Source: "mcci-catena-samd.cat"; DestDir: "{tmp}\drivers"; Flags:solidbreak
Source: "mcci-catena-samd.inf"; DestDir: "{tmp}\drivers";
;Source: "mcci-catena-samd.cat"; DestDir: "{tmp}\drivers";
;Source: "mcci-catena-samd.inf"; DestDir: "{tmp}\drivers";

[Run]
Filename: {tmp}\drivers\dpinst-amd64.exe; Description: "64-bit MCCI Catena USB Driver Setup"; Check: Is64BitInstallMode
