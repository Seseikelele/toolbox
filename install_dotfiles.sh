#!/bin/bash
set -euo pipefail

BASEDIR=$(realpath ./dotfiles)

create_link() {
	ln -sf $BASEDIR/$1 $2
}

install_vim_files() {
	echo "Checking for neovim"
	[ -e /bin/nvim ] && {
		echo "Installing for neovim";
		create_link init.vim ~/.config/nvim/init.vim;
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		echo "Done for neovim";
	}

	echo "Checking for !neovim and vim"
	[ ! -e /bin/nvim ] && [ -e /bin/vim ] && {
		echo "Installing for vim";
		create_link init.vim ~/.vimrc;
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		echo "Done for vim";
	}
}

echo "BASH"
create_link bash/aliases ~/.bash_aliases
echo "BASH DONE"

echo "GIT"
create_link gitconfig ~/.gitconfig
echo "GIT DONE"

echo "VIM"
install_vim_files
# :PlugInstall
echo "VIM DONE"
