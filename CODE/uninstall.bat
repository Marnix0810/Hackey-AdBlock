@ECHO OFF
color F0
if exist "%~dp0unins000.exe" (
start "" "%~dp0unins000.exe"
exit
)
if exist "%~dp1unins000.exe" (
start "" "%~dp1unins000.exe"
exit
)
call powershell -window maximize -command ""
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"


:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
call "%~dp0loadset.cmd"
powershell -window maximize -command ""
echo Are you 100%% sure to remove Hackey from your system?
pause
echo Press a key to start uninstallation of HackeyBlock . . .
pause>nul
cd /D "%~dp1"
echo Stoppen van Hackey-opvangpagina's
taskkill /f /im python.exe
taskkill /f /im powershell.exe
echo Ongeblokkeerde patronen terugzetten...
copy C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup C:\Windows\System32\drivers\etc\hosts /y
echo Uitschakelen en verwijderen van Hackey services . . .
del /f /q "%tmp%\Hackeyredirectfromads.cmd"
del /f /q "%cd%\servstatus.log"
FOR /F "tokens=*" %%G IN ('dir/b /s ^"%cd%\*^"') DO (
type NUL> "%%G"
del /f /q "%%G"
)
cd /d ..
rd /s /q "%~dp1"
start "" "http://localhost:3803/AutoTest/#if-this-doesn't-load-Hackey-is-not-active"
type NUL > "%~s0"
