repo := justfile_directory()
env_file := if os() == "macos" { ".mac_env" } else { ".linux_env" }

link:
    ln -sf {{ repo }}/.bash_aliases  $HOME/.bash_aliases
    ln -sf {{ repo }}/{{ env_file }} $HOME/{{ env_file }}
    ln -sf {{ repo }}/.psqlrc        $HOME/.psqlrc
    ln -sf {{ repo }}/.tmux.conf     $HOME/.tmux.conf
    ln -sf {{ repo }}/.gitconfig     $HOME/.gitconfig
    ln -sf {{ repo }}/.vimrc         $HOME/.vimrc
    ln -sf {{ repo }}/.zshrc         $HOME/.zshrc
    mkdir -p ~/.config/qmk
    ln -sf {{ repo }}/qmk.ini           $HOME/.config/qmk/qmk.ini
    mkdir -p ~/.config/zellij
    ln -sf {{ repo }}/zellij.config.kdl $HOME/.config/zellij/config.kdl
    mkdir -p ~/.config/helix
    ln -sf {{ repo }}/helix.config.toml $HOME/.config/helix/config.toml

diff:
    #!/usr/bin/env bash
    rc=0
    difft --exit-code ~/.bash_aliases {{ repo }}/.bash_aliases || rc=1
    difft --exit-code ~/{{ env_file }} {{ repo }}/{{ env_file }} || rc=1
    difft --exit-code ~/.psqlrc {{ repo }}/.psqlrc || rc=1
    difft --exit-code ~/.tmux.conf {{ repo }}/.tmux.conf || rc=1
    difft --exit-code ~/.gitconfig {{ repo }}/.gitconfig || rc=1
    difft --exit-code ~/.vimrc {{ repo }}/.vimrc || rc=1
    difft --exit-code ~/.zshrc {{ repo }}/.zshrc || rc=1
    difft --exit-code ~/.config/qmk/qmk.ini {{ repo }}/qmk.ini || rc=1
    difft --exit-code ~/.config/zellij/config.kdl {{ repo }}/zellij.config.kdl || rc=1
    difft --exit-code ~/.config/helix/config.toml {{ repo }}/helix.config.toml || rc=1
    exit $rc

unlink:
    rm -f ~/.bash_aliases
    rm -f ~/.bazelrc
    rm -f ~/.linux_env
    rm -f ~/.mac_env
    rm -f ~/.psqlrc
    rm -f ~/.tmux.conf
    rm -f ~/.vimrc
    rm -f ~/.zshrc
    rm -f ~/.config/qmk/qmk.ini
    rm -f ~/.config/zellij/config.kdl

viridis:
    R -f viridis.R > viridis.csv

setup_vim:
    bash setup_vim.sh

upload:
    rsync -avz --delete * .* /home/admin/git/home NoFuss.io:/home/admin/git/home/

deploy:
    sudo cp -r system/* /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl restart ollama.service
