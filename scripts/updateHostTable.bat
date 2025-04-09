@echo off
set IP=%1
set hostname=%2

setlocal
set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"
set "command=%IP% %hostname%"
ECHO %command%>>%HOSTS_FILE%
endlocal