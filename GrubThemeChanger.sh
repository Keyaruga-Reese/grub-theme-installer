#!/bin/bash

# Define the directory where themes are located
THEME_DIR="/boot/grub/themes"

# Define the path to the GRUB configuration file
GRUB_CONFIG="/etc/default/grub"

# Step 1: Find all available themes (directories containing theme.txt)
available_themes=()

# Iterate through directories in THEME_DIR
for dir in "$THEME_DIR"/*; do
    if [[ -d "$dir" && -f "$dir/theme.txt" ]]; then
        # Add the directory name to available_themes
        available_themes+=("$(basename "$dir")")
    fi
done

# Check if there are any available themes
if [ ${#available_themes[@]} -eq 0 ]; then
    echo "No themes found in $THEME_DIR."
    exit 1
fi

# Step 2: Randomly select a theme
random_theme=${available_themes[RANDOM % ${#available_themes[@]}]}

# Step 3: Update the GRUB configuration file to set the new theme
echo "Setting GRUB_THEME to $random_theme in $GRUB_CONFIG..."

# Use sed to replace the GRUB_THEME line with the new theme.
sudo sed -i.bak "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEME_DIR}/$random_theme/theme.txt\"|" "$GRUB_CONFIG"

# Step 4: (Optional) Update GRUB to apply changes
# echo "Updating GRUB..."
# sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "The GRUB theme has been set to $random_theme."
