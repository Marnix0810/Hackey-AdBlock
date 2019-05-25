@echo off
cd /d "%~dp0"
set admin=1
set /p "callcommand="<"%~dp0callcommand.inf"
start cmd /c %callcommand%
type NUL>"%~s0"
