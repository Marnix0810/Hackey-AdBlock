@echo off
powershell -window hidden -command ""
cd /d "%~dp0HTA\"
if exist confirm-dnslogcreator.HTA del confirm-dnslogcreator.HTA /y /q
call powershell -command "iwr -outf confirm-dnslogcreator.HTA https://raw.githubusercontent.com/Marnix0810/HackeyBlock/master/individual_scripts/Telemetry/DNS-log/HTA/confirm-dnslogcreator.HTA"
cd /d "%~dp0"
for /F "delims=" %%a in ('mshta.exe "%~dp0HTA\confirm-dnslogcreator.HTA"') do set "HTAreply=%%a"
if not "%HTAreply%"=="1" (
notifu /t warn /p "Hackey Telemetry - DNS log upload canceled" /m "OK. The upload was canceled. \n\nyou can always change your mind!" /i "%~dp0icon.ico"
exit /b
)
notifu /p "Hackey Telemetry - DNS log upload" /m "The creation of this log depends on files that Windows logged, the extraction of information is a little hard. This might take some time.\n\nI am happy you want to help me!" /i "%~dp0icon.ico"
REM This DNS telemetry script is based on https://stackoverflow.com/a/20136226/11441447 this answer on Stackoverflow.
  REM :top
for /f "delims=: tokens=2" %%i in ('ipconfig /displaydns^|find "Record Name"') do (find "%%i" /i dnstelemetry.log >nul 2>&1|| echo %%i >>dnstelemetry.log)
timeout /nobreak 5 >nul 2>&1
sort dnstelemetry.log /o dnstelemetry.log
  REM GOTO top
xcopy /y dnstelemetry.log "%userprofile%\*"
7za a "%userprofile%\DNSlog_for-telemetry-to-marnix0810.7z" dnstelemetry.log -p"zeroeightonezero-yo0810" -sdel
powershell -window normal -command ""
:message
cls
color F0
Echo okay, the log is created. Now we need to send it. Marnix 0810 created a form to do this, you can find it on https://marnix0810.wordpress.com/downloads/hackey/telemetry/dnslog/
Echo you can find the log in your user profile folder: %userprofile%\DNSlog_for-telemetry-to-marnix0810.7z", the file is encrypted but not using a safe password ^(just so bots and dummies won't get in.^)
Echo marnix 0810 recommends using the form on his site, https://marnix0810.wordpress.com/downloads/hackey/telemetry/dnslog/ or using email to programmer.marxin0810@gmail.com. For privacy reasons, the form is a better choice. 
Echo Also: in both cases Marnix 0810 recommends using the Firefox Send service or Wetransfer instead of sending the file as attachment, the Firefox Send service can be found at send.firefox.com and
ECHO Wetransfer can be found at wetransfer.com, both file sharing services can be used for free.
echo:
echo:
echo If you want to view your list of DNS addresses, please open the text file "dnstelemetry.log", located in the folder "%userprofile%" here you will find the exact list that will be sent.
:endofmessage
goto endofmessage
