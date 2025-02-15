#!/usr/bin/bash

set -e

# Update User Directories (Documents,Downloads,...)
xdg-user-dirs-update

# Clang
sudo nala install clang clangd -y

# Dotnet
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo nala update 
sudo nala install dotnet-sdk-8.0 dotnet-sdk-9.0 -y

# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg -yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo nala update
sudo nala install wezterm -y

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

# Installing Helix
cd /opt
# mkdir .src
# cd .src
git clone --depth=1 https://github.com/helix-editor/helix 
cd helix
cargo install --path helix-term --locked
cd
echo 'export HELIX_RUNTIME=/opt/helix/runtime' >> ~/.bashrc

# Font
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv

# YT-DL
sudo apt-get install python3-launchpadlib -y
sudo add-apt-repository ppa:tomtomtom/yt-dlp -y   # Add ppa repo to apt
sudo apt update                                   # Update package list
sudo apt install yt-dlp -y                        # Install yt-dlp

# Wifi Menu
cd
mkdir -p .config/scripts
cd .config/scripts
git clone https://github.com/ericmurphyxyz/rofi-wifi-menu.git
# cd rofi-wifi-menu
# bash "./rofi-wifi-menu.sh"
