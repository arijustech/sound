#!/bin/bash

echo "This script will install all the necessary packages to ensure good quality."

# Funkcija, kuri įdiegia paketus pagal distribuciją
install_packages() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    VERSION=$VERSION_ID
  else
    echo "Unable to detect distribution"
    exit 1
  fi

  # Arch Linux (Pacman)
  if [[ "$DISTRO" == "arch" || "$DISTRO" == "manjaro" ]]; then
    echo "Arch Linux or Manjaro detected, installing packages with pacman."
    sudo pacman -S --needed --noconfirm pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol easyeffects lv2 lilv suil lsp-plugins calf zam-plugins x42-plugins dragonfly-reverb carla qjackctl realtime-privileges
    sudo usermod -aG realtime $USER

  # Debian/Ubuntu (APT)
  elif [[ "$DISTRO" == "debian" || "$DISTRO" == "ubuntu" || "$DISTRO" == "linuxmint" ]]; then
    echo "Debian/Ubuntu or Linux Mint detected, installing packages with apt."
    sudo apt update -y
    sudo apt install -y pipewire pipewire-audio-client-libraries pipewire-jack wireplumber pavucontrol easyeffects lv2 lilv suil lsp-plugins calf zam-plugins x42-plugins dragonfly-reverb carla qjackctl realtime-privileges
    sudo usermod -aG realtime $USER

  # Fedora/RHEL (DNF)
  elif [[ "$DISTRO" == "fedora" || "$DISTRO" == "rhel" || "$DISTRO" == "centos" ]]; then
    echo "Fedora/RHEL or CentOS detected, installing packages with dnf."
    sudo dnf install -y pipewire pipewire-pulseaudio pipewire-jack wireplumber pavucontrol easyeffects lv2 lilv suil lsp-plugins calf zam-plugins x42-plugins dragonfly-reverb carla qjackctl realtime-privileges
    sudo usermod -aG realtime $USER

  else
    echo "Unsupported distribution detected: $DISTRO"
    exit 1
  fi
}

# Skambinama funkcija, kad įdiegtų paketai priklausomai nuo distros
install_packages

echo "Installation completed. Please log out and log back in to apply group changes."
echo "For all changes to take effect, please reboot your computer."
