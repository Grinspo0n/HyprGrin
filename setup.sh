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
    cmake
    cmatrix
    cpio
    discord
    dosfstools
    egl-wayland
    exfatprogs
    fastfetch
    firefox
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
    meson
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

if [ -d "/tmp/yay" ]; then
    echo "Removing existing yay folder..."
    rm -rf /tmp/yay
fi

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd -
rm -rf /tmp/yay

echo "Cleaning..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm
sudo pacman -Scc --noconfirm

echo "AUR time"
AUR_APPS=(
    balena-etcher
    bluetui
    cava
    ferdium
    google-earth-pro
    hyprshot
    spotify
    spotify-tui
    tenki
    winbox
)

yay -S --noconfirm "${AUR_APPS[@]}"

echo "Cloning configs"
git clone "$REPO_URL" "$TEMP_DIR"

# Check if the clone was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone repository."
    exit 1
fi

echo "Moving configs"
cp -r "$TEMP_DIR/.config" ~/
echo "Copying .zshrc file..."
cp "$TEMP_DIR/.zshrc" ~/

echo "Cleaning configs"
rm -rf "$TEMP_DIR"

#SDDM setup
sudo systemctl enable sddm
hyprpm update -s
chsh -s $(which zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Finally done ^_^"


####################
### BY GRINSPOON ###
####################
