@ECHO OFF
color F0
type nul> starthackeythenleave.cmd
del /f /q starthackeythenleave.cmd
call powershell -window maximize -command ""
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges for Hackey-AdBlock...
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
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Hackey AdBlock by Marnix 0810\Hackey AdBlock Menu.lnk" call "%~dp0shortcuts.cmd"
:startoptional
REM Run-after-update scripts if neccessary.
cd /d "%~dp0"
if exist afterupdate.cmd.hackeyscript.cmd (
ren afterupdate.cmd.hackeyscript postupdate.cmd
)
call postupdate.cmd
if exist postupdate.cmd (
del postupdate.cmd
)
if not exist "%userprofile%\personalhackeylist.txt" (
type NUL > "%userprofile%\personalhackeylist.txt"
)
cd /d "%~dp0"
:settings.home
powershell -window hidden -command ""
set "HTAreply="
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\MENU-HOME.HTA"') do set "HTAreply=%%a"
powershell -window minimized -command ""
if "%HTAreply%"=="License" start "" "https://github.com/Marnix0810/Hackey-AdBlock/blob/master/LICENSE"
if "%HTAreply%"=="Privacy" call :turn-privacy-on-or-off
if "%HTAreply%"=="1" call :set_update_freq
if "%HTAreply%"=="2" call :set_startup_timeout
if "%HTAreply%"=="3" call :force_NOW_update
if "%HTAreply%"=="4" start cmd /c "%~dp0hackeyblock.cmd"
if "%HTAreply%"=="5" (
start cmd /c "%~dp0stop-hackey.cmd"
exit
)
if "%HTAreply%"=="6" start "" "http://hackeytester-if-this-doesnt-load-hackeys-not-active.hello:3803/AutoTest"
if "%HTAreply%"=="9" call :adddomaintopersonallist
if "%HTAreply%"=="7" call :uninstall
if "%HTAreply%"=="8" exit
if "%HTAreply%"=="change.log" start "" "https://github.com/Marnix0810/Hackey-AdBlock/blob/master/CHANGELOG.MD#changelog-for-the-marnix0810s-hackey-adblock-project"
goto settings.home
:set_update_freq
setx hackey-update-day ""
set "hackey-update-day="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\SET-UPDATE-DAY.HTA"') do set "hackey-update-day=%%a"
setx hackey-update-day %hackey-update-day%
exit /b

:set_startup_timeout
setx Hackeyonstartup-timeout ""
set "Hackeyonstartup-timeout="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\setstartuptimeout.HTA"') do set "Hackeyonstartup-timeout=%%a"
setx Hackeyonstartup-timeout %Hackeyonstartup-timeout%
exit /b
:force_NOW_update
TYPE "%~dp0updatesystem.cmd.hackeyscript.cmd" >  "%~dp0updatesystem.cmd"
CALL updatesystem.cmd
exit /b
:adddomaintopersonallist
start "" "https://github.com/Marnix0810/Hackey-AdBlock/wiki/How-does-the-personal-blocking-list-work"
start /wait notepad "%userprofile%\personalhackeylist.txt"
timeout /t 2 /nobreak > NUL
start cmd /c "%~dp0hackeyblock.cmd"
exit /b
:turn-privacy-on-or-off
setx hackey-privacy-on-or-off ""
set "hackey-privacy-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\hackey-privacy-on-or-off.HTA"') do set "hackey-privacy-on-or-off=%%a"
setx hackey-privacy-on-or-off %hackey-privacy-on-or-off%
exit /b
:uninstall
md "%tmp%\hackey"
xcopy uninstall.bat "%tmp%\hackey\" /y
call "%tmp%\hackey\uninstall.bat" "%~dp0"
exit /b
