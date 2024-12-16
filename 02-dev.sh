#!/usr/bin/bash

# Update User Directories (Documents,Downloads,...)
xdg-user-dirs-update

# Clang
sudo nala install -y clang clangd

# Dotnet
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo nala update 
sudo nala install -y dotnet-sdk-9.0
sudo nala install -y dotnet-sdk-8.0

# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo nala update
sudo nala install -y wezterm

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust's binary directory to PATH for the current session
export PATH="$HOME/.cargo/bin:$PATH"

# Installing Helix
cd
mkdir .src
cd .src
git clone --depth=1 https://github.com/helix-editor/helix 
cd helix
cargo install --path helix-term --locked
cd
echo 'export HELIX_RUNTIME=~/.src/helix/runtime' >> ~/.bashrc

# Font
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip \
&& cd ~/.local/share/fonts \
&& unzip Meslo.zip \
&& rm Meslo.zip \
&& fc-cache -fv
