@echo off
echo -------------------------------------------------- >> "%~dpn0-logger.log"
echo %~s0 started on: date:%date% time:%time% >> "%~dpn0-logger.log"
echo: >> "%~dpn0-logger.log"
REM 7z.exe: "C:\Program Files\7-Zip\7z.exe"
REM RAR.EXE: "C:\Program Files\WinRAR\rar.exe"
cd /d "%~dp0"


set /p "numb1="<"%~dp0datefiles\%date%.txt"
set /a numb1+=1
echo:%numb1%>"%~dp0datefiles\%date%.txt"
set /a vernumb=%numb1%
type "%~dp0SETUP-CONTENTS\hackey-adlist.txt">"%~dp0addomainlist.txt"
type addomainlist.txt | findstr /v # | findstr /v \/ | findstr /v = > addomainlist.txt.new
move /y addomainlist.txt.new addomainlist.txt >nul
xcopy "%~dp0\Assets\jsort.bat" "%~dp0"
call jsort.bat addomainlist.txt /u >addomainlist.txt.new
del /f /q "%~dp0jsort.bat"
move /y addomainlist.txt.new hackey-adlist.txt >nul
move hackey-adlist.txt "%~dp0SETUP-CONTENTS\" >nul
del /f /q "%~dp0addomainlist.txt"
cls
rem type "%~dp0SETUP-CONTENTS\hackey-adlist.txt"
<NUL set /p =old version: 
set /p "oldversion="<"%~dp0SETUP-CONTENTS\hackey-install-version.txt"
echo:%oldversion%
REM echo old version copied to clipboard.
REM <NUL set /p =%oldversion: =%|CLIP
REM set /p "newversion=new version: "
set newversion=%vernumb%/%date% %time%
( 
<NUL set /p =%newversion%
)>"%~dp0SETUP-CONTENTS\hackey-install-version.txt"
cd /d "%~dp0\SETUP-CONTENTS\"
(
echo:
echo:
echo ---------------------------------------------------------------------
echo changelog for version %newversion%:
echo changelog for version %newversion%: ^(typecon^) >CON 
) >> "%~dp0\SETUP-CONTENTS\change.log"
if "%updatedmdm%"=="1" (
echo - synced malware domain list from http://www.malwaredomainlist.com/hostslist/hosts.txt >> "%~dp0\SETUP-CONTENTS\change.log"
echo - synced malware domain list from http://www.malwaredomainlist.com/hostslist/hosts.txt
)
TYPE CON >> "%~dp0\SETUP-CONTENTS\change.log"
(
type "%~dp0SETUP-config\SETUP\XFS.CONF.1part"
echo ^<br^>Hackey version: ^<br^>
type "%~dp0SETUP-CONTENTS\hackey-install-version.txt"
echo ^<I^>for more info, see the after-update/install screen.^</I^>
type "%~dp0SETUP-config\SETUP\XFS.CONF.2part"
) > "%~dp0SETUP-config\SETUP\XFS.CONF"
(
ECHO Update created on: %date%
echo update created from computer: %computername%
echo this app was made by marnix 0810, visit https://marnix0810.wordpress.com for more information.
echo notes about this update:
echo notes about this update: ^(typecon^) >CON
TYPE CON
) > "%~dp0Hackeyblocksetup-%date%_%vernumb%.info.log"
echo building executables...
( 
<NUL set /p =%newversion%
)>"%~dp0SETUP-CONTENTS\hackey-install-version.txt"
type "%~dp0SETUP-CONTENTS\hackey-install-version.txt" > "C:\Users\marni\GitHub\Hackey-AdBlock\latest-release.txt"
cd /d "%~dp0SETUP-CONTENTS\"
call "C:\Program Files\7-Zip\7z.exe" a -r -sfx7z.sfx -mx1 "%~dp0SETUP\hackeyfilesextractor.exe" *
set verd=%vernumb%.0.0.0
"%~dp0bin\Bat_To_Exe_Converter\Bat_To_Exe_Converter_(x64).exe" /bat "%~dp0\SETUP\installationextraction.cmd" /exe "%~dp0Hackeyblocksetup-%date%_%vernumb%.exe" /icon "%~dp0logos\hackeylogo.ico" /overwrite /include "%~dp0SETUP\hackeyfilesextractor.exe" /workdir 1 /extractdir 1 /uac-admin /company "marnix0810.wordpress.com" /trademarks "By Marnix 0810" /copyright "By Marnix 0810" /productname "Hackey-AdBlock" /productversion "%verd%" /display /description "Hackey AdBlock's installer by Marnix 0810" /comments "Official Hackey AdBlock installer by Marnix0810" /privatebuild "%verd%" /specialbuild "%verd%" 
call "C:\Program Files\7-Zip\7z.exe" a "%~dp0Hackeyblock-windows.7z" "%~dp0Hackeyblocksetup-%date%_%vernumb%.exe" -mx9
call "C:\Program Files\7-Zip\7z.exe" a "%~dp0Hackeyblock-windows.7z" "%~dp0\SETUP-CONTENTS\change.log" -mx9
call "C:\Program Files\7-Zip\7z.exe" a "%~dp0Hackeyblock-windows.7z" "%~dp0Hackeyblocksetup-%date%_%vernumb%.info.log" -mx9
call "C:\Program Files\7-Zip\7z.exe" a "%~dp0WindowsSetupsArchive.7z" "%~dp0Hackeyblocksetup-%date%_%vernumb%.exe" -mx9
call "C:\Program Files\7-Zip\7z.exe" a "%~dp0WindowsSetupsArchive.7z" "%~dp0Hackeyblocksetup-%date%_%vernumb%.info.log" -sdel -mx5
type "%~dp0\SETUP-CONTENTS\change.log">"%userprofile%\GitHub\Hackey-AdBlock\CHANGELOG.MD"
xcopy /y "%~dp0Hackeyblock-windows.7z" "%userprofile%\GitHub\Hackey-AdBlock\Hackeyblock_windows-latest.7z"
xcopy /y "%~dp0Hackeyblocksetup-%date%_%vernumb%.exe" "%userprofile%\GitHub\Hackey-AdBlock\Setups\*"
del /f /q "%~dp0SETUP\updatesfx.exe"
ren "%~dp0SETUP\hackeyfilesextractor.exe" updatesfx.exe
move /y "%~dp0SETUP\updatesfx.exe" "%userprofile%\GitHub\Hackey-AdBlock\"
set /a rand=%random%-1
ren "%~dp0Hackeyblock-windows.7z" %rand%-test-hackey.7z
REM start "C:\Program Files\7-Zip\7zFM.exe" "%~dp0%rand%-test-hackey.7z"
REM pause
del /f /q "%~dp0\%rand%-test-hackey.7z"
del /f /q "%~dp0SETUP-config\SETUP\XFS.CONF"
<NUL set /p =update released for version: 
type "%~dp0SETUP-CONTENTS\hackey-install-version.txt"
<NUL set /p "=. "
pause
del /f /q "%~dp0Hackeyblocksetup-%date%_%vernumb%.exe"
exit


