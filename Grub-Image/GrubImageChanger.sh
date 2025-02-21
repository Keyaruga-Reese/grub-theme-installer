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

# Define the new line to replace the existing background_image line
NEW_LINE="if background_image '$RANDOM_IMAGE'; then"

# Check if the TARGET_FILE exists
if [ ! -f "$TARGET_FILE" ]; then
    echo "Target file $TARGET_FILE does not exist."
    exit 1
fi

# Show the current line for matching
echo "Current contents of the target line:"
grep "^if background_image" "$TARGET_FILE"

# Replace the line in the TARGET_FILE
sed -i.bak "/^if background_image/c\\$NEW_LINE" "$TARGET_FILE"

# Check if the operation was successful
if [ $? -eq 0 ]; then
    echo "Successfully updated $TARGET_FILE with image path: $RANDOM_IMAGE"
else
    echo "Failed to update $TARGET_FILE"
    exit 1
fi

# Display the modified target line for confirmation
echo "Updated contents of the target line:"
grep "^if background_image" "$TARGET_FILE"