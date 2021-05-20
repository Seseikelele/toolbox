#!/bin/bash
set -euo pipefail

BASEDIR=$(realpath ./dotfiles)

create_link() {
	ln -sf $BASEDIR/$1 $2
}

log() {
	echo -e $@
}

install_vim_files() {
	log '\tChecking for neovim'
	[ -e /bin/nvim ] && {
		log '\tInstalling for neovim';
		create_link init.vim ~/.config/nvim/init.vim;
		curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		log '\tDone for neovim';
	}

	log '\tChecking for !neovim and vim'
	[ ! -e /bin/nvim ] && [ -e /bin/vim ] && {
		log '\tInstalling for vim';
		create_link init.vim ~/.vimrc;
		curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		log '\tDone for vim';
	}

	log '\tdone'
}

log 'BASH'
create_link bash/aliases ~/.bash_aliases
log 'BASH DONE'

log 'GIT'
create_link gitconfig ~/.gitconfig
log 'GIT DONE'

log 'VIM'
install_vim_files
# :PlugInstall
log 'VIM DONE'
