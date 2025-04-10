@echo off
setlocal enabledelayedexpansion
REM This script installs OpenSSL and sets the environment variable for it
REM We will check if OpenSSL is already installed
powershell.exe -File CheckOpenSSL.ps1
if %ERRORLEVEL% equ 0 (
    echo OpenSSL is installed.
    exit /b 0
) else (
    echo OpenSSL is not installed.
    REM Get the installer by wget/curl and install by msiexec
    REM Remove installer after installation
    if not exist OpenSSL.msi (
        curl https://slproweb.com/download/Win64OpenSSL-3_4_1.msi -o OpenSSL.msi
    )
    msiexec /i OpenSSL.msi /quiet /norestart
    del OpenSSL.msi

    REM The installation path would be the default path for OpenSSL
    set "OPENSSL_PATH=C:\Program Files\OpenSSL-Win64\bin"
    REM set the environment variable for OpenSSL
    setx /m PATH "%PATH%;%OPENSSL_PATH%"

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
)
