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

### Execute the Setup Shell Script

```bash
cd wsl-dns-fix
chmod 755 generate_settings.sh
sudo ./generate_settings.sh
```

### Everyday Usage

Once the Script has configured the Environment you can execute the script each time you connect and disconnect from VPN.

```bash
fwdns.sh
```

If you run the script as sudo, the following error occurs:

```bash
tcgetpgrp failed: Not a tty
```

It still works, but to eliminate the error I changed the script to have it run as a regular user and prompt for sudo credentials for the `resolv.conf` modifications.

Note: You will recieve a UAP prompt for the Administrative session created to modify the `AnyConnect` Network Interface Each time.  And both Windows Administrative access + sudo access in WSL is required to perform these fixes.

## Sources that Helped

### [WSL Sudo](https://github.com/Chronial/wsl-sudo)

### [fix-wsl2-dns-resolution](https://gist.github.com/coltenkrauter/608cfe02319ce60facd76373249b8ca6)

### And as always multiple Stack overflow Questions and Answers