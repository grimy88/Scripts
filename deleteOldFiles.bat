@ECHO OFF
SETLOCAL EnableDelayedExpansion
title Delete Old Files
color 0a

GOTO :location


:location
ECHO Type the location to search for old files: [Example D:\destination\folder]
set /P mypath=
GOTO :checkLocation


:checkLocation
if %mypath% == "" (
	GOTO :location
)
GOTO :insertDays


:insertDays
ECHO Type in the number of days how old the searched files should be:
set /P days=
GOTO :checkDays


:checkDays
if %days%=="" ( 
	GOTO :insertDays 
)
GOTO :deleteFiles


:deleteFiles
cd %mypath%
FORFILES /d -%days% /p %mypath% /m *.* /s /c "cmd /c echo @fname is older than %days% and is deleted & echo. & del @file"
ECHO.
ECHO Thank you for using Grimy scripts :-)
ECHO.
pause
exit