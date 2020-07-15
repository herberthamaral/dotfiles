#!/bin/bash
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
ln -s $(pwd)/.vimrc $HOME/.vimrc
ln -s $(pwd)/.vim $HOME/.vim
ln -s $(pwd)/.isort.cfg $HOME/.isort.cfg
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
pip3 install --user flake8 'python-language-server[all]' proselint
vim +PluginInstall +qall
./install-emacs.sh
