# Setup WSL Environment for Anyconnect

## Updates/News

09-01-2023
* Initial Release

## Instructions

The `generate_settings.sh` file in this repository will setup a WSL Environment for Users that utilize Anyconnect VPN.  Once the environment is setup, you can use `fwdns.sh` to correct `resolv.conf` each time you connect and disconnect from your VPN Network.

### Clone this Repo

```bash
git clone https://github.com/scotttyso/wsl-dns-fix
```

### Make the File Executable

```bash
cd wsl-dns-fix
chmod 755 generate_settings.sh
./generate_settings.sh
```

### Everyday Usage

Once the Script has configured the Environment you can execute the script each time you connect and disconnect from VPN.

```bash
fwdns.sh
```

## Credit to Christian Fersch for his wsl-sudo project

### [WSL Sudo](https://github.com/Chronial/wsl-sudo)