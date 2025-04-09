@echo off
setlocal enabledelayedexpansion
REM This script installs OpenSSL and sets the environment variable for it
REM Get the installer by wget/curl and install by msiexec
REM Remove installer after installation
if not exist ".\OpenSSL.msi" "curl https://slproweb.com/download/Win64OpenSSL-3_4_1.msi -O OpenSSL.msi"
msiexec /i OpenSSL.msi /quiet /norestart
del OpenSSL.msi

REM The installation path would be the default path for OpenSSL
set "OPENSSL_PATH=C:\Program Files\OpenSSL-Win64\bin"
REM set the environment variable for OpenSSL
setx PATH=%PATH%;%OPENSSL_PATH% /m

REM Test if OpenSSL is already installed
openssl version 2>&1
pause
if %errorlevel% equ 0 (
    echo OpenSSL is installed successfully.
    endlocal
    exit /b 0
)
else (
    echo OpenSSL installation failed.
    endlocal
    exit /b 1
)