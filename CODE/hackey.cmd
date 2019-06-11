@ECHO OFF
color F0
type nul> startHackeythenleave.cmd
del /f /q startHackeythenleave.cmd
call powershell -window maximize -command ""
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges for HackeyBlock...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
ECHO This app was made by marnix0810
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\HackeyBlock by Marnix 0810\HackeyBlock Menu.lnk" call "%~dp0shortcuts.cmd"
:startoptional
REM Run-after-update scripts if neccessary.
cd /d "%~dp0"
if exist afterupdate.cmd.Hackeyscript.cmd (
ren afterupdate.cmd.Hackeyscript postupdate.cmd
)
call postupdate.cmd
if exist postupdate.cmd (
del postupdate.cmd
)
if not exist "%userprofile%\personalHackeylist.txt" (
type NUL > "%userprofile%\personalHackeylist.txt"
)
cd /d "%~dp0"
:settings.home
powershell -window hidden -command ""
set "HTAreply="
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\MENU-HOME.HTA"') do set "HTAreply=%%a"
powershell -window minimized -command ""
if "%HTAreply%"=="License" start "" "https://github.com/Marnix0810/HackeyBlock/blob/master/LICENSE"
if "%HTAreply%"=="Privacy.list" call :turn-privacy-on-or-off
if "%HTAreply%"=="Adblock.list" call :turn-adblock-on-or-off
if "%HTAreply%"=="Adult.list" call :turn-adultblock-on-or-off


if "%HTAreply%"=="1" call :set_update_freq
if "%HTAreply%"=="2" call :set_startup_timeout
if "%HTAreply%"=="3" call :force_NOW_update
if "%HTAreply%"=="4" start cmd /c "%~dp0Hackeyblock.cmd"
if "%HTAreply%"=="5" (
start cmd /c "%~dp0stop-Hackey.cmd"
exit
)
if "%HTAreply%"=="6" start "" "http://localhost:3803/AutoTest/#if-this-doesn't-load-Hackey-is-not-active"
if "%HTAreply%"=="9" call :adddomaintopersonallist
if "%HTAreply%"=="7" call :uninstall
if "%HTAreply%"=="8" exit
if "%HTAreply%"=="change.log" start "" "https://github.com/Marnix0810/HackeyBlock/blob/master/CHANGELOG.MD#changelog-for-the-marnix0810s-HackeyBlock-project"
goto settings.home
:set_update_freq
setx Hackey-update-day ""
set "Hackey-update-day="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\SET-UPDATE-DAY.HTA"') do set "Hackey-update-day=%%a"
setx Hackey-update-day %Hackey-update-day%
exit /b

:set_startup_timeout
setx Hackeyonstartup-timeout ""
set "Hackeyonstartup-timeout="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\setstartuptimeout.HTA"') do set "Hackeyonstartup-timeout=%%a"
setx Hackeyonstartup-timeout %Hackeyonstartup-timeout%
exit /b
:force_NOW_update
md "%tmp%\Hackey"
TYPE "%~dp0updatesystem.cmd.Hackeyscript.cmd" >  "%tmp%\Hackey\updatesystem.cmd"
CALL "%tmp%\Hackey\updatesystem.cmd"
exit /b
:adddomaintopersonallist
start "" "https://github.com/Marnix0810/HackeyBlock/wiki/How-does-the-personal-blocking-list-work"
start /wait notepad "%userprofile%\personalHackeylist.txt"
timeout /t 2 /nobreak > NUL
start cmd /c "%~dp0Hackeyblock.cmd"
exit /b
:turn-privacy-on-or-off
setx Hackey-privacy-on-or-off ""
set "Hackey-privacy-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\Hackey-privacy-on-or-off.HTA"') do set "Hackey-privacy-on-or-off=%%a"
setx Hackey-privacy-on-or-off %Hackey-privacy-on-or-off%
exit /b
:turn-adblock-on-or-off
setx HackeyBlock-on-or-off ""
set "HackeyBlock-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\HackeyBlock-on-or-off.HTA"') do set "HackeyBlock-on-or-off=%%a"
setx HackeyBlock-on-or-off %Hackey-privacy-on-or-off%
exit /b
:turn-adultblock-on-or-off
setx Hackey-adultblock-on-or-off ""
set "Hackey-adultblock-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\Hackey-adultblock-on-or-off.HTA"') do set "Hackey-adultblock-on-or-off=%%a"
setx Hackey-adultblock-on-or-off %Hackey-privacy-on-or-off%
exit /b
:uninstall
md "%tmp%\Hackey"
xcopy uninstall.bat "%tmp%\Hackey\" /y
call "%tmp%\Hackey\uninstall.bat" "%~dp0"
exit /b
