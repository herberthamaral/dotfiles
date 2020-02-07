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

" do not forget to `pip install python-language-server`
let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_fixers = {
            \ 'javascript': ['prettier', 'eslint'],
            \ 'python': ['add_blank_lines_for_python_control_statements', 'isort'],
            \'*': ['remove_trailing_lines', 'trim_whitespace']
            \}
let g:ale_fix_on_save = 1
map gD :ALEGoToDefinitionInTab<CR>
map fD :ALEFindReferences<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" vundle begin

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'zhou13/vim-easyescape'

call vundle#end()
filetype plugin indent on

" vundle end

" vim-lsp

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif


" ctrl-p

set wildignore=build,node_modules,*.pyc

" easyescape

let g:easyescape_chars = { "f": 1, "d": 1 }
let g:easyescape_timeout = 100
cnoremap fd <ESC>
cnoremap df <ESC>

" airline

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='base16'
let g:airline#extensions#ale#enabled = 1
