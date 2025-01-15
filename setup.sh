#!/bin/bash

# Exit on errors
set -e

PACMAN_APPS=(
  ghostty
  tmux
  neofetch
  ttf-nerd-fonts-symbols-mono
  stow
  obsidian
  nasm
  obs-studio
  signal-desktop
  bat
  calibre
  virtualbox
  python-pipx
)

echo "Updating package manager..."
sudo pacman -Syu


echo "Installing apps..."
for app in "${APP[@]}"; do
  echo "Installing $app..."
  pacman -S "$app"
done


# Dropbox
echo "Downloading Dropbox..."
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
echo "Run Dropbox..."
~/.dropbox-dist/dropboxd

# Git LFS
echo "Installing Git LFS"
git lfs install

# JetBrains ToolBox
echo "Downloading JetBrains Toolbox..."
cd ~/Downloads/
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.5.2.35332.tar.gz

echo "Extracting JetBrains Toolbox..."
tar -xzf jetbrains-toolbox-2.5.2.35332.tar.gz
cd jetbrains-toolbox

echo "Run JetBrains Toolbox..."
./jetbrains-toolbox
cd ~/Download/
rm -rf jetbrains-toolbox-2.5.2.35332.tar.gz jetbrains-toolbox-*

# AstroNvim
# Not yet here

# Config files
echo "Setting configs..."
cd ~/config_baby/

for dir in */; do
  echo "Setting $dir"
  stow "$dir"
done

echo "🔥 All done! 🔥"
