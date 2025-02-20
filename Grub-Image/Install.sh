#!/bin/bash

# Add color escape codes
GREEN='\033[0;32m'  # Green
NC='\033[0m'       # No Color

# Step 1: Download and execute the first script from GitHub.
echo -e "${GREEN}Starting the installation of Grub Images${NC}"
sleep 2
FIRST_SCRIPT_URL="https://github.com/Keyaruga-Reese/grub-theme-installer/raw/refs/heads/main/Grub-Image/GrubImageInstaller.sh"  # Replace with the actual URL
curl -s -O $FIRST_SCRIPT_URL
chmod +x GrubImageInstaller.sh
./GrubImageInstaller.sh

# Delete the first script after execution
rm GrubImageInstaller.sh

# Delay for 2 seconds
sleep 2

# Step 1: Download and execute the first script from GitHub.
echo -e "${GREEN}Downloading Grub Images${NC}"
sleep 2
FIRST_SCRIPT_URL="https://github.com/Keyaruga-Reese/grub-theme-installer/raw/refs/heads/main/Grub-Image/GrubImageDownloader.sh"  # Replace with the actual URL
curl -s -O $FIRST_SCRIPT_URL
chmod +x GrubImageDownloader.sh
./GrubImageDownloader.sh

# Delete the first script after execution
rm GrubImageDownloader.sh

# Delay for 2 seconds
sleep 2

# Step 2: Download the second script and move it to /boot/grub/themes.
echo -e "${GREEN}Creating scrpit to change GRUB Image randomly${NC}"
SECOND_SCRIPT_URL="https://github.com/Keyaruga-Reese/grub-theme-installer/raw/refs/heads/main/Grub-Image/GrubImageChanger.sh"  # Replace with the actual URL
curl -s -O $SECOND_SCRIPT_URL
mv GrubImageChanger.sh /boot/grub/themes/GrubImageChanger.sh
chmod +x /boot/grub/themes/GrubImageChanger.sh

# Run the second script after moving it.
bash /boot/grub/themes/GrubImageChanger.sh

# Delay for 2 seconds
sleep 2

# Step 3: Create a systemd service for the second script.
echo -e "${GREEN}Creating the systemd service to change Image after every reboot${NC}"
SYSTEMD_SERVICE_FILE="/etc/systemd/system/GrubThemeChanger.service"
echo "[Unit]
Description=Set random GRUB theme at boot

[Service]
Type=oneshot
ExecStart=/boot/grub/themes/GrubThemeChanger.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target" > $SYSTEMD_SERVICE_FILE

# Delay for 2 seconds
sleep 2

# Enable the systemd service to run at boot
echo -e "${GREEN}Enabling the systemd service${NC}"
systemctl enable GrubThemeChanger.service

echo -e "${GREEN}Setup complete. The systemd service has been created and enabled.${NC}"