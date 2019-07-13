REM Standard content
cd /d "%~dp0"
powershell -window hidden -command ""
type Change.log> changelog.txt
Start /wait MSHTA "%~dp0HTA\Afterupdate-standard.HTA"
powershell -window minimized -command ""
del /f /q startHackeythenleave.cmd
if not exist "%~dp0icon.ico" (
powershell -command "& { (New-Object Net.WebClient).DownloadFile('http://marnix0810.files.wordpress.com/2019/05/Hackeylog2.ico_.gif', 'icon.ico') }"
)
:Extractpython
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
  )
if "%_os_bitness%"=="32" start "" "%~dp0assets-sfx.7z.exe" -o"%~dp0" -y
if "%_os_bitness%"=="64" start "" "%~dp0assets64-sfx.7z.exe" -o"%~dp0" -y

REM content only neccesary for one version

REM end of file
powershell -window hidden -command ""