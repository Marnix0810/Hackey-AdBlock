if "%Hackeyonstartup-timeout%"=="Not" exit
@ECHO OFF
cls
color F0
call powershell -window maximize -command ""
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

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
title hackey@startup
if not "%Hackeyonstartup-timeout%"=="" (
    if not "%Hackeyonstartup-timeout%"=="off" (
        powershell -window hidden -command ""
        timeout /nobreak /t %Hackeyonstartup-timeout%
        powershell -window minimized -command ""
    )

)
call "%~dp0hackeyblock.cmd" /referencestartup
