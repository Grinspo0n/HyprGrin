#######################
### HYPERGRIN SETUP ###
#######################


#!/bin/bash
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


# Install official apps with pacman
echo "Installing normal apps..."
NORMAL_APPS=(
    ark
    bluez-utils
    brightnessctl
    btop
    chromium
    cmatrix
    discord
    dosfstools
    egl-wayland
    exfatprogs
    fastfetch
    freerdp
    fuzzel
    gping
    hyprland
    hyprlock
    hyprpaper
    hyprshot
    inetutils
    kate
    kcalc
    kitty
    konsole
    micro
    nano
    nemo
    networkmanager
    network-manager-applet
    networkmanager-l2tp
    networkmanager-openvpn
    networkmanager-pptp
    ntfs-3g
    otf-font-awesome
    partitionmanager
    pavucontrol
    plasma-meta
    plasma-workspace
    polkit-kde-agent
    power-profiles-daemon
    qbittorrent
    qt5-wayland
    qt5ct
    qt6-wayland
    qt6ct
    remmina
    spotifyd
    swaync
    traceroute
    unzip
    waybar
    wget
    wireless-tools
    xdg-desktop-portal-hyprland
    xdg-utils
    xorg-xinit
    yazi
    zip
    zsh
)

sudo pacman -S --noconfirm "${NORMAL_APPS[@]}"


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


# Install AUR apps using yay
echo "Installing AUR apps..."
AUR_APPS=(
    balena-etcher
    bluetui
    cava
    ferdium
    spotify
    spotify-tui
    tenki
    winbox
)

yay -S --noconfirm "${AUR_APPS[@]}"


# Clone the config repo
echo "Cloning repository..."
git clone "$REPO_URL" "$TEMP_DIR"


# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone repository."
    exit 1
fi


# Copy configs to the home directory
echo "Copying .config folder..."
cp -r "$TEMP_DIR/.config" ~/
echo "Copying .zshrc file..."
cp "$TEMP_DIR/.zshrc" ~/


# Remove the temporary directory
echo "Cleaning up..."
rm -rf "$TEMP_DIR"


# Finished
echo "Setup complete!"


####################
### BY GRINSPOON ###
####################
