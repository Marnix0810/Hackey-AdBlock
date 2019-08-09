@ECHO OFF
color F0
title HackeyBlock WE Downloader And Installer
call powershell -window maximize -command ""
ECHO This app was made by marnix0810
:ret1
cls
echo locating installer for HackeyBlock
del /f /q latest-version.txt >NUL
call powershell -command "iwr -outf latest-version.txt https://raw.githubusercontent.com/Marnix0810/HackeyBlock-Windows/master/latest-release.txt"
set /p "latestver="<"latest-version.txt"
set updurl=https://github.com/Marnix0810/HackeyBlock-Windows/releases/download/v%latestver%/Hackeyblocksetup-%latestver%.exe
if "%locman%"=="1" (
cls
echo locating installer for HackeyBlock using alternative download system.
call powershell -command "iwr -outf updurl.txt https://raw.githubusercontent.com/Marnix0810/HackeyBlock-Windows/master/updurl.txt"
set /p "updurl="<"updurl.txt"
)
echo downloading installer for HackeyBlock.
call powershell -command "iwr -outf Hackeysetup.exe %updurl%"
cls
Echo starting installer...
start /wait Hackeysetup.exe || (
echo E: unknown error while updating.
echo retrying now...
set locman=1
goto ret1
)
exit