#!/bin/bash
pacman -S \
    fd \
    ripgrep \
    editorconfig-core-c \
    sbcl \
    retext \
    jq \
    gnuplot \
    graphviz \
    shellcheck \
    base-devel \
    openssl \
    zlib \
    discount \
    pandoc \
    ttf-hack \
    ttf-nerd-fonts-symbols-mono

# asdf

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
asdf install golang 1.14.5
asdf global golang 1.14.5

go get -u github.com/motemen/gore/cmd/gore
go get -u github.com/stamblerre/gocode
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/cweill/gotests/...
go get -u github.com/fatih/gomodifytags

asdf reshim golang

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
source ~/.bash_profile
pyenv install 3.8.3
pyenv global 3.8.3
pip install pipenv pytest grip


# nodejs
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs 12.18.2
asdf global nodejs 12.18.2
npm install -g marked


# fonts

mkdir -p ~/src
cd ~/src
git clone https://aur.archlinux.org/nerd-fonts-source-code-pro.git
cd nerd-fonts-source-code-pro
makepkg -si
