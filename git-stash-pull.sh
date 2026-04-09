#!/usr/bin/env bash

git stash
bash $HOME/backlin/git/dotfiles/git-pull-prune.sh
git stash pop

