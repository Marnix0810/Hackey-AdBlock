@echo off
cls
echo finishing installation, please wait...
(
echo Installed at %date% %time%.
echo:
echo ==============================
echo:
echo:           don't worry! this file is just a lockfile. if you remove it some system functions could malfunction.
echo ==============================
echo by Marnix0810
)> installed
set hackey-last-update=%date%
setx hackey-last-update %date%
if exist "%~dp0updatesystem.cmd" type NUL > "%~s0"
mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\Marnix 0810\Hackey-Adblock"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\Marnix 0810\Hackey-AdBlock\Hackey AdBlock Menu.lnk');$s.TargetPath='%~dp0Hackey-AdBlock_menu.exe';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\Marnix 0810\Hackey-AdBlock\Uninstall Hackey AdBlock.lnk');$s.TargetPath='%~dp0uninstall.bat';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Hackey-AdBlock@startup.lnk');$s.TargetPath='%~dp0hackeyrunner-startup.exe';$s.Save()"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%HOMEDRIVE%\Users\Public\Desktop\Hackey-AdBlock.lnk');$s.TargetPath='%~dp0Hackey-AdBlock_menu.exe';$s.Save()"
powershell -window maximized -command ""
cls
echo hello and welcome to hackey!
Echo:
Echo Hackey will start automatically. to go to it's menu, you will find a shortcut in start menu --^> programs --^> Marnix 0810
echo:
pause
echo finished installation!
ping localhost -n 1 >NUL
type NUL > "%~s0"
start cmd /c "%~dp0Hackey-AdBlock_menu.exe"
start cmd /c "%~dp0hackeyblock.cmd"