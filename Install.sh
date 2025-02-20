#!/bin/bash

# Add color escape codes
GREEN='\033[0;32m'  # Green
NC='\033[0m'       # No Color

# Step 1: Download and execute the first script from GitHub.
echo -e "${GREEN}Starting the installation of Grub Themes${NC}"
sleep 2
FIRST_SCRIPT_URL="https://raw.githubusercontent.com/Keyaruga-Reese/grub-theme-installer/refs/heads/main/GrubThemeDownloader.sh"  # Replace with the actual URL
curl -s -O $FIRST_SCRIPT_URL
chmod +x GrubThemeDownloader.sh
./GrubThemeDownloader.sh

# Delete the first script after execution
rm GrubThemeDownloader.sh

# Delay for 2 seconds
sleep 2

# Step 2: Download the second script and move it to /boot/grub/themes.
echo -e "${GREEN}Creating scrpit to change GRUB Theme randomly${NC}"
SECOND_SCRIPT_URL="https://raw.githubusercontent.com/Keyaruga-Reese/grub-theme-installer/refs/heads/main/GrubThemeChanger.sh"  # Replace with the actual URL
curl -s -O $SECOND_SCRIPT_URL
mv GrubThemeChanger.sh /boot/grub/themes/GrubThemeChanger.sh
chmod +x /boot/grub/themes/GrubThemeChanger.sh

# Run the second script after moving it.
bash /boot/grub/themes/GrubThemeChanger.sh

# Delay for 2 seconds
sleep 2

# Step 3: Create a systemd service for the second script.
echo -e "${GREEN}Creating the systemd service to change theme after every reboot${NC}"
SYSTEMD_SERVICE_FILE="/etc/systemd/system/GrubThemeChanger.service"
echo "[Unit]
Description=Set random GRUB theme at boot
After=GrubImageChanger.service
Requires=GrubImageChanger.service

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