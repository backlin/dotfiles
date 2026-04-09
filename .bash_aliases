REPO="$HOME/backlin/git/dotfiles"

alias gs='git status '
alias ga='git add '
alias gb='git br -vv '
alias gc='git commit '
alias gd='git diff '
alias gl='git log '
alias gco='git checkout '
alias gcob='git checkout -b '
alias gcom='git checkout master '
alias gsh='git push'

alias gll="$REPO/git-pull-prune.sh "
alias gsl="$REPO/git-stash-pull.sh "
alias gm="$REPO/git-merge-master.sh "
alias gr="$REPO/git-rebase-master.sh "

alias grhh='git reset --hard HEAD '
alias grhh1='git reset --hard HEAD~1 '

# https://eza.rocks/
if [ $(which eza) ]; then
  alias ls='eza --git '
fi

# https://github.com/ajeetdsouza/zoxide
if [ $(which zoxide) ]; then
  eval "$(zoxide init zsh --cmd cd)"
fi

