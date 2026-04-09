#!/usr/bin/env bash

git checkout master
$HOME/backlin/git/dotfiles/git-pull-prune.sh
git checkout -
git merge master --no-ff

