#!/bin/bash
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
ln -s $(pwd)/.vimrc $HOME/.vimrc
ln -s $(pwd)/.vim $HOME/.vim
