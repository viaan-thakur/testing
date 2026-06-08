sudo useradd -m -s /bin/bash vm && echo 'vm:12345678' | sudo chpasswd && sudo usermod -aG sudo vm 2>/dev/null || sudo usermod -aG wheel vm
