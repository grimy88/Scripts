@ECHO OFF

IF NOT "%1%"=="" GOTO ma


ECHO ******************* Set System Date************************

ECHO 1  10.06.2015 / August
ECHO 2  10.07.2015 / Juli
ECHO 3  10.09.2015 / September
ECHO 4  not configured
ECHO 0  EXIT no change


set /P el=CHOOSE: 
goto set_date


:ma
set el=%1%


:set_date

if /I "%el%"=="0" GOTO Exit
if /I "%el%"=="1" DATE 10-06-15
if /I "%el%"=="2" DATE 10-07-15
if /I "%el%"=="3" DATE 10-09-15
if /I "%el%"=="4" ECHO not configured