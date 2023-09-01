#!/bin/bash

echo "Getting current DNS servers, this takes a couple of seconds"

wsl-sudo.py /mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe -ExecutionPolicy Unrestricted -File C:\\WINDOWS\\System32\\anyconnect.ps1
echo "Copying contents to /etc/resolv.conf"
sudo mv /mnt/c/Users/Public/resolv.conf /etc/resolv.conf
sudo dos2unix /etc/resolv.conf