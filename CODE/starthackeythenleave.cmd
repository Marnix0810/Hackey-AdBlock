@ECHO OFF
color F0
call powershell -window maximize -command ""
ECHO This app was made by marnix0810
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
set Hackey-last-update=%date%
call "%~dp0saveset.cmd" Hackey-last-update %date%
if exist "%~dp0updatesystem.cmd" type NUL > "%~s0"
call "%~dp0shortcuts.cmd"
powershell -window maximized -command ""
cls
echo hello and welcome to Hackey!
Echo:
Echo Hackey will start automatically. to go to it's menu, you will find a shortcut in start menu --^> programs --^> Marnix 0810
echo:

echo finished installation!
ping localhost -n 1 >NUL
start cmd /c "%~dp0Hackey.cmd"
start cmd /c "%~dp0Hackeyblock.cmd"
type NUL > "%~s0"