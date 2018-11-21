" general config
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

" ale  <- this needs to be placed before ALE actually loads

let b:ale_linters = {
            \ 'python': ['pyls', 'flake8']
            \}
let b:ale_fixers = {
            \ 'javascript': ['prettier', 'eslint'],
            \'*': ['remove_trailing_lines', 'trim_whitespace']
            \}
let g:ale_completion_enabled = 1
map gD :ALEGoToDefinitionInTab<CR>

" vundle begin

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'nvie/vim-flake8'
Plugin 'zhou13/vim-easyescape'
Plugin 'Vimjas/vim-python-pep8-indent'  " TODO: configure
Plugin 'tmhedberg/matchit'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
filetype plugin indent on

" vundle end

" ctrl-p

set wildignore=build,node_modules,*.pyc

" flake-8

" autocmd BufWritePost *.py call Flake8()

" easyescape

let g:easyescape_chars = { "f": 1, "d": 1 }
let g:easyescape_timeout = 100
cnoremap fd <ESC>
cnoremap df <ESC>

" airline

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='base16'
let g:airline#extensions#ale#enabled = 1
