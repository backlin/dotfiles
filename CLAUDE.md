# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Dotfiles repository for personal development environment setup across macOS and Linux. Config files are symlinked from this repo into `$HOME` via `link.sh`.

## Commands

Commands are run via [just](https://github.com/casey/just):

- `just link` - Symlink all config files into `$HOME`
- `just unlink` - Remove symlinks from `$HOME`
- `just setup_vim` - Install vim plugins
- `just deploy` - Copy systemd units to `/etc/systemd/system/` and restart services

## Structure

- **Shell config**: `.zshrc` (Oh My Zsh with robbyrussell theme, vim keybindings), `.bash_aliases` (git aliases, eza/zoxide integration)
- **Platform-specific env**: `.mac_env` (macOS), `.linux_env` (Linux) - loaded conditionally by `.zshrc` based on `uname`
- **Git helper scripts**: `git-*.sh` - shortcuts for common git workflows (pull+prune, stash+pull, merge/rebase master)
- **System configs**: `system/` directory contains systemd unit overrides, deployed via `just deploy`
- **Provisioning**: `install_ubuntu_2404.sh` sets up a fresh Ubuntu 24.04 machine

## Conventions

- Config files are hard-linked (not symlinked) by `link.sh` using `ln` without `-s`
- The repo is expected to live at `$HOME/git/home` (hardcoded in `.bash_aliases` and `.zshrc`)
- `.zshrc` sources `.bash_aliases` and the platform-specific env file directly from the repo path, not from `$HOME`
