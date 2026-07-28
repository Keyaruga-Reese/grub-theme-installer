#!/bin/bash

# Define an array of theme URLs
URLS=(
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Acheron.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Aglaea.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/BlackSwan.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Castorice.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Cerydra.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Cipher.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Cyrene.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Evanescia.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Evernight.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Feixiao.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Firefly.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Fugue.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Hanya.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Himeko-Nova.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Huohuo.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Hyacine.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Hysilens.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Jade.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Jingliu.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Kafka.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Lingsha.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/March7th-TheHunt.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Rappa.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/RinTohsaka.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Robin.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/RuanMei.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/SilverWolf-LV.999.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Sparkle.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Sparxie.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Sushang.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/TheDahlia.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/TheHerta.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/Yunli.tar.gz"
    "https://github.com/Keyaruga-Reese/voidlhf_StarRailGrubThemes/releases/download/20260728-182351/YaoGuang.tar.gz"
)

# Define the destination and temporary directories
DEST_DIR="/boot/grub/themes"
TEMP_DIR="./temp_downloads"

# Step 1: Create the destination and temporary directories if they don't exist
sudo mkdir -p "$DEST_DIR"
mkdir -p "$TEMP_DIR"

# Step 2: Download each theme to the TEMP_DIR
for URL in "${URLS[@]}"; do
    # Extract theme name from the URL
    THEME_NAME=$(basename "${URL%.tar.gz}")

    # Customize download message
    echo "Downloading $THEME_NAME..."

    # Download the file to TEMP_DIR
    if wget -q --show-progress -P "$TEMP_DIR" "$URL"; then
        echo "$THEME_NAME downloaded successfully."
    else
        echo "Failed to download $URL"
    fi
done

# Step 3: Extract all downloaded files to DEST_DIR
for FILE in "$TEMP_DIR"/*.tar.gz; do
    if [ -f "$FILE" ]; then  # Check if the file exists
        THEME_NAME=$(basename "${FILE%.tar.gz}")
        echo "Installing Theme: $THEME_NAME"
        sudo tar --no-same-owner -xzf "$FILE" -C "$DEST_DIR"
    else
        echo "No files to extract."
    fi
done

# Step 4: Cleanup
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo "All themes have been downloaded and installed to $DEST_DIR."
