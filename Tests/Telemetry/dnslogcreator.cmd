@echo off
REM The DNS telemetry script is based on https://stackoverflow.com/a/20136226/11441447 this answer on Stackoverflow.
  REM :top
for /f "delims=: tokens=2" %%i in ('ipconfig /displaydns^|find "Record Name"') do (find "%%i" /i dnstelemetry.log >nul 2>&1|| echo %%i >>dnstelemetry.log)
timeout /nobreak 5 >nul 2>&1
sort dnstelemetry.log /o dnstelemetry.log
  REM GOTO top
