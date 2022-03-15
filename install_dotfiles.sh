#!/bin/bash
set -euo pipefail

BASEDIR=$(realpath ./dotfiles)

create_link() {
	ln -sf $BASEDIR/$1 $2
}

log() {
	echo -e $@
}

log 'VIM'
create_link vimrc ~/.vimrc
log 'VIM DONE'

log 'BASH'
create_link bash_aliases ~/.bash_aliases
log 'BASH DONE'

log 'GIT'
create_link gitconfig ~/.gitconfig
log 'GIT DONE'

