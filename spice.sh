#!/bin/bash

set -e

# Install OpenSSH if missing
if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y openssh-server
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y openssh-server
elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y openssh-server
elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm openssh
fi

# Configure SSH port
sudo sed -i 's/^#\?Port .*/Port 30000/' /etc/ssh/sshd_config

# Enable and restart SSH
sudo systemctl enable sshd 2>/dev/null || sudo systemctl enable ssh
sudo systemctl restart sshd 2>/dev/null || sudo systemctl restart ssh

# Open firewall
if command -v firewall-cmd >/dev/null 2>&1; then
    sudo firewall-cmd --permanent --add-port=30000/tcp
    sudo firewall-cmd --reload
fi

if command -v ufw >/dev/null 2>&1; then
    sudo ufw allow 30000/tcp
fi

echo
echo "SSH is now listening on port 30000"
echo "Connect using:"
echo "ssh USER@YOUR_IP -p 30000"
