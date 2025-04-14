param(
    [Parameter(Mandatory, HelpMessage="Enter the domain")][string]$DomainName,
    [Parameter(Mandatory, HelpMessage="Select the generation mode: basic/advanced")][string]$GenCertMode='basic',
    [Parameter(Mandatory, HelpMessage="Generation Path(default C:\)")]$GenCertPath='C:\'
)
Write-Host "Hostname: $DomainName"
Write-Host "Generation Mode: $GenCertMode"
Write-Host "Certificate is generated in: $GenCertPath"

# one-liner command:
if ($GenCertMode -eq 'basic') {
    $cmd = "openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -keyout $DomainName.private.key -out $DomainName.cer -subj /C=US/ST=Denial/L=Springfield/O=Dis/OU=Dis/CN=$DomainName"
} elseif ($GenCertMode -eq 'advanced'){
    $ConfigFile = "..\setup.conf"
    # $ConfigContent =   # Read as a single string
    try {
        $Config = ConvertFrom-StringData (Get-Content $ConfigFile -Raw)
    } catch {
        Write-Error "Error parsing configuration file: $($_.Exception.Message)"
        exit 1
    }

    $Country = $($Config['CERT_Country'])
    $StateName = $($Config['CERT_State'])
    $Locality = $($Config['CERT_City'])
    $Organization = $($Config['CERT_Organization'])
    $OrganizationUnit = $($Config['CERT_OrganizationUnit'])
    $cmd = "openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 -keyout $DomainName.private.key -out $DomainName.cer -subj /C=$Country/ST=$StateName/L=$Locality/O=$Organization/OU=$OrganizationUnit/CN=$DomainName"
}
cmd.exe /c $cmd

# verify the certificate
Write-Host "Please check the certificate details:"
$cmd = "openssl x509 -in $DomainName.cer -noout -text"
cmd.exe /c $cmd
Read-Host -Prompt "Press Enter to continue"

# trust the certificates (as server, not root)
$params = @{
    FilePath = ".\$DomainName.cer"
    CertStoreLocation = 'Cert:\LocalMachine\Root'
}
Import-Certificate @params
Read-Host -Prompt "Press Enter to continue"

# move the files to target directory
Move-Item -Path ".\$DomainName.cer" -Destination "$GenCertPath\$DomainName.cer"
Move-Item -Path ".\$DomainName.private.key" -Destination "$GenCertPath\$DomainName.private.key"

Read-Host -Prompt "Press Enter to continue"