# AutoSSL: Setting SSL for Windows Server Easier

## Purpose
The main purpose of this project is to help myself (and other developers) to relieve hassles when setting SSL for local web server.\
Inspired by <a href="https://www.ophiuchi.dev/">Ophiuchi</a>, a project setting up SSL environment for local machine, I think Windows Server also deserve a handy tool to do so.

## How to use
1. Download this project.
2. Edit `setup.conf`.
3. Run `main.ps1` <b>As Administrator</b>.

## Program Explained
### Pre-requisite software installation
> This step is optional if openssl is installed before.
1. Run `installOpenSSL.bat`. This will set the OpenSSL tool for certificate creation if it is not installed.
### Setting up for SSL/TLS
2. Run `.\genCert.ps1 <domain> <mode>`. This would create an interactive command prompt for generating certificate.<br>
The default location to store certificate would be "C:\\." Change by adding desired folder path at the end of command.<br>
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
3. Run `updateHostTable.bat <hostname>`. This program adds the record to local host table, so browsers should recognize and link the hostname to `localhost`.
4. Use your favourite webserver service and start serving HTTPS!

## Future update
- [x] ~~*Maybe I will include the support of `.properties` or `.conf`*~~ [2025-04-10]
- [ ] Logging and logging.properties

## Acknowledgement
- https://www.ophiuchi.dev/
- https://eternallybored.org/misc/wget/
- https://slproweb.com/
