#!/bin/bash

# This script sets up the terminal for Aerith's MacOS

# Ensure the script is run with sudo privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Please run with sudo."
  exit 1
fi

# Installs ohmyzsh
sudo -u "$SUDO_USER" sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install homebrew
sudo -u "$SUDO_USER" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install files from brew file

sudo -u "$SUDO_USER" brew bundle ./Brewfile

# Set up symlinks for configuration
sudo -u "$SUDO_USER" ln -s ~/dotfiles/nvim ~/.config/nvim
sudo -u "$SUDO_USER" ln -s ~/dotfiles/zsh ~/.zshrc
sudo -u "$SUDO_USER" ln -s ~/dotfiles/oh-my-zsh/ ~/.oh-my-zsh
sudo -u "$SUDO_USER" ln -s ~/dotfiles/papis ~/Library/Application\ Support/papis

# Get the latest release info from GitHub API

curl -s https://api.github.com/repos/glanceapp/glance/releases/latest |
  grep "browser_download_url" |
  grep "linux-arm64.tar.gz" |
  cut -d '"' -f 4 |
  xargs wget -O /opt/glance/glance-linux-arm64.tar.gz

gunzip -f /opt/glance/glance-linux-arm64.tar.gz
tar -xzf /opt/glance/glance-linux-arm64.tar.gz -C /opt/glance

# Start a glance launch daemon
ln -s ~/dotfiles/com.ysc4337.glance.plist /Library/LaunchDaemons/com.ysc4337.glance.plist

sudo -u "$SUDO_USER" wget -qO- https://astral.sh/uv/install.sh | sh

echo "Now run source ~/.zshrc to apply the changes."
