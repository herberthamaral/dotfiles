EMACS_VERSION="27.0.91"
NODEJS_VERSION="12.8.2"
PYTHON_VERSION="3.8.3"
GOLANG_VERSION="1.14.5"


all: targets/arch-dependencies setup-vim setup-asdf setup-pyenv setup-emacs
.PHONY: all

clean: clean-vim clean-asdf clean-pyenv clean-emacs
.PHONY: clean


.ONESHELL:

targets/arch-dependencies:
	sudo pacman -Syu --noconfirm fd ripgrep editorconfig-core-c sbcl retext jq gnuplot graphviz shellcheck base-devel openssl zlib discount pandoc ttf-hack ttf-nerd-fonts-symbols-mono vim yay
	touch targets/arch-dependencies

# VIM

setup-vim: targets/setup-vim
.PHONY: setup-vim

clean-vim:
	vim +PluginClean +PluginUpdate +qall
	rm targets-vim-python-deps

.PHONY: clean-vim

targets/setup-vim: SHELL := bash
targets/setup-vim: targets/arch-dependencies .vim/bundle/Vundle.vim targets/vimrc targets/tmux targets/vim-python-deps targets/isort
	vim +PluginInstall +qall
	touch targets/setup-vim

.vim/bundle/Vundle.vim:
	git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

targets/vimrc: SHELL := bash
targets/vimrc:
	ln -s $$(pwd)/.vimrc $${HOME}/.vimrc
	ln -s $$(pwd)/.vim $${HOME}/.vim
	touch targets/vimrc

targets/tmux: SHELL := bash
targets/tmux:
	ln -s $$(pwd)/.tmux.conf $${HOME}/.tmux.conf
	touch targets/tmux


targets/vim-python-deps:
	pip3 install --user flake8 'python-language-server[all]' proselint
	touch targets/vim-python-deps

targets/isort: SHELL := bash
targets/isort:
	ln -s $$(pwd)/.isort.cfg $${HOME}/.isort.cfg
	touch targets/isort

# ASDF

setup-asdf: targets/asdf-golang-deps targets/asdf-node-12
.PHONY: setup-asdf

clean-asdf:
	rm targets/adsf-golang-deps
	rm targets/node-version
.PHONY: clean-asdf

targets/asdf: SHELL := bash
targets/asdf: targets/arch-dependencies
	git clone https://github.com/asdf-vm/asdf.git $${HOME}/.asdf --branch v0.7.8
	echo ". $${HOME}/.asdf/asdf.sh" >> ~/.bashrc
	echo ". $${HOME}/.asdf/completions/asdf.bash" >> $${HOME}/.bashrc
	source  $${HOME}/.bash_profile
	touch targets/asdf

targets/asdf-golang: SHELL := bash
targets/asdf-golang: targets/asdf
	source  $${HOME}/.bash_profile
	asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
	touch targets/asdf-golang


targets/asdf-golang-deps: SHELL := bash
targets/asdf-golang-deps: targets/asdf-golang
	source  $${HOME}/.bash_profile
	asdf install golang $(GOLANG_VERSION)
	asdf global golang $(GOLANG_VERSION)
	go get -u github.com/motemen/gore/cmd/gore
	go get -u github.com/stamblerre/gocode
	go get -u golang.org/x/tools/cmd/godoc
	go get -u golang.org/x/tools/cmd/goimports
	go get -u golang.org/x/tools/cmd/gorename
	go get -u golang.org/x/tools/cmd/guru
	go get -u github.com/cweill/gotests/...
	go get -u github.com/fatih/gomodifytags
	asdf reshim golang
	touch targets/asdf-golang-deps

targets/asdf-node: SHELL := bash
targets/asdf-node: targets/asdf
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	bash -c '$${ASDF_DATA_DIR:=$$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
	touch targets/asdf-node


targets/node-version: SHELL := bash
targets/node-version: targets/asdf-node
	source "$${HOME}/.bash_profile"
	asdf install nodejs $(NODEJS_VERSION)
	asdf global nodejs $(NODEJS_VERSION)
	npm install -g marked
	touch targets/node-version

# PYENV

setup-pyenv: targets/pyenv-python-deps
.PHONY: setup-pyenv

clean-pyenv:
	rm targets/pyenv-python-deps
.PHONY: clean-pyenv

targets/pyenv: SHELL := bash
targets/pyenv:
	git clone https://github.com/pyenv/pyenv.git "$${HOME}/.pyenv"
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$${HOME}/.bashrc"
	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> "$${HOME}/.bashrc"
	echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$$(pyenv init -)"\nfi' >> "$${HOME}/.bashrc"
	touch targets/pyenv

targets/pyenv-python-deps: SHELL := bash
targets/pyenv-python-deps: targets/arch-dependencies
	source "$${HOME}/.bash_profile"
	pyenv install $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)
	pip install pipenv pytest grip
	touch targets/pyenv-python-deps


# emacs

setup-emacs: targets/install-doom
.PHONY: setup-emacs

clean-emacs:
	rm targets/download-emacs
	rm targets/extract-emacs
	rm targets/compile-emacs
	rm targets/install-emacs
	rm targets/install-doom

targets/download-emacs: SHELL := bash
targets/download-emacs:
	mkdir -p $${HOME}/src
	cd $${HOME}/src && curl -LO https://alpha.gnu.org/gnu/emacs/pretest/emacs-${EMACS_VERSION}.tar.xz
	cd -
	touch targets/download-emacs


targets/extract-emacs: SHELL := bash
targets/extract-emacs: targets/download-emacs
	cd $${HOME}/src && tar -xf emacs-${EMACS_VERSION}.tar.xz
	cd -
	touch targets/extract-emacs


targets/compile-emacs: SHELL := bash
targets/compile-emacs: targets/download-emacs
	cd $${HOME}/src/emacs-${EMACS_VERSION}
	./configure --with-cairo --with-sound=yes --with-xwidgets=yes  # emacs 27 enables modules by default
	make -j4
	cd -
	touch targets/compile-emacs

targets/install-emacs: SHELL := bash
targets/install-emacs: targets/compile-emacs
	cd $${HOME}/src/emacs-${EMACS_VERSION}
	sudo make install
	cd -
	touch targets/install-emacs


targets/download-doom: SHELL := bash
targets/download-doom: targets/install-emacs
	git clone --depth 1 https://github.com/hlissner/doom-emacs $${HOME}/.emacs.d
	ln -s .doom.d $${HOME}/.doom.d
	cd -
	touch targets/download-doom


targets/install-doom: SHELL := bash
targets/install-doom: targets/download-doom
	$${HOME}/.emacs.d/bin/doom install -y
	touch targets/install-doom
	touch targets/update-doom


targets/update-doom:
	$${HOME}/.emacs.d/bin/doom sync -y
	touch targets/update-doom
