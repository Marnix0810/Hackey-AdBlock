@ECHO OFF
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges for update...
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
    CD /D "%Toinstallationfolder%"
:--------------------------------------
set Toinstallationfolder=%ProgramFiles%\marnix0810\Hackey-AdBlock\
if not "%ProgramFiles(x86)%"=="" set Toinstallationfolder=%ProgramFiles(x86)%\marnix0810\Hackey-AdBlock\
CD /D "%Toinstallationfolder%"
:ret2
cls
echo checking for updates.
FOR /F "usebackq tokens=1" %%A IN (`PING google.com`) DO (
    REM Check the current line for the indication of a successful connection.
    IF /I "%%A"=="Reply" SET Connected=true
)
If "%connected%"=="false" (
cls
echo ... no internet connection found. Update system needs internet.
goto ret2
)
del /f /q latest-version.txt >NUL
call powershell -command "iwr -outf latest-version.txt https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/latest-release.txt"
set /p "latestver="<"latest-version.txt"
set /p "installedver="<"hackey-install-version.txt"
if "%latestver%"=="%installedver%" (
echo Hackey is up-to-date. Installed version: 
type hackey-install-version.txt
goto don2
)
cls
echo update is available.
taskkill /f /im python.exe
taskkill /f /im powershell.exe
echo Restoring onblocked patrons of hostsfile.
copy C:\Windows\System32\drivers\etc\hosts_before-Hackey.bkup C:\Windows\System32\drivers\etc\hosts /y
del /q /f "installed"
(
echo TYPE "%Toinstallationfolder%updatesystem.cmd.hackeyscript" ^>  "%Toinstallationfolder%updatesystem.cmd"
echo CALL updatesystem.cmd
echo exit /b
)> hackeyblock.cmd
:ret1
cls
echo deleting old version.
del /f /q /s "%Toinstallationfolder%*.*"
cls
echo Downloading the update, please wait...
call powershell -command "iwr -outf updatesfx.exe https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/updatesfx.exe"
cls
echo installing update.
start /wait updatesfx.exe -o"%Toinstallationfolder%" -y
cls
Echo checking if update went well...
if not exist "%Toinstallationfolder%installed" (
echo E: unknown error while updating.
echo retry is needed, files are deleted and to make sure Hackey keeps working, you should install the update... sorry!
goto ret1
)
cls
echo Update went well!
:don1
cls
echo please wait...
call "%Toinstallationfolder%shortcuts.cmd"
cls
echo hello and welcome to hackey!
Echo:
Echo Hackey will start automatically. to go to it's menu, you will find a shortcut in start menu --^> programs --^> Marnix 0810
echo:
pause
echo finished update!
ping localhost -n 1 >NUL
type NUL > "%~s0"
start cmd /c "%Toinstallationfolder%Hackey-AdBlock_menu.exe"
start cmd /c "%Toinstallationfolder%hackeyblock.cmd"
exit
:don2
timeout /t 5 >NUL
exit
