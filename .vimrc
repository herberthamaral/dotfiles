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
execute pathogen#infect()
set background=dark
set number
set wildignore=build,node_modules,*.pyc
