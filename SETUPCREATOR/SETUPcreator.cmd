@echo off

REM Get version number
set /p "numb2="<"%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb2.txt"
set /a numb2+=1
echo:%numb2%>"%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb2.txt"
set /p "numb1="<"%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\numb1.txt"
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
echo No messages. > "%~dp0..\versionmessages\%vernumb%.txt"

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
xcopy "%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\filesnotincludedingithub\*.*" "%~dp0..\CODE\"
cd /d "%~dp0..\CODE"

REM create setup.
call "%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Assets\Winrar\WinRAR.exe" a SETUPnew.exe * -r -sfx -ilog -iimg"%~dp0logos\hackeylogo.bmp" -z"%~dp0files-for-setup\xfs.conf"
move SETUPnew.exe "%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\SETUPnew.exe"
ren "%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\SETUPnew.exe" Hackeyblocksetup-%vernumb%.exe
del /f /q "%~dp0..\CODE\change.log"
del /f /q "%~dp0..\CODE\hackey-install-version.txt"
cd /d "%~dp0"
for /f "delims=" %%i in (filesnotincludedingithub.txt) do (del /f /q "%~dp0..\CODE\%%i")
pause

@echo off
cls
echo:%userprofile%\MEGA\Documents\Programmeren\Programmaprojecten\4. Stable-active\The Hackey-AdBlock project\Setups\Hackeyblocksetup-%vernumb%.exe|CLIP
echo copied path to the binary file to clipboard.
echo the only thing you have to do is upload this release to GitHub and link Wordpress to it.
pause
start "" "https://github.com/Marnix0810/Hackey-AdBlock/releases/new"
cls
echo enter direct download link to the setup file.
set /p updurl=Url: 
echo:%updurl%>"%~dp0..\updurl.txt"
cls
echo:
echo released ver. %newver%.
:loop4ever1
goto loop4ever1
