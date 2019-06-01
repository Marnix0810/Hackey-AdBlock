@ECHO OFF
color F0
call powershell -window maximize -command ""
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
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
:--------------------------------------
SET Connected=false
FOR /F "usebackq tokens=1" %%A IN (`PING google.com`) DO (
    REM Check the current line for the indication of a successful connection.
    IF /I "%%A"=="Reply" SET Connected=true
)
If "%connected%"=="false" (
start MSHTA "%~dp0files\HTAfiles\NOTCONNECTED.HTA"
call :waitforconnection
)
powershell -window minimized -command ""
ECHO This app was made by marnix0810
REM questions about this code?
REM mail to:
REM programmer.marxin0810@gmail.com


REM Clean the mess up that was made previously
del /f /q "%tmp%\hackeyredirectfromads.cmd"
del /f /q "%~dp0updatesystem.cmd"
del /f /q "%~dp0mdmhostlist.txt"
del /f /q "%~dp0extracthackeyforinstaller.bat"
taskkill /f /im powershell.exe
taskkill /f /im python.exe
echo copying the unblocked patrons...
copy C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup  C:\hosts.edit.tmp /y
cls



REM check 4 updates
if "%hackey-update-day%"=="" call :select_update_DOW
if "%hackey-last-update%"=="%date%" goto updateisdone
echo controleren of er updates moeten worden gedownload...
call :getdow
if "%hackey-update-day%"=="%dayofweek%" goto autoupdate
if "%hackey-update-day%"=="all" goto autoupdate
:updateisdone



REM Run-after-update scripts if neccessary.
cd /d "%~dp0"
if exist afterupdate.cmd.hackeyscript (
ren afterupdate.cmd.hackeyscript postupdate.cmd
)
call postupdate.cmd
if exist postupdate.cmd (
del postupdate.cmd
)
REM       make sure to not be too loud
REM choice /m "Should hackey go to background?" /c YN /d Y /t 10
REM if "%errorlevel%"=="1" (
powershell -window hidden -command ""
REM )
REM powershell -window minimized -command ""

REM Check if Python is installed. If not, start installer and check again.

:chkpi
cls
python -c "print('python is functional')" || (
call :Extractpython
)


REM activate the ad-replace server.
del /f /q "%~dp0servstatus.log"
(
echo @echo off
echo echo server started. ^> "%~dp0servstatus.log" 
echo :retry
echo cd /D "%~dp0"
echo python -m http.server 3803 --directory "%~dp0hackeyredirectfromads"
echo goto retry
) > "%tmp%\hackeyredirectfromads.cmd"
:startserv
copy "%~dp0icon.ico" "%~dp0hackeyredirectfromads\favicon.ico"
start /min powershell -window hidden -command "cmd /c %tmp%\hackeyredirectfromads.cmd"
:waitserv
cls
echo setting up catchpages . . .
echo wait a minute. if this takes too long, restart Hackey.
timeout /t 1 /nobreak >nul
if not exist "%~dp0servstatus.log" goto :waitserv




REM make sure ads are being catched.
if not exist C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup (
echo creating backups of the host file in C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup and C:\hosts_before-Hackey.bkup ...
type C:\Windows\System32\drivers\etc\hosts > C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup
type C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup > C:\hosts_before-Hackey.bkup
)


REM update redirections.
TYPE "C:\Windows\System32\drivers\etc\hosts" > "%temp%\hosts.edit.tmp"
set "blockedsitescounter="
del /f /q hackey-adlist.txt
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/hackey-adlist.txt', 'hackey-adlist.txt') }"
for /F "eol=; tokens=*" %%A in (hackey-adlist.txt) do (
ECHO # Hackey AdBlock Rule >> "%temp%\hosts.edit.tmp"
ECHO 127.0.0.1 %%A >> "%temp%\hosts.edit.tmp"
cls
echo added %%A to blocklist.
set /a blockedsitescounter+=1
)
powershell -command "& { (New-Object Net.WebClient).DownloadFile('http://www.malwaredomainlist.com/hostslist/hosts.txt', 'mdmhostlist.txt') }"
type mdmhostlist.txt >> "%temp%\hosts.edit.tmp"
del /f /q "%~dp0mdmhostlist.txt"
cd /d "%userprofile%"
for /F "eol=; tokens=*" %%A in (personalhackeylist.txt) do (
ECHO # Hackey Personal Blocking Rule >> "%temp%\hosts.edit.tmp"
ECHO 127.0.0.1 %%A >> "%temp%\hosts.edit.tmp"
cls
echo added %%A to blocklist.
set /a blockedsitescounter+=1
)
if not "%hackey-privacy-on-or-off%"=="off" call :Hackeyprivacy

cd /d "%~dp0"
TYPE "%temp%\hosts.edit.tmp" > "C:\Windows\System32\drivers\etc\hosts"


REM indicate the tasks are done.
start mshta vbscript:Execute("msgbox (""Hackey Background Service Is Activated. To check if it works, run AutoTest.""):fjidjsijdsjiiiubhfui close")
EXIT


EXIT
EXIT
EXIT
:autoupdate
TYPE "%~dp0updatesystem.cmd.hackeyscript" >  "%~dp0updatesystem.cmd"
call updatesystem.cmd
exit

:select_update_DOW
:set_update_freq
setx hackey-update-day ""
set "hackey-update-day="
powershell -window hidden -command ""
for /F "delims=" %%a in ('mshta.exe "%~dp0files\HTAfiles\SET-UPDATE-DAY.HTA"') do set "hackey-update-day=%%a"
setx hackey-update-day %hackey-update-day%
exit /b

:getdow
@echo off
setlocal
for /f "delims=" %%a in ('wmic path win32_localtime get dayofweek /format:list ') do for /f "delims=" %%d in ("%%a") do set %%d
echo day of the week: %dayofweek%
endlocal
exit /b

:Extractpython
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
  )
if "%_os_bitness%"=="32" start "" "%~dp0python-sfx.7z.exe" -o"%~dp0" -y
if "%_os_bitness%"=="64" start "" "%~dp0python64bit-sfx.7z.exe" -o"%~dp0" -y
exit /b

:Hackeyprivacy
del /f /q hackey-privacy.txt
powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/hackey-privacy.txt', 'hackey-privacy.txt') }"
for /F "eol=; tokens=*" %%A in (hackey-privacy.txt) do (
ECHO # HackeyPrivacy Blocking Rule >> "%temp%\hosts.edit.tmp"
ECHO 127.0.0.1 %%A >> "%temp%\hosts.edit.tmp"
cls
echo added %%A to blocklist.
set /a blockedsitescounter+=1
)
exit /b
:waitforconnection
powershell -window hidden -command ""
FOR /F "usebackq tokens=1" %%A IN (`PING google.com`) DO (
    REM Check the current line for the indication of a successful connection.
    IF /I "%%A"=="Reply" SET Connected=true
)
If "%connected%"=="true" exit /b
timeout /t 30 /nobreak
goto waitforconnection