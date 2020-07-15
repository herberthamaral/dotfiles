#!/bin/bash
# (attempts to) Installs emacs 27.0.91
mkdir -p ~/src
cd ~/src
curl -LO https://alpha.gnu.org/gnu/emacs/pretest/emacs-27.0.91.tar.xz
tar -xf emacs-27.0.91.tar.xz
cd emacs-27.0.91
./configure --with-cairo --with-sound=yes --with-xwidgets=yes  # emacs 27 enables modules by default
make -j4
sudo make install
# installs doom
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
ln -s ~/dotfiles/.doom.d ~/.doom.d
~/.emacs.d/bin/doom install
