repo := justfile_directory()
os := if os() == "macos" { "mac" } else { "linux" }

link:
    ln -sf {{ repo }}/.gitconfig        $HOME/.gitconfig
    ln -sf {{ repo }}/.gitignore_global $HOME/.gitignore_global
    ln -sf {{ repo }}/.psqlrc           $HOME/.psqlrc
    ln -sf {{ repo }}/.tmux.conf        $HOME/.tmux.conf
    ln -sf {{ repo }}/.vimrc            $HOME/.vimrc
    ln -sf {{ repo }}/.wezterm.{{ os }}.lua $HOME/.wezterm.lua
    ln -sf {{ repo }}/.zshrc            $HOME/.zshrc
    ln -sf {{ repo }}/.zshrc_{{ os }}   $HOME/.zshrc_os

    mkdir -p ~/.config/helix
    ln -sf {{ repo }}/helix.config.toml $HOME/.config/helix/config.toml
    mkdir -p ~/.config/qmk
    ln -sf {{ repo }}/qmk.ini $HOME/.config/qmk/qmk.ini
    mkdir -p ~/.config/zellij
    ln -sf {{ repo }}/zellij.config.{{ os }}.kdl $HOME/.config/zellij/config.kdl

    mkdir -p ~/.local/bin
    ln -sf {{ repo }}/git-merge-master.sh  $HOME/.local/bin/git-merge-master
    ln -sf {{ repo }}/git-pull-prune.sh    $HOME/.local/bin/git-pull-prune
    ln -sf {{ repo }}/git-rebase-master.sh $HOME/.local/bin/git-rebase-master
    ln -sf {{ repo }}/git-stash-pull.sh    $HOME/.local/bin/git-stash-pull
    ln -sf {{ repo }}/git-theirs.sh        $HOME/.local/bin/git-theirs

diff:
    #!/usr/bin/env bash
    rc=0
    difft --exit-code ~/.gitconfig {{ repo }}/.gitconfig || rc=1
    difft --exit-code ~/.gitignore_global {{ repo }}/.gitignore_global || rc=1
    difft --exit-code ~/.psqlrc {{ repo }}/.psqlrc || rc=1
    difft --exit-code ~/.tmux.conf {{ repo }}/.tmux.conf || rc=1
    difft --exit-code ~/.vimrc {{ repo }}/.vimrc || rc=1
    difft --exit-code ~/.wezterm.lua {{ repo }}/.wezterm.{{ os }}.lua || rc=1
    difft --exit-code ~/.zshrc {{ repo }}/.zshrc || rc=1
    difft --exit-code ~/.zshrc_os {{ repo }}/.zshrc_{{ os }} || rc=1

    difft --exit-code ~/.config/qmk/qmk.ini {{ repo }}/qmk.ini || rc=1
    difft --exit-code ~/.config/zellij/config.kdl {{ repo }}/zellij.config.{{ os }}.kdl || rc=1
    difft --exit-code ~/.config/helix/config.toml {{ repo }}/helix.config.toml || rc=1
    exit $rc

unlink:
    rm -f ~/.gitconfig
    rm -f ~/.gitignore_global
    rm -f ~/.psqlrc
    rm -f ~/.tmux.conf
    rm -f ~/.vimrc
    rm -f ~/.wezterm.lua
    rm -f ~/.zshrc
    rm -f ~/.zshrc_os

    rm -f ~/.config/helix/config.toml
    rm -f ~/.config/qmk/qmk.ini
    rm -f ~/.config/zellij/config.kdl

    rm -f ~/.local/bin/git-merge-master
    rm -f ~/.local/bin/git-pull-prune
    rm -f ~/.local/bin/git-rebase-master
    rm -f ~/.local/bin/git-stash-pull
    rm -f ~/.local/bin/git-theirs

viridis:
    R -f viridis.R > viridis.csv

setup_vim:
    bash setup_vim.sh

upload:
    rsync -avz --delete * .* /home/admin/git/home NoFuss.io:/home/admin/backlin/git/dotfiles/

deploy:
    sudo cp -r system/* /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl restart ollama.service
