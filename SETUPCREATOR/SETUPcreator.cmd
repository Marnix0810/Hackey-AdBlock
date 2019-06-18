@echo off

REM Get version number
set /p "numb2="<"%userprofile%\OneDrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb2.txt"
set /a numb2+=1
echo:%numb2%>"%userprofile%\OneDrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb2.txt"
set /p "numb1="<"%userprofile%\OneDrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb1.txt"
set newver=%numb1%.%numb2%
choice /m "Set non-default version name/number"
if "%errorlevel%"=="1" (
cls
echo Default version number would be: %numb1%.%numb2%
set /p "newver=Set non-default version name/number:"
)
set vernumb=%newver%
echo:%vernumb%>"%~dp0..\latest-release.txt"
type "%~dp0..\latest-release.txt" > "%~dp0..\CODE\hackey-install-version.txt"
type "%~dp0..\LICENSE" > "%~dp0..\CODE\License.txt"
REM Organize Ad-list
type "%~dp0..\hackey-adlist.txt">"%~dp0addomainlist.txt"
type addomainlist.txt | findstr /v # | findstr /v \/ | findstr /v = > addomainlist.txt.new
move /y addomainlist.txt.new addomainlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat addomainlist.txt /u >addomainlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y addomainlist.txt.new hackey-adlist.txt >nul
move hackey-adlist.txt "%~dp0..\" >nul
del /f /q "%~dp0addomainlist.txt"

REM Organize Privacy-list
type "%~dp0..\hackey-privacy.txt">"%~dp0trackerlist.txt"
type trackerlist.txt | findstr /v # | findstr /v \/ | findstr /v = > trackerlist.txt.new
move /y trackerlist.txt.new trackerlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat trackerlist.txt /u >trackerlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y trackerlist.txt.new hackey-privacy.txt >nul
move hackey-privacy.txt "%~dp0..\" >nul
del /f /q "%~dp0trackerlist.txt"

REM Organize Adult-content list
type "%~dp0..\Adult-content-host-list.txt">"%~dp0adultcontentlist.txt"
type adultcontentlist.txt | findstr /v # | findstr /v \/ | findstr /v = > adultcontentlist.txt.new
move /y adultcontentlist.txt.new adultcontentlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat adultcontentlist.txt /u >adultcontentlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y adultcontentlist.txt.new Adult-content-host-list.txt >nul
move Adult-content-host-list.txt "%~dp0..\" >nul
del /f /q "%~dp0adultcontentlist.txt"


REM Display the lists
cls
@echo Ads:
@echo:
@type "%~dp0..\hackey-adlist.txt"
@echo:
@echo Trackers:
@echo:
@type "%~dp0..\hackey-privacy.txt"
@echo:
@echo Adult sites:
@echo:
@type "%~dp0..\Adult-content-host-list.txt"
@echo everything okay?
pause

REM Update the changelog
@ECHO off
type "%~dp0..\CHANGELOG.MD"
ECHO:
echo changelog for version %newver%: ^(typecon^)
ECHO:
(
ECHO:
echo ## changelog for version %newver%:
ECHO:
TYPE CON
) >> "%~dp0..\CHANGELOG.MD"
echo submitted!

REM Display the changelog
@type "%~dp0..\CHANGELOG.MD" > "%~dp0..\CODE\change.log"
@type "%~dp0..\CODE\change.log"
@echo everything okay?
pause


REM Start file editings.
cd /d "%~dp0..\CODE"

REM create setup.
call "%~dp0Assets\Winrar\WinRAR.exe" a SETUPnew.exe * -r -sfx -ilog -iimg"%~dp0logos\hackeylogo.bmp" -iico"%~dp0logos\hackeylogo.ico" -z"%~dp0files-for-setup\xfs.conf"
move SETUPnew.exe "%userprofile%\Onedrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\SETUPnew.exe"
ren "%userprofile%\Onedrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\SETUPnew.exe" Hackeyblocksetup-%vernumb%.exe
REM create update.
call "%~dp0Assets\7-Zip\7z.exe" a -r -sfx7z.sfx -mx1 "%~dp0..\updatesfx.exe" *
type NUL > "%tmp%\Hackeyblocksetup.7z"
del /f /q "%tmp%\Hackeyblocksetup.7z"
pause

@echo off
cls
echo:%userprofile%\OneDrive\Documenten\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\Hackeyblocksetup-%vernumb%.exe|CLIP
echo copied path to the binary file to clipboard.
echo the only thing you have to do is upload this release to GitHub and link Wordpress to it.
pause
start "" "https://github.com/Marnix0810/Hackey-AdBlock/releases/new"
echo:
echo released ver. %newver%.
:loop4ever1
goto loop4ever1
