#!/usr/bin/env bash

git status | grep testdata/_replay | awk -F 'both modified: ' '{print $2}' | xargs git co --theirs
git status | grep testdata/_replay | awk -F 'both modified: ' '{print $2}' | xargs git add

git status | grep testdata/_replay | awk -F 'both added: ' '{print $2}' | xargs git co --theirs
git status | grep testdata/_replay | awk -F 'both added: ' '{print $2}' | xargs git add
