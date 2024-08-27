#!/bin/bash

# Install Terminus font and set font to ter-124n
sudo dnf install -y terminus-fonts-console
sudo setfont ter-124n

# Import Microsoft GPG key and add Visual Studio Code repository
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Update package lists
sudo dnf check-update

# Install required packages
sudo dnf install -y git hyprland neofetch sddm firefox unzip dolphin rofi code

# Create font directory and copy Montserrat fonts
sudo mkdir -p /usr/local/share/fonts/montserrat
sudo cp -v -r ~/.config/fonts/montserrat/* /usr/local/share/fonts/montserrat/
sudo chown -R root: /usr/local/share/fonts/montserrat
sudo chmod 644 /usr/local/share/fonts/montserrat/*
sudo restorecon -vFr /usr/local/share/fonts/montserrat

# Download and install Source Code Pro Nerd Font
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/SourceCodePro.zip
cd ~/.local/share/fonts
unzip SourceCodePro.zip
rm SourceCodePro.zip
fc-cache -fv

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Add Starship prompt and Neofetch to .bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'neofetch' >> ~/.bashrc

# Set default audio volume to 90%
pactl set-sink-volume @DEFAULT_SINK@ 90%

echo "Setup completed! Please restart your terminal or source ~/.bashrc to apply changes."
