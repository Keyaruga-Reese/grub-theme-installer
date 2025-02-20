#!/bin/bash

# Define an array of theme URLs
URLS=(
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Acheron.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Aglaea.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/BlackSwan.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Feixiao.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Firefly.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Fugue.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Hanya.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Huohuo.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Jade.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Jingliu.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Kafka.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Lingsha.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/March7th-TheHunt.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Rappa.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Robin.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/RuanMei.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Sparkle.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Sushang.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/TheHerta.tar.gz"
    "https://github.com/voidlhf/StarRailGrubThemes/raw/refs/heads/master/themes/Yunli.tar.gz"
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
    if curl -# -L -o "$TEMP_DIR/$(basename "$URL")" "$URL"; then
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