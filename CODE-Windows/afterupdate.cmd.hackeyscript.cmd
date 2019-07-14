REM Standard content
cd /d "%~dp0"
powershell -window hidden -command ""
Start /wait MSHTA "%~dp0HTA\Afterupdate-standard.HTA"
powershell -window minimized -command ""
del /f /q startHackeythenleave.cmd
if not exist "%~dp0icon.ico" (
powershell -command "& { (New-Object Net.WebClient).DownloadFile('http://marnix0810.files.wordpress.com/2019/05/Hackeylog2.ico_.gif', 'icon.ico') }"
)

REM content only neccesary for one version

del /f /q "%appdata%\Microsoft\Windows\Start Menu\Programs\HackeyBlock by Marnix 0810\*"
rmdir "%appdata%\Microsoft\Windows\Start Menu\Programs\HackeyBlock by Marnix 0810\"

REM end of file
powershell -window hidden -command ""