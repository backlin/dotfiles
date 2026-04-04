# Install Firefox from deb, not snap, since snap slows down boot too much
add-apt-repository ppa:mozillateam/ppa

# https://wezterm.org/install/linux.html#__tabbed_1_3
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

sudo apt update
sudo apt upgrade -y

#------------------------------------------ Official packages

sudo apt install -y git
sudo apt install -y pre-commit
sudo apt install -y 7zip
sudo apt install -y curl
sudo apt install -y make
sudo apt install -y wl-clipboard

sudo apt install -y zsh
sudo apt install -y vim
sudo apt install -y tmux
sudo apt install -y ripgrep
sudo apt install -y zoxide
sudo apt install -y fd-find
sudo apt install -y fzf
sudo apt install -y eza # eza.rocks

sudo apt install -y golang-go
sudo apt install -y sqlite3
sudo apt install -y postgresql

sudo apt install -y libreoffice
sudo apt install -y gimp
sudo apt install -y sqlitebrowser
sudo apt install -y vlc
sudo apt install -y fonts-firacode
sudo apt install -y fonts-powerline
# Then set fira code as terminal font to render prompts and zellij ui with all the cool glyphs.

sudo apt install -y firefox
sudo apt install -y wezterm

#------------------------------------------ Rust packages

sudo apt install -y rustup
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
