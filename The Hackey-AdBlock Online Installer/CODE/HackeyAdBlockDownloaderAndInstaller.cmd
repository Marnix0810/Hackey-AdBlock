@ECHO OFF
color F0
title Hackey-AdBlock Downloader And Installer
call powershell -window maximize -command ""
ECHO This app was made by marnix0810
echo downloading installer for Hackey AdBlock.
call powershell -command "iwr -outf updatesfx.exe https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/updatesfx.exe"
cls
echo installing Hackey AdBlock.
ren updatesfx.exe hackeyfilesextractor.exe
set Toinstallationfolder=%ProgramFiles%\marnix0810\Hackey-AdBlock
if not "%ProgramFiles(x86)%"=="" set Toinstallationfolder=%ProgramFiles(x86)%\marnix0810\Hackey-AdBlock
start /wait /max hackeyfilesextractor.exe -o"%Toinstallationfolder%" -y
start /b cmd /c "%Toinstallationfolder%\starthackeythenleave.cmd"