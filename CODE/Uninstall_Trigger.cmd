md "%tmp%\Hackey"
xcopy uninstall.bat "%tmp%\Hackey\" /y
call "%tmp%\Hackey\uninstall.bat" "%~dp0"
