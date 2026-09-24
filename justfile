repo := justfile_directory()
os := if os() == "macos" { "mac" } else { "linux" }

link:
    ln -sf {{ repo }}/git/.gitconfig        $HOME/.gitconfig
    ln -sf {{ repo }}/git/.gitignore_global $HOME/.gitignore_global
    ln -sf {{ repo }}/.psqlrc           $HOME/.psqlrc
    ln -sf {{ repo }}/.tmux.conf        $HOME/.tmux.conf
    ln -sf {{ repo }}/.vimrc            $HOME/.vimrc
    ln -sf {{ repo }}/.wezterm.{{ os }}.lua $HOME/.wezterm.lua
    ln -sf {{ repo }}/.zshrc            $HOME/.zshrc
    ln -sf {{ repo }}/.zshrc_{{ os }}   $HOME/.zshrc_os

    mkdir -p ~/.config/helix
    ln -sf {{ repo }}/helix.config.toml $HOME/.config/helix/config.toml
    mkdir -p ~/.config/neru
    ln -sf {{ repo }}/neru.config.toml $HOME/.config/neru/config.toml
    mkdir -p ~/.config/qmk
    ln -sf {{ repo }}/qmk.ini $HOME/.config/qmk/qmk.ini
    mkdir -p ~/.config/zellij/layouts
    mkdir -p ~/.config/zellij/plugins
    ln -sf {{ repo }}/zellij.config.{{ os }}.kdl $HOME/.config/zellij/config.kdl
    ln -sf {{ repo }}/zellij.default_layout.kdl $HOME/.config/zellij/layouts/default.kdl

    mkdir -p ~/.local/bin
    ln -sf {{ repo }}/git/git-merge-master.sh  $HOME/.local/bin/git-merge-master
    ln -sf {{ repo }}/git/git-pull-prune.sh    $HOME/.local/bin/git-pull-prune
    ln -sf {{ repo }}/git/git-rebase-master.sh $HOME/.local/bin/git-rebase-master
    ln -sf {{ repo }}/git/git-stash-pull.sh    $HOME/.local/bin/git-stash-pull
    ln -sf {{ repo }}/git/git-theirs.sh        $HOME/.local/bin/git-theirs

diff:
    #!/usr/bin/env bash
    rc=0
    difft --exit-code ~/.gitconfig {{ repo }}/git/.gitconfig || rc=1
    difft --exit-code ~/.gitignore_global {{ repo }}/git/.gitignore_global || rc=1
    difft --exit-code ~/.psqlrc {{ repo }}/.psqlrc || rc=1
    difft --exit-code ~/.tmux.conf {{ repo }}/.tmux.conf || rc=1
    difft --exit-code ~/.vimrc {{ repo }}/.vimrc || rc=1
    difft --exit-code ~/.wezterm.lua {{ repo }}/.wezterm.{{ os }}.lua || rc=1
    difft --exit-code ~/.zshrc {{ repo }}/.zshrc || rc=1
    difft --exit-code ~/.zshrc_os {{ repo }}/.zshrc_{{ os }} || rc=1

    difft --exit-code ~/.config/qmk/qmk.ini {{ repo }}/qmk.ini || rc=1
    difft --exit-code ~/.config/zellij/config.kdl {{ repo }}/zellij.config.{{ os }}.kdl || rc=1
    difft --exit-code ~/.config/zellij/layouts/default.kdl {{ repo }}/zellij.default_layout.kdl || rc=1
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
    rm -f ~/.config/neru/config.toml
    rm -f ~/.config/qmk/qmk.ini
    rm -f ~/.config/zellij/config.kdl
    rm -f ~/.config/zellij/layouts/default.kdl

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

# Create ~/.claude-<name>, sharing all config with ~/.claude except auth
claude-profile name:
    #!/usr/bin/env bash
    set -euo pipefail

    primary="$HOME/.claude"
    profile="$HOME/.claude-{{ name }}"

    if [[ "{{ name }}" == */* ]]; then
        echo "error: profile name must not contain '/'" >&2
        exit 1
    fi
    if [[ "$profile" == "$primary" ]]; then
        echo "error: refusing to overwrite the primary profile" >&2
        exit 1
    fi
    if [[ ! -d "$primary" ]]; then
        echo "error: primary profile $primary does not exist" >&2
        exit 1
    fi

    mkdir -p "$profile"

    # Config that should be identical across profiles. Anything absent in the
    # primary profile is skipped, so this list can grow ahead of reality.
    shared=(
        CLAUDE.md
        agents
        commands
        hooks
        output-styles
        skills
    )
    for entry in "${shared[@]}"; do
        src="$primary/$entry"
        if [[ ! -e "$src" ]]; then
            continue
        fi
        # When the primary entry is itself a symlink into a git repo, point at
        # that repo directly rather than chaining through the primary profile.
        if [[ -L "$src" ]]; then
            src="$(readlink "$src")"
        fi
        ln -sfn "$src" "$profile/$entry"
    done

    # Plugin manifests store absolute installPath values under the primary
    # profile's cache, so the whole directory has to be shared, not copied.
    ln -sfn "$primary/plugins" "$profile/plugins"

    # settings.json is seeded from the primary profile but never linked: each
    # profile needs its own tool permissions and its own set of enabled
    # plugins. Only seed it once, so a diverged profile survives a re-run.
    if [[ ! -e "$profile/settings.json" ]]; then
        cp "$primary/settings.json" "$profile/settings.json"
        echo "seeded settings.json - edit it to scope this profile's access"
    else
        echo "kept existing settings.json"
    fi

    echo "profile ready: $profile"
    echo "run it with:  claude-as {{ name }}"
    echo "auth is separate - log in on first run"
