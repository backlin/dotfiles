#!/usr/bin/env bash

git checkout master
bash $HOME/backlin/git/dotfiles/git-pull-prune.sh
git checkout -
git rebase master

