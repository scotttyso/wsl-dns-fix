#!/bin/sh
apt-get install dos2unix -y
wget https://raw.githubusercontent.com/Chronial/wsl-sudo/master/wsl-sudo.py
mv wsl-sudo.py /usr/bin/wsl-sudo.py
pip3 install -r requirements.txt
chmod 755 /usr/bin/wsl-sudo.py
cp fwdns.sh /usr/bin/fwdns.sh
chmod 755 /usr/bin/fwdns.sh
cat > /etc/wsl.conf<< EOF
[boot]
systemd=true

[network]
generateHosts=false
generateResolvConf=false
EOF
cp anyconnect.ps1 /mnt/c/Windows/System32/anyconnect.ps1