@echo off
set hostname=%1

setlocal
set "HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts"
set "command=127.0.0.1 %hostname%"
ECHO %command%>>%HOSTS_FILE%
endlocal