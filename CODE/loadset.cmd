@echo off
echo loading system-wide settings...
cd /d "%programdata%\HackeyBlock\"
for /f "delims=" %%i in (systemwidesettings.inf) do (
cls
set "%%i"
echo setting %%i was loaded.
)
cls
echo changing directory to where HackeyBlock was installed.
cd /d "%~dp0"
cls
echo ---^> Settings succesfully loaded.
