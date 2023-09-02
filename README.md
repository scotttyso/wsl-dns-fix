# Anyconnect Network Modification for WSL

## Updates/News

09-01-2023
* Initial Release

## Instructions

The purpose of this repository is to simplify the instructions into a simple `powershell` and `shell` script fix for users.  The other examples from GitHub below give instructions but not a quick `shell` script.  Also the `anyconnect.ps1` is more complex than other examples to account for `connected/disconnected` states for the corporate environment.

The `generate_settings.sh` file in this repository will setup a WSL Environment for Users that utilize Anyconnect VPN.  Once the environment is setup, you can use `wdf.sh` to correct `resolv.conf` each time you connect and disconnect from your VPN Network.

### Clone this Repo

```bash
git clone https://github.com/scotttyso/wsl-dns-fix
```

### Modify the Search Values in anyconnect.ps1

In the Last line line of `anyconnect.ps1` are the DNS search values I used.  Modify this line to match your own search domain if desired, or leave it commented out.

```powershell
#Add-Content -Path C:\Users\Public\resolv.conf -Value "search rich.ciscolabs.com cisco.com"
```

It isn't required, but is helpful if you like to use short names like I do.

### Execute the Setup Shell Script

```bash
cd wsl-dns-fix
chmod 755 generate_settings.sh
sudo ./generate_settings.sh
```

### Everyday Usage

Once the Script has configured the Environment you can execute the script each time you connect and disconnect from VPN.

```bash
wdf.sh
```

You can add this to cron and have it auto run on startup, or at given intervals, if you want but I find that since I connect and disconnect based on things I am doing, it is just more convient to execute the script when I need to.

If you run the script as sudo, the following error occurs:

```bash
tcgetpgrp failed: Not a tty
```

It still works, but to eliminate the error I chose to have `wdf.sh` run as a regular user and prompt for sudo credentials for the `resolv.conf` modifications.  

**Trivia:** The name of the script stands for WSL DNS fix, and was chosen for auto-complete/tab to be as simple as possible.

**Note:** You will recieve a User Account Control (UAC) prompt for the Administrative session created to modify the `AnyConnect` Network Interface Each time.  Both Windows `Administrative` access + `sudo` access in WSL are required to perform these fixes.

If you don't have `Administrative` access in Windows, you can request your IT organization to deploy the `anyconnect.ps1` script as an `OnConnect` script when AnyConnect is connected.

[**AnyConnect - Write and Deploy Scripts**](https://www.cisco.com/c/en/us/td/docs/security/vpn_client/anyconnect/anyconnect48/administration/guide/b_AnyConnect_Administrator_Guide_4-8/customize-localize-anyconnect.html#ID-1408-00000396)

You will still want to know the location of the script if `Anyconnect` doesn't auto start and you have the ability to connect and disconnect from your corporate environment.  You don't need Administrative access to execute the powershell script when `Anyconnect` is disconnected, as the powershell script only pulls the DNS settings from the other connections and creates the `resolv.conf` file under the `C:\Users\Public` directory.  `sudo` permissions for the `wdf.sh` script in WSL is always required.

## Sources that Helped

[**WSL Sudo**](https://github.com/Chronial/wsl-sudo)

[**fix-wsl2-dns-resolution**](https://gist.github.com/coltenkrauter/608cfe02319ce60facd76373249b8ca6)

**And as always multiple Stack overflow Questions and Answers**