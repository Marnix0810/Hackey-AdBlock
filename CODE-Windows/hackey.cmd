@ECHO OFF
color F0
CD /D "%~dp0"
if not "%Adminrequested%"=="1" (
call "%~dp0HARR.cmd" "%~s0"
)
type nul> startHackeythenleave.cmd
del /f /q startHackeythenleave.cmd
pushd "%CD%"
CD /D "%~dp0"
ECHO This app was made by Marnix 0810
call "%~dp0loadset.cmd"
REM check 4 updates
if "%Hackey-update-day%"=="" call :select_update_DOW
if "%Hackey-last-update%"=="%date%" goto updateisdone
echo Checking for permission to check for update...
call :getdow
if "%Hackey-update-day%"=="%dayofweek%" goto autoupdate
if "%Hackey-update-day%"=="all" goto autoupdate
:updateisdone
echo Preparing to show menu... please wait.
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
:Extractassets
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
  )
if "%_os_bitness%"=="32" start "" "%~dp0assets-sfx.7z.exe" -o"%~dp0" -y -bso0 -bsp0
if "%_os_bitness%"=="64" start "" "%~dp0assets64-sfx.7z.exe" -o"%~dp0" -y -bso0 -bsp0


if not exist "%userprofile%\personalHackeylist.txt" (
type NUL > "%userprofile%\personalHackeylist.txt"
)
:settings.home
powershell -window hidden -command ""
:getvermes
cd /d "%~dp0"
set /p "installedver="<"Hackey-install-version.txt"
del /f /q "%~dp0versionmessage-%installedver%.txt"
set "vermessage_o=https://raw.githubusercontent.com/Marnix0810/HackeyBlock/master/versionmessages/%installedver%.txt"
call powershell -command "iwr -outf versionmessage-%installedver%.txt %vermessage_o%"
set "vermessage_l=%~dp0versionmessage-%installedver%.txt"
if not exist "%vermessage_l%" (
echo No messages. >"%vermessage_l%"
)
(
echo:
echo:
echo Your version of Hackey is %installedver%.
)>>"%vermessage_l%"
type "%vermessage_l%">vermessage-installed.txt
set "HTAreply="
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\MENU-HOME.HTA"') do set "HTAreply=%%a"
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
if "%HTAreply%"=="6" start "" "http://localhost:3803/AutoTest/#if-this-doesn't-load-Hackey-is-not-working"
if "%HTAreply%"=="9" call :adddomaintopersonallist
if "%HTAreply%"=="7" call :uninstall
if "%HTAreply%"=="8" goto sleep_loop
if "%HTAreply%"=="" goto sleep_loop
if "%HTAreply%"=="upload-dns.log" goto upload-dns.log
if "%HTAreply%"=="change.log" start "" "https://github.com/Marnix0810/HackeyBlock/blob/master/CHANGELOG.MD#changelog-for-the-marnix0810s-HackeyBlock-project"
goto settings.home
:set_update_freq
call "%~dp0saveset.cmd" Hackey-update-day ""
set "Hackey-update-day="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\SET-UPDATE-DAY.HTA"') do set "Hackey-update-day=%%a"
call "%~dp0saveset.cmd" Hackey-update-day %Hackey-update-day%
exit /b

:set_startup_timeout
call "%~dp0saveset.cmd" Hackeyonstartup-timeout ""
set "Hackeyonstartup-timeout="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\setstartuptimeout.HTA"') do set "Hackeyonstartup-timeout=%%a"
call "%~dp0saveset.cmd" Hackeyonstartup-timeout %Hackeyonstartup-timeout%
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\HackeyBlock sevice starter.lnk');$s.TargetPath='%~dp0Hackeyrunner-startup.cmd';$s.Save()"
exit /b
:autoupdate
:force_NOW_update
md "%tmp%\Hackey"
TYPE "%~dp0updatesystem.cmd.Hackeyscript.cmd" >  "%tmp%\Hackey\updatesystem.cmd"
CALL "%tmp%\Hackey\updatesystem.cmd"
exit /b
:adddomaintopersonallist
start "" "https://github.com/Marnix0810/HackeyBlock/wiki/How-does-the-personal-blocking-list-work%3F"
start /wait notepad "%userprofile%\personalHackeylist.txt"
timeout /t 2 /nobreak > NUL
start cmd /c "%~dp0Hackeyblock.cmd"
exit /b
:turn-privacy-on-or-off
call "%~dp0saveset.cmd" Hackey-privacy-on-or-off ""
set "Hackey-privacy-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\Hackey-privacy-on-or-off.HTA"') do set "Hackey-privacy-on-or-off=%%a"
call "%~dp0saveset.cmd" Hackey-privacy-on-or-off %Hackey-privacy-on-or-off%
exit /b
:turn-adblock-on-or-off
call "%~dp0saveset.cmd" HackeyBlock-on-or-off ""
set "HackeyBlock-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\HackeyBlock-on-or-off.HTA"') do set "HackeyBlock-on-or-off=%%a"
call "%~dp0saveset.cmd" HackeyBlock-on-or-off %Hackey-privacy-on-or-off%
exit /b
:turn-adultblock-on-or-off
call "%~dp0saveset.cmd" Hackey-adultblock-on-or-off ""
set "Hackey-adultblock-on-or-off="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\Hackey-adultblock-on-or-off.HTA"') do set "Hackey-adultblock-on-or-off=%%a"
call "%~dp0saveset.cmd" Hackey-adultblock-on-or-off %Hackey-privacy-on-or-off%
exit /b
:uninstall
md "%tmp%\Hackey"
xcopy uninstall.bat "%tmp%\Hackey\" /y
call "%tmp%\Hackey\uninstall.bat" "%~dp0"
exit /b
:sleep_loop
powershell -window hidden -command ""
notifu /t info /p "HackeyBlock" /m "Click here to reopen the menu.\n\n(Close this message to close the menu fully)" /c /i "%~dp0icon.ico"
if "%errorlevel%"=="3" goto sleep_outwait
if "%errorlevel%"=="4" goto sleep_close
goto sleep_loop
:sleep_close
notifu /t warn /p "HackeyBlock" /m "Hackey is closed...\n\n(You can still reopen it from start menu.)" /i "%~dp0icon.ico"
exit
:sleep_outwait
goto settings.home
exit
:upload-dns.log
echo Downloading and extracting files needed... please wait.
if exist dnslogcreator.telemetry.cmd del dnslogcreator.telemetry.cmd /y /q
call powershell -command "iwr -outf dnslogcreator.telemetry.cmd https://raw.githubusercontent.com/Marnix0810/HackeyBlock/master/individual_scripts/Telemetry/DNS-log/dnslogcreator.telemetry.cmd"
call dnslogcreator.telemetry.cmd
goto settings.home
exit
:getdow
@echo off
setlocal
for /f "delims=" %%a in ('wmic path win32_localtime get dayofweek /format:list ') do for /f "delims=" %%d in ("%%a") do set %%d
echo day of the week: %dayofweek%
endlocal
exit /b