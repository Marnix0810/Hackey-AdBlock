md "%tmp%\hackey"
xcopy uninstall.bat "%tmp%\hackey\" /y
call "%tmp%\hackey\uninstall.bat" "%~dp0"
