:Start
@echo off
REM Get version number
set /p "numb2="<"%~dp0numb2.txt"
set /a numb2+=1
echo:%numb2%>"%~dp0numb2.txt"
set /p "numb1="<"%~dp0numb1.txt"
set vernumb=%numb1%.%numb2%
set newver=%vernumb%

echo Next version will be %newver%. This is the changelog for now:
ECHO:
type "%~dp0..\CHANGELOG.MD"
ECHO:
ECHO:
ECHO:
echo -----------------------------------------------------------
echo the marking, -- if necessary -- should be:
echo ## changelog for version %newver%
echo -----------------------------------------------------------
ECHO:
TYPE CON >> "%~dp0..\CHANGELOG.MD"
echo submitted!
goto Start