@echo off
SET OUT=2F

SET ENVIADOS=0
SET RECIBIDOS=0
SET PERDIDOS=0
 
color %OUT%
mode 64,10
echo mode 64,10
echo off & cls
Title = Ping monitor
IF %1.==. GOTO USAGE
set IP=%1

:top
set mytime=%time:~0,2%_%time:~3,2%_%time:~6,2%
set mydate=%date%
SET /A ENVIADOS = %ENVIADOS% + 1
PING  -n 1 %IP% | FIND "TTL=" >nul
IF ERRORLEVEL 1 (GOTO PINGKO) ELSE (GOTO PINGOK)
ping -n 2 -l 10 127.0.0.1 >nul
IF %2.==. (GOTO TOP) ELSE (IP=%2)
GoTo top

:PINGOK
IF (%PERDIDOS% EQU 0) (SET OUT=2F) ELSE (SET OUT=5F)

COLOR %OUT%
SET /a RECIBIDOS=%RECIBIDOS%+1
echo %time:~0,2%:%time:~3,2%:%time:~6,2%,%time:~9,2%% : ENV:%ENVIADOS% REC:%RECIBIDOS% PER:%PERDIDOS% IP:%IP% - UP
GOTO TOP

:PINGKO
SET OUT=4F
COLOR %OUT%

SET /A PERDIDOS=%PERDIDOS%+1
echo %time:~0,2%:%time:~3,2%:%time:~6,2%,%time:~9,2%% : ENV:%ENVIADOS% REC:%RECIBIDOS% PER:%PERDIDOS% IP:%IP% - DOWN
Title Up %IP%
GOTO TOP

:USAGE
echo "miping <IP DESTINO 1> <IP DESTINO 2> ... <IP DESTINO n>"