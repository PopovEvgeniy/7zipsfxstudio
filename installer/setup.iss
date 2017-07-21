[Setup]
AppName=7-ZIP SFX STUDIO
AppVersion=2.1.4
AppPublisher=Tuzik
AppPublisherURL=http://tuzik87.ru54.com/
AppSupportURL=http://tuzik87.ru54.com/
AppUpdatesURL=http://tuzik87.ru54.com/
DefaultDirName={pf}\7ZIP SFX STUDIO
DefaultGroupName=7ZIP SFX STUDIO
DisableProgramGroupPage=yes
OutputDir=C:\7ZIP SFX STUDIO
OutputBaseFilename=7zipsfxstudioinst
Compression=lzma/ultra64
SolidCompression=true
InternalCompressLevel=ultra64
MinVersion=4.1.2222,5.0.2195
RestartIfNeededByRun=false
PrivilegesRequired=none
UsePreviousAppDir=false
DisableReadyPage=true
UsePreviousSetupType=false
UsePreviousTasks=false
ShowLanguageDialog=no
AllowCancelDuringInstall=false
Uninstallable=IsTaskSelected('typical')

[Files]
Source: C:\7ZIP SFX STUDIO\Version 2.1.4\deploy\sevenzipsfxstudio.exe; DestDir: {app}; Flags: ignoreversion
Source: C:\7ZIP SFX STUDIO\Version 2.1.4\deploy\readme.txt; DestDir: {app}; Flags: ignoreversion
Source: C:\7ZIP SFX STUDIO\Version 2.1.4\deploy\copying.txt; DestDir: {app}; Flags: ignoreversion
Source: C:\7ZIP SFX STUDIO\Version 2.1.4\deploy\source.zip; DestDir: {app}; Flags: ignoreversion; Components: source

[Icons]
Name: {group}\7ZIP SFX STUDIO; Filename: {app}\sevenzipsfxstudio.exe; IconIndex: 0; Tasks: typical
Name: {group}\Documentation\Help; Filename: {app}\readme.txt; Tasks: typical; Flags: runmaximized
Name: {group}\Documentation\License; Filename: {app}\copying.txt; Tasks: typical; Flags: runmaximized
Name: {group}\Source code; Filename: {app}\source.zip; Tasks: typical; Components: source
Name: {group}\Unistall 7ZIP SFX STUDIO; Filename: {app}\unins000.exe; Tasks: typical

[Types]
Name: Normal; Description: Normal install; Flags: iscustom

[Components]
Name: Main; Description: Program files; Flags: fixed; Types: Normal
Name: Source; Description: Source code

[Tasks]
Name: typical; Description: Typical install; Flags: exclusive
Name: portable; Description: Install to portable media; Flags: exclusive unchecked
