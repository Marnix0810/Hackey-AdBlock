@ECHO OFF
color F0
title Hackey-AdBlock Downloader And Installer
call powershell -window maximize -command ""
ECHO This app was made by marnix0810
cls
echo locating installer for HackeyBlock
call powershell -command "iwr -outf updurl.txt https://raw.githubusercontent.com/Marnix0810/HackeyBlock/master/updurl.txt"
set /p "updurl="<"updurl.txt"
echo downloading installer for HackeyBlock.
call powershell -command "iwr -outf Hackeysetup.exe %updurl%"
cls
Echo starting installer...
start /wait Hackeysetup.exe
exit