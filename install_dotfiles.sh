#!/bin/bash
set -euo pipefail

BASEDIR=$(realpath ./dotfiles)

ln -sf $BASEDIR/.gitconfig ~/.gitconfig
ln -sf $BASEDIR/init.vim ~/.config/nvim/init.vim
