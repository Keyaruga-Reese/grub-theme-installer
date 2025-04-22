#!/bin/bash

echo -e "Installing required tools"
sudo pacman -S git go

echo -e "Downloading NVML from AUR"
cd /tmp
git clone https://aur.archlinux.org/python-nvidia-ml-py --depth=1
cd python-nvidia-ml-py
makepkg -si

echo -e "Making Overclock Script"
read -p "Enter Core Clock Offset: " Core

mkdir ~/.nvidia

Python_Script=~/.nvidia/nvidia_oc.py
sudo echo "#!/usr/bin/env python

from pynvml import *

nvmlInit()

# This sets the GPU to adjust - if this gives you errors or you have multiple GPUs, set to 1 or try other values
myGPU = nvmlDeviceGetHandleByIndex(0)

# The GPU clock offset value should replace "000" in the line below.
nvmlDeviceSetGpcClkVfOffset(myGPU, $Core)

# The memory clock offset should be **multiplied by 2** to replace the "000" below
# For example, an offset of 500 means inserting a value of 1000 in the next line
# nvmlDeviceSetMemClkVfOffset(myGPU, 000i)

# The power limit can be set below in mW - 216W becomes 216000, etc. Remove the below line if you don't want to adjust power limits.
# nvmlDeviceSetPowerManagementLimit(myGPU, 000000) " > $Python_Script

Bash_Script=~/.nvidia/nvidia_oc.sh
sudo echo "#!/bin/bash

sudo ~/.nvidia/nvidia_oc.py" > $Bash_Script

echo -e "${GREEN}Creating the systemd service to Enable Overclock at Boot${NC}"
sudo echo "[Unit]
Description=Overclock Nvidia GPU at Boot

[Service]
Type=oneshot
ExecStart=~/.nvidia/nvidia_oc.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target" > ~/.nvidia/Nvidia_OC.service

sudo mv ~/.nvidia/Nvidia_OC.service /etc/systemd/system/Nvidia_OC.service

echo -e "Enable the SystemD service"
sudo systemctl enable Nvidia_OC.service
