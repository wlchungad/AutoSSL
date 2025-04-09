# AutoSSL: Setting SSL for Windows Server Easier

## Purpose
The main purpose of this project is to help myself (and other developers) to relieve hassles when setting SSL for local web server.\
Inspired by <a href="https://www.ophiuchi.dev/">Ophiuchi</a>, a project setting up SSL environment for local machine, I think Windows Server also deserve a handy tool to do so.

## How to use
### Pre-requisite software installation
> Note that step 1 and 2 are optional if wget and openssl are installed before.
1. Install <a href="https://eternallybored.org/misc/wget/">wget for Windows</a>.
2. Run `installOpenSSL.bat`. This will set the OpenSSL tool for certificate creation.
### Setting up for SSL/TLS
3. Run `genCert.ps1 <domain> <mode> <position>`. This would create an interactive command prompt for generating certificate.<br>
The default location to store certificate would be "C:\\.".<br>
For basic mode, just type hostname, and it generates certificate with dummy information.
    <table>
        <tr>
            <th>Country (C)</th>
            <th>State (ST)</th>
            <th>City Name (L)</th>
            <th>Organization (O)</th>
            <th>Organization Unit(OU)</th>
        </tr>
        <tr>
            <td>US</td>
            <td>Denial</td>
            <td>Springfield</td>
            <td>Dis</td>
            <td>Dis</td>
        </tr>
    </table>
    For advanced mode, the program prompts for information as usual.
4. Run `updateHostTable.bat <IP> <hostname>`. This program adds the record to local host table, so browsers should recognize the hostname to `localhost`.
5. Use your favourite webserver service and start serving HTTPS!

## Future update
- Maybe I will include the support of `.properties` or `.conf`.

## Acknowledgement
- https://www.ophiuchi.dev/
- https://eternallybored.org/misc/wget/
- https://slproweb.com/
