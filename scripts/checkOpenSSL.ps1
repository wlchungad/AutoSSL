# Define common installation directories
$commonPaths = @(
    "C:\Program Files\OpenSSL-Win64\bin\openssl.exe",
    "C:\Program Files (x86)\OpenSSL-Win32\bin\openssl.exe",
    "C:\OpenSSL-Win64\bin\openssl.exe",
    "C:\OpenSSL-Win32\bin\openssl.exe"
)

# Check common installation directories
$opensslInstalled = $false
foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        $opensslInstalled = $true
        Write-Output "OpenSSL is installed at: $path"
        break
    }
}

# Check PATH environment variable
if (-not $opensslInstalled) {
    $pathEnv = [System.Environment]::GetEnvironmentVariable("PATH")
    $paths = $pathEnv -split ";"
    foreach ($path in $paths) {
        if ($path -and (Test-Path (Join-Path $path "openssl.exe"))) {
            $opensslInstalled = $true
            Write-Output "OpenSSL is installed in PATH at: $path"
            #break
            exit 0
        }
    }
}

# Output result
if (-not $opensslInstalled) {
    Write-Output "OpenSSL is not installed on this computer."
    exit 1
}