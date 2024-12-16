#!/usr/bin/bash

apt install -y software-properties-common
apt update

apt-add-repository -y contrib non-free

apt-get update && apt-get upgrade -y

# Installing Sudo
apt install sudo -y

# Installing nala
sudo apt install nala -y
sudo nala update

# Essentials
sudo nala install -y build-essential wget curl 

# X Window System and Input
sudo nala install -y amd64-microcode i3 xorg suckless-tools lightdm

# Browser
sudo nala install -y firefox-esr

# CPU Microcode Updates (if you have amd cpu uncomment the first one and comment the second one)
sudo nala install -y amd64-microcode
# sudo nala install -y intel-microcode

# Network Management
sudo nala install -y wicd ufw

# Appearance and Customization
sudo nala install -y nitrogen numlockx unclutter

# System Utilities
sudo nala install -y xbindkeys arandr xbacklight

# Menu and Window Managers
sudo nala install -y rofi

# Archive Management
sudo nala install -y unzip

# File Managers
sudo nala install -y thunar

# XFCE Settings
sudo nala install -y xfce4-power-manager

# Audio Control
sudo nala install -y pulseaudio pavucontrol alsa-utils
sudo nala install -y pasystray paprefs pavumeter pulseaudio-module-zeroconf 

# System Information and Monitoring
sudo nala install -y htop conky

# Additional Utilities
# sudo nala install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends
# sudo systemctl enable avahi-daemon
# sudo systemctl enable acpid

# Screenshots
# sudo nala install -y flameshot

# Printer Support
# sudo nala install -y cups
# sudo systemctl enable cups

# Modern replacement for ls
# sudo nala install -y exa

# Bluetooth Support
# sudo nala install -y bluez blueman
# sudo systemctl enable bluetooth

# Image Viewer
# sudo nala install -y viewnior

# Media Player
# sudo nala install -y mpv

# Calculator
# sudo nala install -y galculator

# Document Viewer
# sudo nala install -y zathura

# Disk Utilities and Cleaning Tools
# sudo nala install -y gnome-disk-utility bleachbit
