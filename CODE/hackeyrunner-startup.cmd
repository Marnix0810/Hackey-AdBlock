if "%Hackeyonstartup-timeout%"=="Not" exit
@ECHO OFF
cls
color F0
call powershell -window maximize -command ""
if not "%Adminrequested%"=="1" (
call HARR "%~s0"
)

    pushd "%CD%"
    CD /D "%~dp0"
call "%~dp0loadset.cmd"
title Hackey@startup
if not "%Hackeyonstartup-timeout%"=="" (
    if not "%Hackeyonstartup-timeout%"=="off" (
        powershell -window hidden -command ""
        timeout /nobreak /t %Hackeyonstartup-timeout%
        powershell -window minimized -command ""
    )

)
call "%~dp0Hackeyblock.cmd" /referencestartup
