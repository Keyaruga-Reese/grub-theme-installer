#!/bin/bash

# Specify the file to modify
FILE="/etc/grub.d/40_custom"

# Check for existence of images in the directory
IMAGE_DIR="/usr/share/grub/images"
if [ ! "$(ls -A $IMAGE_DIR/*.png 2>/dev/null || ls -A $IMAGE_DIR/*.jpg 2>/dev/null)" ]; then
    echo "No PNG or JPEG images found in $IMAGE_DIR."
    exit 1
fi

# Get a random PNG or JPEG file from the directory
RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" \) | shuf -n 1)

# Replace the line in the file with the random image path
sed -i "s|if background_image /usr/share/grub/images/background.png;|if background_image $RANDOM_IMAGE;|" "$FILE"

echo "Replaced background image path with: $RANDOM_IMAGE"