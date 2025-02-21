#!/bin/bash

# Define the directory containing images and the target file
IMAGE_DIR="/usr/share/grub/images"
TARGET_FILE="/etc/grub.d/40_custom"

# Find all .jpeg and .png files in the specified directory
IMAGES=("$IMAGE_DIR"/*.{jpg,jpeg,png})

# Check if any images were found
if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No images found in $IMAGE_DIR"
    exit 1
fi

# Randomly select an image
RANDOM_IMAGE="${IMAGES[RANDOM % ${#IMAGES[@]}]}"

# Display the chosen image for confirmation
echo "Chosen image: $RANDOM_IMAGE"

# Prepare the line to search and the new replacement
# This regex will match "if background_image 'any_path';then"
SEARCH_STRING="if background_image '.*';then"
REPLACEMENT_STRING="if background_image '$RANDOM_IMAGE';then"

# Check if the TARGET_FILE exists
if [ ! -f "$TARGET_FILE" ]; then
    echo "Target file $TARGET_FILE does not exist."
    exit 1
fi

# Replace the specified line in the TARGET_FILE
# The -E flag enables extended regex for sed
sed -i.bak -E "s|$SEARCH_STRING|$REPLACEMENT_STRING|" "$TARGET_FILE"

# Check if the operation was successful
if [ $? -eq 0 ]; then
    echo "Successfully updated $TARGET_FILE with image path: $RANDOM_IMAGE"
else
    echo "Failed to update $TARGET_FILE"
    exit 1
fi
