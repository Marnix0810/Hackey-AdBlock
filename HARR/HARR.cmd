@echo off
title Hackey Admin Rights Request
set /p "prcesr="<"HARR-prcesr.HARRset"
goto errorcheck
:main
(
echo @echo off
echo set Adminrequested=1
echo start cmd /c "%~1"
echo DEl /f /q "%%~s0"
echo Type nul ^> "%%~s0"
)>adminrequestprocessing.cmd
start "" "%~dp0%prcesr%"
echo on
@exit
:errorcheck
if "%~1"=="" (
echo ERROR CODE 1 -- No file to run.
echo:
echo see 'How to call' for more info.
goto nope
)
if not exist "%~dp0%prcesr%" (
echo CRITICAL ERROR CODE 2 -- the file defined in HARR-prcesr.HARRset does not exist.
echo:
echo see 'How to use in other projects?' for more info.
goto nope
)
if /I "%~1"=="-h" goto read
if /I "%~1"=="-help" goto read
if /I "%~1"=="-r" goto read
if /I "%~1"=="-read" goto read
if "%~1"=="/?" goto read
goto main
:nope
echo no admin rights requistred, there was an error.
echo ----------------------------------------------------------
type HARR-Readme.txt
echo on
@exit /b
:read
echo ----------------------------------------------------------
type HARR-Readme.txt
echo on