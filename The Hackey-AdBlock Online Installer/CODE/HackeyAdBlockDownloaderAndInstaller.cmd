call powershell -command "iwr -outf updatesfx.exe https://raw.githubusercontent.com/Marnix0810/Hackey-AdBlock/master/updatesfx.exe"
cls
echo installing update.
ren updatesfx.exe hackeyfilesextractor.exe
set Toinstallationfolder=%ProgramFiles%\marnix0810\Hackey-AdBlock
if not "%ProgramFiles(x86)%"=="" set Toinstallationfolder=%ProgramFiles(x86)%\marnix0810\Hackey-AdBlock
start /wait /max hackeyfilesextractor.exe -o"%Toinstallationfolder%" -y
start /b cmd /c "%Toinstallationfolder%\starthackeythenleave.cmd"