#!/bin/bash

# Set the script to exit on error
set -e

# GitHub repository URL for configs
REPO_URL="https://github.com/Grinspo0n/HyprGrin.git"

# Temporary directory for cloning the repository
TEMP_DIR="/tmp/HyprGrin"

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install required base-devel and git
echo "Installing base-devel and git..."
sudo pacman -S --needed base-devel git --noconfirm

# Install yay from the AUR
echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd -
rm -rf /tmp/yay

# Clean up orphaned packages and cache
echo "Cleaning up orphaned packages and cache..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm
sudo pacman -Scc --noconfirm

# Install your normal apps from pacman
echo "Installing normal apps..."
NORMAL_APPS=(
    package1
    package2
    package3
    # Add your normal applications here
)

sudo pacman -S --noconfirm "${NORMAL_APPS[@]}"

# Install your AUR apps using yay
echo "Installing AUR apps..."
AUR_APPS=(
    aur_package1
    aur_package2
    aur_package3
    # Add your AUR applications here
)

yay -S --noconfirm "${AUR_APPS[@]}"

# Clone the configuration repository
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

# Finished
echo "Setup complete!"
