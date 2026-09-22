# Uncomment to profile zsh startup time
# Also uncomment zprof at the very end of this file
# zmodload zsh/zprof

bindkey -v # Vim style keyboard bindings (default is Emacs style)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 31

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  # Remote session
  export EDITOR='hx'
else
  # Local session
  export EDITOR='hx'
fi

#---[ Aliases ]----------------------------------------------------------------

# System-agnostic PATH additions
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Go configuration
export GOPATH=$(go env GOPATH)
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


alias gs='git status '
alias ga='git add '
alias gb='git br -vv '
alias gc='git commit '
alias gnit='git commit -am "nit" && git push '
alias gd='git diff '
alias gl='git log '
alias gla='git log --all --graph --decorate --oneline '
alias gco='git checkout '
alias gcob='git checkout -b '
alias gmain='git checkout main && git-pull-prune '
alias gsh='git push '
gci() { git commit -am "$*"; }
gcia() { git commit -a --amend -m "$*"; }

alias gll='git-pull-prune '
alias gsl='git-stash-pull '
alias gm='git-merge-master '
alias gr='git-rebase-master '
alias g-="git checkout - "

alias grhh='git reset --hard HEAD '
alias grhh1='git reset --hard HEAD~1 '
ct() { # Clone + Take
  local base="${1:?base URL required}"
  local repo="${2:?repo name required}"
  git clone "$base/$repo" && cd "$repo"
}
mv.() {
  local new="${1:?new name required}"
  local old="${PWD:t}"
  cd .. && mv "$old" "$new" && cd "$new"
}
rm.() {
  local old="${PWD:t}"
  cd .. && rm "$@" "$old"
}

alias lt='ls -aTL2 '

# System light/dark detection. Claude Code's "auto" theme queries the terminal
# background with OSC 11, but zellij answers that query itself with a hardcoded
# black, so inside zellij Claude always thinks the terminal is dark. Pass the
# theme explicitly instead.
system_appearance() { # Echo "dark" or "light", nothing if undetermined
  case "$(uname)" in
    Darwin)
      if [[ -n "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" ]]; then
        echo dark
      else
        echo light
      fi
      ;;
    Linux)
      if (( $+commands[gsettings] )); then
        case "$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)" in
          *dark*) echo dark ;;
          *) echo light ;;
        esac
      fi
      ;;
  esac
}

claude() { # Start claude with the theme matching the current system appearance
  local theme="$(system_appearance)"
  if [[ -n "$theme" ]]; then
    command claude --settings "{\"theme\": \"$theme\"}" "$@"
  else
    command claude "$@"
  fi
}

claude-as() { # Run claude against the ~/.claude-<name> profile
  local name="${1:?profile name required}"
  local dir="$HOME/.claude-$name"
  if [[ ! -d "$dir" ]]; then
    echo "no such profile: $dir (create it with: just claude-profile $name)" >&2
    return 1
  fi
  CLAUDE_CONFIG_DIR="$dir" claude "${@:2}"
}
alias claude-adage='claude '
alias claude-aph='claude-as aph '

source $HOME/.zshrc_os

# https://eza.rocks/
if (( $+commands[eza] )); then
  alias ls='eza --git '
fi

if [ -f $HOME/.config/authzed ]; then
  source $HOME/.config/authzed
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="/home/christofer/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Uncomment to profile zsh startup time
# Also uncomment the module load at the very top of this file
# zprof

# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
  # zoxide's cd override leaks into non-interactive shells via Claude Code's
  # shell snapshots, where fuzzy-matching cd is a footgun. Builtin cd there.
  cd() {
    if [[ -o interactive ]]; then
      __zoxide_z "$@"
    else
      \builtin cd -- "$@"
    fi
  }
fi

# Rename zellij tab to "dir: running-app" (dir basename + foreground command)
if [[ -n "$ZELLIJ" ]]; then
  _zj_tab() { zellij action rename-tab "$(basename "$PWD")${1:+: $1}"; }
  chpwd()  { _zj_tab; }                       # dir change -> just dir
  precmd() { _zj_tab; }                        # command finished -> just dir
  preexec() { _zj_tab "${1%% *}"; }            # command starts -> dir: appname
fi
