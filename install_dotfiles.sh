#!/bin/bash
set -euo pipefail

BASEDIR=$(realpath ./dotfiles)

install_vim_files() {
	echo "Checking for neovim"
	[ -e /bin/nvim ] && {
		echo "Installing for neovim";
		ln -sf $BASEDIR/init.vim ~/.config/nvim/init.vim;
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		echo "Done for neovim";
	}

	echo "Checking for !neovim and vim"
	[ ! -e /bin/nvim ] && [ -e /bin/vim ] && {
		echo "Installing for vim";
		ln -sf $BASEDIR/init.vim ~/.vimrc;
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
		echo "Done for vim";
	}
}

echo "GIT"
ln -sf $BASEDIR/.gitconfig ~/.gitconfig
echo "GIT DONE"
echo "VIM"
install_vim_files
# :PlugInstall
echo "VIM DONE"
