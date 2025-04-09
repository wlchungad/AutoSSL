param(
    [Parameter(Mandatory, HelpMessage="Enter the domain")][string]$DomainName,
    [Parameter(Mandatory, HelpMessage="Mode: basic/advanced")][string]$GenCertMode,
    [Parameter()]$GenCertPath='C:\'
)
Write-Host "Hostname: $DomainName"
Write-Host "Generation Mode: $GenCertMode"
Write-Host "Certificate is generated in: $GenCertPath"

# A RSA 2048 key is generated for the certificate
# cmd.exe /c "openssl genrsa -out $DomainName.pem 2048"
# Extract the public key:
# cmd.exe /c "openssl rsa -in key.pem -outform PEM -pubout -out public.pem"

# one-liner command:
if ($GenCertMode -eq 'basic') {
    cmd.exe /c "openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
    -keyout $DomainName.private.key -out $DomainName.cer \
    -subj '/C=US/ST=Denial/L=Springfield/O=Dis/OU=Dis/CN=$DomainName'"
} elseif ($GenCertMode -eq 'advanced'){
    Write-Host "Please enter the following details for the certificate:"
    $Country = Read-Host "Enter Country (C)"
    $StateName = Read-Host "Enter State (ST)"
    $Locality = Read-Host "Enter Locality / City Name (L)"
    $Organization = Read-Host "Enter Company Name (O)"
    $OrganizationUnit = Read-Host "Enter Company Section Name(OU)"
    cmd.exe /c "openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
    -keyout $DomainName.private.key -out $DomainName.cer \
    -subj '/C=$Country/ST=$StateName/L=$Locality/O=$Organization/OU=$OrganizationUnit/CN=$DomainName'"
}
# verify the certificate
cmd.exe /c "openssl x509 -in $DomainName.cer -noout -text"
Read-Host -Prompt "Press Enter to continue"

# trust the certificates
$params = @{
    FilePath = ".\$DomainName.cer"
    CertStoreLocation = 'Cert:\LocalMachine\Root'
}
Import-Certificate @params

# move the files to target directory
Move-Item -Path ".\$DomainName.cer" -Destination "$GenCertPath\$DomainName.cer"
Move-Item -Path ".\$DomainName.private.key" -Destination "$GenCertPath\$DomainName.private.key"

