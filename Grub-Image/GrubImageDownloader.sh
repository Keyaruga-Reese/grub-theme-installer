#!/bin/bash

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Define the array of GitHub zip file URLs
ZIP_FILES=(
    "https://github.com/Keyaruga-Reese/grub-theme-installer/raw/refs/heads/main/Grub-Image/Images-1.zip"
    "https://github.com/Keyaruga-Reese/grub-theme-installer/raw/refs/heads/main/Grub-Image/Images-2.zip"
    # Add more zip URLs as needed
)

# Download all zip files to the temporary directory
echo "Downloading Images Zips..."
for ZIP_URL in "${ZIP_FILES[@]}"; do
    wget -q --show-progress -P "$TEMP_DIR" "$ZIP_URL"
done

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download complete!"
else
    echo "Failed to download zip files."
    exit 1
fi

# Define the target extraction directory
TARGET_DIR="/usr/share/grub/images"

# Create the target directory if it doesn't exist
sudo mkdir -p "$TARGET_DIR"

# Extract each zip file into the target directory
echo "Installing the Images..."
for ZIP_FILE in "$TEMP_DIR"/*.zip; do
    sudo unzip -o "$ZIP_FILE" -d "$TARGET_DIR"
done

# Check if the extraction was successful
if [ $? -eq 0 ]; then
    echo "Extraction complete!"
else
    echo "Failed to extract zip files."
    exit 1
fi

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

echo "All done!"