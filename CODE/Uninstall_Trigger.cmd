if exist "%~dp0unins000.exe" (
start "" "%~dp0unins000.exe"
exit
)
md "%tmp%\Hackey"
xcopy uninstall.bat "%tmp%\Hackey\" /y
call "%tmp%\Hackey\uninstall.bat" "%~dp0"
