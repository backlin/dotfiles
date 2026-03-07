apt update
apt upgrade -y

#------------------------------------------ Official packages

apt install -y git
apt install -y pre-commit
apt install -y 7zip
apt install -y curl
apt install -y make
apt install -y wl-clipboard

apt install -y zsh
apt install -y vim
apt install -y tmux
apt install -y ripgrep
apt install -y zoxide
apt install -y fd-find
apt install -y fzf
apt install -y eza # eza.rocks

apt install -y golang-go
apt install -y sqlite3
apt install -y postgresql

apt install -y libreoffice
apt install -y gimp
apt install -y sqlitebrowser
apt install -y vlc
apt install -y fonts-firacode
apt install -y fonts-powerline
# Then set fira code as terminal font to render prompts and zellij ui with all the cool glyphs.

#------------------------------------------ Rust packages

apt install -y rustup
rustup default stable

cargo install just
sudo ln -s ~/.cargo/bin/just /usr/local/bin/just

# https://mergiraf.org
cargo install --locked mergiraf

cargo install --locked zellij
# Uncomment copy_command "wl-copy", otherwise system clipboard cannot be used.
sed -i 's|^// \(copy_command "wl-copy".*\)|\1|' ~/.config/zellij/config.kdl

#------------------------------------------ Built from source

# https://difftastic.wilfred.me.uk
mkdir -p ~/git && cd ~/git
git clone git@github.com:Wilfred/difftastic.git
cd difftastic
cargo install --locked --path .


# Set zsh as default shell
chsh -s $(which zsh)
# Install Oh My zsh
# https://ohmyz.sh/#install
# Do not let the installer write a .zshrc for you.
# It should be taken from github.com/backlin/home
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
