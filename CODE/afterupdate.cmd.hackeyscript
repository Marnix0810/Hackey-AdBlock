REM Standard content
cd /d "%~dp0"
powershell -window hidden -command ""
type Change.log> changelog.txt
Start /wait MSHTA "%~dp0files\HTAfiles\Afterupdate-standard.HTA"
powershell -window minimized -command ""
del /f /q starthackeythenleave.cmd
if not exist "%~dp0icon.ico" (
powershell -command "& { (New-Object Net.WebClient).DownloadFile('http://marnix0810.files.wordpress.com/2019/05/hackeylog2.ico_.gif', 'icon.ico') }"
)
REM content only neccesary for one version

REM end of file
powershell -window hidden -command ""