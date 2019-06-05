@echo off

REM Get version number
set /p "numb1="<"%~dp0..\latest-version.txt"
set /a numb1+=1
set /a vernumb=%numb1%

REM Organize Ad-list
type "%userprofile%\Github\Hackey-AdBlock\hackey-adlist.txt">"%~dp0addomainlist.txt"
type addomainlist.txt | findstr /v # | findstr /v \/ | findstr /v = > addomainlist.txt.new
move /y addomainlist.txt.new addomainlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat addomainlist.txt /u >addomainlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y addomainlist.txt.new hackey-adlist.txt >nul
move hackey-adlist.txt "%userprofile%\Github\Hackey-AdBlock\" >nul
del /f /q "%~dp0addomainlist.txt"

REM Organize Privacy-list
type "%userprofile%\Github\Hackey-AdBlock\hackey-privacy.txt">"%~dp0trackerlist.txt"
type trackerlist.txt | findstr /v # | findstr /v \/ | findstr /v = > trackerlist.txt.new
move /y trackerlist.txt.new trackerlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat trackerlist.txt /u >trackerlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y trackerlist.txt.new hackey-privacy.txt >nul
move hackey-privacy.txt "%userprofile%\Github\Hackey-AdBlock\" >nul
del /f /q "%~dp0trackerlist.txt"

REM 
