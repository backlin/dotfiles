link:
    #!/usr/bin/env bash

    ln .bash_aliases ~/.bash_aliases
    if [[ $(uname) == Darwin ]]; then
      ln .mac_env ~/.mac_env
    fi
    if [[ $(uname) == Linux ]]; then
      ln .linux_env ~/.linux_env
    fi
    ln .psqlrc ~/.psqlrc
    ln .tmux.conf ~/.tmux.conf
    ln .gitconfig ~/.gitconfig
    ln .vimrc ~/.vimrc
    ln .zshrc ~/.zshrc
    mkdir -p ~/.config/qmk
    ln qmk.ini ~/.config/qmk/qmk.ini
    mkdir -p ~/.config/zellij
    ln zellij.config.kdl ~/.config/zellij/config.kdl

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
