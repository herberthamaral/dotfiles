#!/bin/bash
sudo apt-get update
sudo apt-get install git vim curl -y

curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git submodule init
git submodule update
ln -s $(pwd)/.vimrc $HOME/.vimrc
ln -s $(pwd)/.bashrc $HOME/.bashrc
ln -s $(pwd)/.vim $HOME/.vim
ln -s $(pwd)/.gitconfig $HOME/.gitconfig
