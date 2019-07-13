@ECHO OFF
color F0
call powershell -window maximize -command ""
if not "%Adminrequested%"=="1" (
call HARR "%~s0"
)
    pushd "%CD%"
    CD /D "%~dp0"
call "%~dp0loadset.cmd"
echo Stoppen van Hackey-opvangpagina's . . .
taskkill /f /im python.exe
taskkill /f /im powershell.exe
echo Ongeblokkeerde patronen terugzetten...
copy C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup C:\Windows\System32\drivers\etc\hosts /y
start "" "http://Hackeytester-if-this-doesnt-load-Hackeys-not-active.hello:3803/AutoTest"
start taskkill /f /im cmd.exe