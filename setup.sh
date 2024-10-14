#!/bin/bash

# GitHub repository URL
REPO_URL="https://github.com/Grinspo0n/HyprGrin.git"

# Temporary directory for cloning the repository
TEMP_DIR="/tmp/HyprGrin"

# Clone the repository into the temporary directory
echo "Cloning repository..."
git clone "$REPO_URL" "$TEMP_DIR"

# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone repository."
    exit 1
fi

# Copy the .config folder to the home directory
echo "Copying .config folder..."
cp -r "$TEMP_DIR/.config" ~/

# Copy the .zshrc file to the home directory
echo "Copying .zshrc file..."
cp "$TEMP_DIR/.zshrc" ~/

# Remove the temporary directory
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo "Setup completed successfully!"
