#!/bin/bash
set -e

CYAN='\e[96m'
NC='\e[0m'

# Main script in background
(
    REPO_URL="https://github.com/Grinspo0n/HyprGrin.git"
    TEMP_DIR="/tmp/HyprGrin"

    echo -e "${CYAN}Updating your system...${NC}"
    sudo pacman -Syu --noconfirm 

    echo -e "${CYAN}Prepping...${NC}"
    sudo pacman -S --needed base-devel git --noconfirm 
    sleep 1
    echo -e "${CYAN}Pacman Time!${NC}"
    sleep 1
    echo -e "${CYAN}This will take some time...${NC}"
    sleep 1
    echo -e "${CYAN}Maybe go grab a coffee or something...${NC}"
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
        echo -e "${CYAN}Removing existing yay folder...${NC}"
        rm -rf /tmp/yay 
    fi

    echo -e "${CYAN}Installing yay...${NC}"
    echo -e "${CYAN}Going to need a sudo or two shortly...${NC}"
    sleep 1
    echo -e "${CYAN}But if you miss a sudo prompt, just re-run the script${NC}"
    sleep 1
    echo -e "${CYAN}It will go a lot faster to get to this point next time...${NC}"
    sleep 2
    echo -e "${CYAN}I promise...${NC}"
    git clone https://aur.archlinux.org/yay.git /tmp/yay 
    cd /tmp/yay 
    makepkg -si --noconfirm 
    cd - 
    rm -rf /tmp/yay 

    echo -e "${CYAN}AUR time!${NC}"
    sleep 1
    echo -e "${CYAN}This one is also going to take a while...${NC}"
    sleep 1
    echo -e "${CYAN}But will need another sudo or two at some point...${NC}"
    sleep 1
    echo -e "${CYAN}So maybe dont get another coffee for this one...${NC}"
    sleep 1
    echo -e "${CYAN}Unless you like to re-run commands...${NC}"
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

    yay -S --noconfirm "${AUR_APPS[@]}" 

    echo -e "${CYAN}Cloning configs...${NC}"
    git clone "$REPO_URL" "$TEMP_DIR" 

    if [ $? -ne 0 ]; then
        echo -e "${CYAN}Error: Failed to clone repository.${NC}"
        exit 1
    fi

    echo -e "${CYAN}Moving configs...${NC}"
    cp -r "$TEMP_DIR/.config" ~/ 
    echo -e "${CYAN}Copying .zshrc file...${NC}"
    cp "$TEMP_DIR/.zshrc" ~/ 

    echo -e "${CYAN}Removing leftover files...${NC}"
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm 
    sudo pacman -Scc --noconfirm 
    rm -rf "$TEMP_DIR" 

    echo -e "${CYAN}And...${NC}"
    sudo systemctl enable sddm 
    echo -e "${CYAN}We...${NC}"
    hyprpm update -s 
    echo -e "${CYAN}Are...${NC}"
    chsh -s $(which zsh) 
    echo -e "${CYAN}Finally...${NC}"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh 

    echo -e "${CYAN}Done ^_^${NC}"
) &
