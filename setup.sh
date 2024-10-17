#######################
### HYPERGRIN SETUP ###
#######################


#!/bin/bash
set -e
REPO_URL="https://github.com/Grinspo0n/HyprGrin.git"
TEMP_DIR="/tmp/HyprGrin"

echo "Updating..."
sudo pacman -Syu --noconfirm

echo "Prepping..."
sudo pacman -S --needed base-devel git --noconfirm

echo "Pacman Time!"
OFFICIAL_APPS=(
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
    gst-plugin-pipewire
    hyprcursor
    hyprland
    hyprlang
    hyprlock
    hyprpaper
    hyprutils
    hyprwayland-scanner
    inetutils
    intel-media-driver
    iwd
    kate
    kcalc
    kitty
    konsole
    libpulse
    libva-intel-driver
    libva-mesa-driver
    man-db
    micro
    nano
    nemo
    networkmanager
    network-manager-applet
    networkmanager-l2tp
    networkmanager-openvpn
    networkmanager-pptp
    ntfs-3g
    openssh
    otf-font-awesome
    partitionmanager
    pavucontrol
    picocom
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
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
    sddm
    smartmontools
    spotifyd
    swaync
    traceroute
    unzip
    vulkan-intel
    vulkan-radeon
    waybar
    wget
    wireless_tools
    wireplumber
    wpa_supplicant
    xdg-desktop-portal-hyprland
    xdg-utils
    xf86-video-amdgpu
    xf86-video-ati
    xf86-video-nouveau
    xf86-video-vmware
    xorg-server
    xorg-xinit
    yazi
    zip
    zsh
)

sudo pacman -S --noconfirm "${OFFICIAL_APPS[@]}"

echo "Cleaning configs"
rm -rf "$TEMP_DIR"

echo "Finally done ^_^"


####################
### BY GRINSPOON ###
####################
