# AutoSSL: Setting SSL for Windows Server Easier

## Purpose
The main purpose of this project is to help myself (and other developers) to relieve hassles when setting SSL for local web server.\
Inspired by <a href="https://www.ophiuchi.dev/">Ophiuchi</a>, a project  setting up SSL environment for local machine, I think Windows Server also deserve a handy tool to do so.

## How to use
1. Install <a href="https://eternallybored.org/misc/wget/">wget for Windows</a>.
2. Run `installOpenSSL.bat`. This will set the OpenSSL tool for certificate creation.
3. Run `genCert.ps1 <domain> <mode> <position>`. This would create an interactive command prompt for generating certificate.<br>
For basic mode, just type hostname, and it generates certificate.<table><tr><th>Country (C)</th><th>State (ST)</th><th>City Name (L)</th><th>Organization (O)</th><th>Organization Unit(OU)</th></tr><tr><td>US</td><td>Denial</td><td>Springfield</td><td>Dis</td><td>Dis</td></tr></table><br>For advanced mode, the program prompts for information as usual 
4. Run `updateHostTable.bat <IP> <hostname>`. This program add the record to local host table.
5. Use your favourite webserver service and start serving HTTPS!

## Future update
- Maybe I will include the support of `.properties` or `.conf`.

## Acknowledgement
- https://www.ophiuchi.dev/
- https://eternallybored.org/misc/wget/
- https://slproweb.com/
