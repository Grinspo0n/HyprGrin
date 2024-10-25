#!/bin/bash
set -e

# Updated Spinner function
spinner() {
    local pid=$1
    local delay=0.1
    local spin_chars='|/-\'

    while kill -0 "$pid" 2>/dev/null; do
        for (( i=0; i<${#spin_chars}; i++ )); do
            printf "\r[%c] " "${spin_chars:i:1}"
            sleep $delay
        done
    done
    printf "\r    \r" # Clear the line when done
}

# Main script in background
(
    REPO_URL="https://github.com/Grinspo0n/HyprGrin.git"
    TEMP_DIR="/tmp/HyprGrin"

    echo "Updating your system..."
    sudo pacman -Syu --noconfirm >/dev/null 2>&1

    echo "Prepping..."
    sudo pacman -S --needed base-devel git --noconfirm >/dev/null 2>&1
    sleep 1
    echo "Pacman Time!"
    sleep 2
    echo "This will take some time..."
    sleep 2
    echo "Maybe go grab a coffee or something..."
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

    sudo pacman -S --noconfirm "${OFFICIAL_APPS[@]}" >/dev/null 2>&1

    if [ -d "/tmp/yay" ]; then
        echo "Removing existing yay folder..."
        rm -rf /tmp/yay >/dev/null 2>&1
    fi

    echo "Installing yay..."
    echo "Going to need a sudo shortly..."
    sleep 1
    echo "But if you miss a sudo prompt, just re-run the script"
    sleep 1
    echo "It will go a lot faster to get to this point this time..."
    sleep 2
    echo "I promise..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay >/dev/null 2>&1
    cd /tmp/yay >/dev/null 2>&1
    makepkg -si --noconfirm >/dev/null 2>&1
    cd - >/dev/null 2>&1
    rm -rf /tmp/yay >/dev/null 2>&1

    echo "AUR time!"
    sleep 1
    echo "This one is also going to take a while..."
    sleep 1
    echo "And will need a sudo or two at some point..."
    AUR_APPS=(
        balena-etcher
        bluetui
        cava
        google-earth-pro
        hyprshot
        spotify
        spotify-tui
        tenki
        winbox
    )

    yay -S --noconfirm "${AUR_APPS[@]}" >/dev/null 2>&1

    echo "Cloning configs..."
    git clone "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo "Error: Failed to clone repository."
        exit 1
    fi

    echo "Moving configs..."
    cp -r "$TEMP_DIR/.config" ~/ >/dev/null 2>&1
    echo "Copying .zshrc file..."
    cp "$TEMP_DIR/.zshrc" ~/ >/dev/null 2>&1

    echo "Removing leftover files..."
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm >/dev/null 2>&1
    sudo pacman -Scc --noconfirm >/dev/null 2>&1
    rm -rf "$TEMP_DIR" >/dev/null 2>&1

    echo "And..."
    sudo systemctl enable sddm >/dev/null 2>&1
    echo "We..."
    hyprpm update -s >/dev/null 2>&1
    echo "Are..."
    chsh -s $(which zsh) >/dev/null 2>&1
    echo "Finally..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh >/dev/null 2>&1

    echo "Done ^_^"
) &

# Run spinner with the process ID of the background task
spinner $!
