#!/bin/bash

# Check for required commands and install if necessary
  # Function to check and install a package
check_and_install() {
    package_name=$1
    command_name=$2

    if command -v "$command_name" &> /dev/null; then
        echo "$command_name is already installed."
    else
        echo "$command_name is not installed. Installing $package_name..."
        sudo pacman -Sy --noconfirm "$package_name" > /dev/null 2>&1
        echo "$package_name has been installed."
    fi
}

# Check and install each tool
check_and_install "ntfs-3g" "ntfs-3g"
check_and_install "networkmanager" "networkmanager"

echo "All tools checked and installed if necessary."

# Set variables
TIMEZONE="/usr/share/zoneinfo/Asia/Kolkata"  # Replace with your actual timezone

# Prompt for desired hostname
read -p "Enter desired hostname: " HOSTNAME

# Prompt for desired username
read -p "Enter desired username: " USERNAME

# Step 1: Set the timezone
echo "Setting timezone..."
ln -sf "$TIMEZONE" /etc/localtime

# Step 2: Update hardware clock
echo "Updating hardware clock..."
hwclock --systohc

# Step 3: Uncomment en_US.UTF-8 and en_US in /etc/locale.gen
echo "Uncommenting locale settings in /etc/locale.gen..."
sed -i.bak '/^.*en_US.UTF-8 UTF-8/s/^#//g; /^.*en_US ISO-8859-1/s/^#//g' /etc/locale.gen

# Step 4: Generate locales
echo "Generating locales..."
locale-gen

# Step 5: Set the LANG variable in /etc/locale.conf
echo "Writing LANG=en_US.UTF-8 to /etc/locale.conf..."
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Step 6: Set the keymap in /etc/vconsole.conf
echo "Writing KEYMAP=colemak to /etc/vconsole.conf..."
echo "KEYMAP=colemak" > /etc/vconsole.conf

# Step 7: Set hostname
echo "Writing hostname to /etc/hostname..."
echo "$HOSTNAME" > /etc/hostname

# Step 8: Install GRUB bootloader
echo "Installing GRUB bootloader..."
# Prompt for bootloader id
read -p "Enter Bootloader Name:" bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="$bootloader"

# Step 9: Generate GRUB configuration
echo "Generating GRUB configuration..."
grub-mkconfig -o /boot/grub/grub.cfg

# Step 10: Set password for root
echo "Setting password for root..."
passwd

# Step 11: Add a new user
echo "Adding new user ${USERNAME}..."
useradd -m "${USERNAME}"

# Step 12: Set password for the new user
echo "Setting password for ${USERNAME}..."
passwd "${USERNAME}"

# Step 13: Add the new user to the sudoers group
echo "Adding ${USERNAME} to the sudoers group..."
usermod -aG wheel "${USERNAME}"

# Step 14: Uncomment the line that allows the wheel group to use sudo
echo "Uncommenting the line '%wheel ALL=(ALL:ALL) ALL' in /etc/sudoers to allow sudo access..."
sed -i.bak '/^# %wheel ALL=(ALL:ALL) ALL/s/^# //g' /etc/sudoers

# Step 15: Inform the user about editing the sudoers file
echo "You may need to edit the sudoers file to allow the wheel group to use sudo."
echo "Run 'visudo' and ensure that the following line is uncommented:"
echo "# %wheel ALL=(ALL) ALL"

# Step 15: Enable NetworkManager
echo "Enabling NetworkManager"
systemctl enable NetworkManager

echo "Setup completed successfully!"
