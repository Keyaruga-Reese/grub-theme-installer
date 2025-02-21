#!/bin/bash

# Prompt the user to enter the partition
read -p "Please enter the partition where Arch is installed (root partition)" partition

# Retrieve the UUID for the specified partition
UUID=$(blkid -s UUID -o value "$partition")

# Define the target file
TARGET_FILE="/etc/grub.d/40_custom"

# Check if the UUID is already set in the file
if ! grep -q "search --no-floppy --fs-uuid --set=root ${UUID}" "$TARGET_FILE"; then
    # Append the required content to the end of the file
    {
        echo "insmod part_gpt"
        echo "insmod ext2"
        echo "search --no-floppy --fs-uuid --set=root ${UUID} # UUID added by script"
        echo "insmod png"
        echo "insmod jpeg"
        echo "if background_image /usr/share/grub/images/background.png; then"
        echo "  true"
        echo "else"
        echo "  set menu_color_normal=cyan/blue"
        echo "  set menu_color_highlight=white/blue"
        echo "fi"
    } >> "$TARGET_FILE"
    echo "UUID has been added to $TARGET_FILE."
else
    echo "UUID is already present in $TARGET_FILE. No changes made."
fi