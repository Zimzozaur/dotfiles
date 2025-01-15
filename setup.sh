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
  yay
)

echo "Updating package manager..."
sudo pacman -Syu


echo "Installing apps..."
for app in "${PACMAN_APPS[@]}"; do
  echo "Installing $app..."
  sudo pacman -S "$app" --noconfirm
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
cd ~/Downloads/
rm -rf jetbrains-toolbox-2.5.2.35332.tar.gz jetbrains-toolbox-*

# Config files
echo "Setting configs..."
cd ~/dotfiles/

swap_config_flat() {
  echo "Setting $1"
  rm -f "$2"
  stow "$1"
}

swap_config_flat git $HOME/.gitconfig/
swap_config_flat tmux $HOME/.tmux.conf

swap_config_nested() {
  echo "Setting $1"
  rm -rf "$2"
  stow "$1"
}

swap_config_nested ghostty $HOME/.config/ghostty/
swap_config_nested nvim $HOME/.config/nvim/



echo "🔥 All done! 🔥"
