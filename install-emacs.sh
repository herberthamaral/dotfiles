#!/bin/bash
# (attempts to) Installs emacs 27.0.91
# EMACS_VERSION="27-0.91"
# mkdir -p ~/src
# cd ~/src
# if [ ! -d "~/src/emacs-$EMACS_VERSION" ]; then
#     curl -LO https://alpha.gnu.org/gnu/emacs/pretest/emacs-$EMACS_VERSION.tar.xz
#     tar -xf emacs-$EMACS_VERSION.tar.xz
# fi
# cd emacs-$EMACS_VERSION
# ./configure --with-cairo --with-sound=yes --with-xwidgets=yes  # emacs 27 enables modules by default
# make -j4
# sudo make install
# # installs doom
# if [ ! -d "~/.emacs.d" ]; then
#     git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# fi
# ln -s ~/dotfiles/.doom.d ~/.doom.d
~/.emacs.d/bin/doom install
