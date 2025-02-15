#!/usr/bin/bash

set -e

sudo apt install software-properties-common -y
sudo apt-add-repository contrib non-free -y
sudo apt-get update && apt-get upgrade -y

# Installing nala
sudo apt install nala -y
sudo nala update

# Essentials
sudo nala install build-essential wget curl  -y

# X Window System and Input
sudo nala install amd64-microcode i3 xorg suckless-tools lightdm -y

# Browser
sudo nala install firefox-esr chromium -y

# System Utilities
sudo nala install thunar xbindkeys arandr xbacklight btop rofi unzip ksnip xfce4-power-manager feh numlockx unclutter fastfetch network-manager-gnome -y

# Audio Control
sudo nala install pulseaudio pavucontrol alsa-utils pulseaudio-module-zeroconf -y

# Media
sudo nala install mpv mupdf -y
