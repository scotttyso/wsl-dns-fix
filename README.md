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

If you don't have Administrative access in Windows you can request your IT organization to deploy the script as an `OnConnect` script when AnyConnect is connected.

### [Write and Deploy Scripts](https://www.cisco.com/c/en/us/td/docs/security/vpn_client/anyconnect/anyconnect48/administration/guide/b_AnyConnect_Administrator_Guide_4-8/customize-localize-anyconnect.html#ID-1408-00000396)

You will still want to know the location of the script if `Anyconnect` doesn't auto start, and you have the ability to connect and disconnect.  You don't need Administrative access to execute the powershell script when `Anyconnect` is disconnected, as the powershell script only pulls the DNS settings from the other connections, then creates the `resolv.conf` file under the `C:\Users\Public` directory.  `sudo` permissions in WSL is always required.

## Sources that Helped

### [WSL Sudo](https://github.com/Chronial/wsl-sudo)

### [fix-wsl2-dns-resolution](https://gist.github.com/coltenkrauter/608cfe02319ce60facd76373249b8ca6)

### And as always multiple Stack overflow Questions and Answers