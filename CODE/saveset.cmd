@echo off
if not exist "%programdata%\HackeyBlock\systemwidesettings.inf" md "%programdata%\HackeyBlock\"
echo saving setting: %1 = %2
echo %~1=%~2 > "%programdata%\HackeyBlock\systemwidesettings.inf"
setx HackeyAdBlockSettingsSaveFile "%programdata%\HackeyBlock\systemwidesettings.inf"
setx %1 %2