::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcAmDLmWzOqYI6evw086IoVgQUewrfYHn6qaBJ/IS50jlZYQi3H9ZjM4CME8WPiG/bw04rCNDtXCMIcKgmw7iQU2Q5Ec/GG5ItEbkuRsHaNJrkcYa1Smy+V76h7EC0HvrUbtAEHvkoQ==
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBZVXgqLAHiuB7YX1Mz07P+Kp0MJUewDSJ3U3aaPLe0S+lfrf5Muwn9UpJ9CTChMfxCna0I1qnpLoGG5H8afuAr4SESG5UAMF2pziHDshCo4a9ZxlswE3G63/0Kf
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQIxJAtcTWQ=
::ZQ05rAF9IBncCkqN+0xwdVtVQBSKPQs=
::ZQ05rAF9IAHYFVzEqQIYKRhfSR3CHW+YCrof44g=
::eg0/rx1wNQPfEVWB+kM9LVsJDCWOLGO7D7sP/On34++V7EgFUYI=
::fBEirQZwNQPfEVWB+kM9LVsJDCyDP2C/H/gV5vvv7uaLp199
::cRolqwZ3JBvQF1fEqQIYKRhfSR3CHW+YCrof46jy4fmTo0ERVfY2d4GbyqaBJ/IS5wXmbNYA12hUkdNcVEoIHg==
::dhA7uBVwLU+EWFSF5kw5MEsMHVTMK2SoAqUO7fvooemIry0=
::YQ03rBFzNR3SWATE1ltwBRpGQg2afDviV+V8
::dhAmsQZ3MwfNWATE1ltwBRpGQg2afDviV+V8
::ZQ0/vhVqMQ3MEVWAtB9wKRdERAXi
::Zg8zqx1/OA3MEVWAtB9wKRdERAXi
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFBZVXgqLAHiuB7YX1Mz07P+Kp0MJUewDSJ3U3aaPLe0S+lfrf5Muwn9UpJ9CTChMfxCna0I1qnpLoGG5H8afuAr4SESG5UAMOmlkj2LZgjgvYd9kn9FN1ji7nA==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
set Toinstallationfolder=%ProgramFiles%\marnix0810\Hackey-AdBlock
if not "%ProgramFiles(x86)%"=="" set Toinstallationfolder=%ProgramFiles(x86)%\marnix0810\Hackey-AdBlock
start /wait /max hackeyfilesextractor.exe -o"%Toinstallationfolder%" -y
start /b cmd /c "%Toinstallationfolder%\starthackeythenleave.cmd"