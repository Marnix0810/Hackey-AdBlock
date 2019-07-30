REM Standard content
cd /d "%~dp0"
powershell -window hidden -command ""
Start /wait MSHTA "%~dp0HTA\Afterupdate-standard.HTA"
powershell -window minimized -command ""
del /f /q startHackeythenleave.cmd


REM content only neccesary for one version


REM end of file
powershell -window hidden -command ""
