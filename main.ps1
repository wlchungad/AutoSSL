$ConfigFile = ".\setup.conf"

# Read the file content
$ConfigContent = Get-Content $ConfigFile -Raw  # Read as a single string

# Convert the string data to a hashtable
try {
    $Config = ConvertFrom-StringData $ConfigContent
} catch {
    Write-Error "Error parsing configuration file: $($_.Exception.Message)"
    exit
}

# hostname, genCertMode, CertStoreDir, CERT_Country, CERT_State, CERT_City, CERT_Organization, CERT_OrganizationUnit

# step 1: check OpenSSL installation and install if not
cmd.exe /c ".\scripts\installOpenSSL.bat"

# step 2: generate certificate
.\scripts\genCert.ps1 -DomainName $($Config['hostname']) -GenCertMode $($Config['genCertMode']) -GenCertPath $($Config['CertStoreDir'])

# step 3: update hosts table
cmd.exe /c ".\scripts\update.bat $($Config['hostname'])"