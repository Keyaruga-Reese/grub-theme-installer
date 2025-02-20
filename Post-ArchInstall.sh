#!/bin/bash

# Set variables
TIMEZONE="/usr/share/zoneinfo/Asia/Kolkata"  # Replace with your actual timezone
HOSTNAME="alice"  # Replace with your desired hostname
USERNAME="merlin"  # Replace with your desired username

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
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Aethernum

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

echo "Setup completed successfully!"