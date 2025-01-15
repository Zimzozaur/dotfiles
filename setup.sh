#!/bin/bash

# Exit on errors
set -e

PACMAN_APPS=(
  fakeroot
  base-devel
  neovim
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
  git-lfs
)

echo "Updating package manager..."
sudo pacman -Syu


echo "Installing apps..."
for app in "${PACMAN_APPS[@]}"; do
  echo "Installing $app..."
  pacman -S "$app"
done


# Ghostty
yay -S ghostty-git

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
cd jetbrains-toolbox-2.5.2.35332

echo "Run JetBrains Toolbox..."
./jetbrains-toolbox
cd ~/Download/
rm -rf jetbrains-toolbox-2.5.2.35332.tar.gz jetbrains-toolbox-*

# AstroNvim
# Not yet here

# Config files
echo "Setting configs..."
cd ~/dotfiles/

swap_config() {
  echo "Setting $1"
  rm -rf "$2"
  stow "$1"
}

FLAT_PATHS=(
  git
  tmux
)

for dir in "${FLAT_PATHS[@]}"; do
  echo "Setting $dir"
  swap_config "$dir" ~/"$dir"
done

DOT_CONFIG_PATHS=(
  ghostty
  nvim
)

for dir in "${DOT_CONFIG_PATHS[@]}"; do
  echo "Setting $dir"
  swap_config "$dir" ~/.config/"$dir"
done


echo "🔥 All done! 🔥"
