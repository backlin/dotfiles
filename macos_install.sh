#!/bin/bash

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

#------------------------------------------ Official packages

# brew install git # bundled with macOS
brew install pre-commit
brew install sevenzip
# brew install curl  # bundled with macOS
# brew install make

# brew install zsh   # bundled with macOS (default shell since Catalina)
# brew install vim     # bundled version is old; install newer via brew if needed
# brew install tmux
brew install ripgrep
brew install zoxide
brew install fd
brew install fzf
brew install eza

brew install go
# brew install sqlite  # bundled with macOS
brew install postgresql
brew install r

# brew install --cask libreoffice # On macOS I got Microsoft Office
# brew install --cask gimp
# brew install --cask db-browser-for-sqlite
# brew install --cask vlc
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
# Then set Fira Code as terminal font to render prompts and zellij ui with all the cool glyphs.

brew install --cask firefox

#------------------------------------------ Rust packages

brew install rustup
rustup default stable

brew install just

brew install difftastic
brew install mergiraf
brew install helix
brew install zellij

brew install rectangle

#------------------------------------------ Built from source

# Install Oh My zsh (zsh is already the default shell on macOS)
# https://ohmyz.sh/#install
# Do not let the installer write a .zshrc for you.
# It should be taken from github.com/backlin/home
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#------------------------------------------ Installed from App Store
echo "Install from App Store:\n"
echo "  BitWarden"

echo "Download and install from dmg:\n"
echo "  PyCharm"
echo "  yEd"
