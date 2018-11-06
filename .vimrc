set expandtab
set autoindent
syntax enable
set shiftwidth=4
set tabstop=4
set softtabstop=4
filetype plugin indent on

set ignorecase
set smartcase
syntax on
map <S-Tab> :tabprevious<CR>
map <Tab> :tabnext<CR>
set hlsearch
set incsearch
set background=dark
set number


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'nvie/vim-flake8'
Plugin 'zhou13/vim-easyescape'  " TODO: configure
Plugin 'Vimjas/vim-python-pep8-indent'  " TODO: configure
Plugin 'tmhedberg/matchit'

set wildignore=build,node_modules,*.pyc
autocmd BufWritePost *.py call Flake8()
