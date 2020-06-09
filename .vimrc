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
set hlsearch
set incsearch
set background=dark
set number
set showcmd
set splitbelow
set splitright

" key bindings

nnoremap <S-Tab> :tabprevious<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <C-o> <Plug>ZoomWin

let mapleader = "\\"
nnoremap <leader>- <C-w>-
nnoremap <leader>= <C-w>+

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>

nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)

let mapleader = "-"

nnoremap <leader>q :bd<CR>

" ale  <- this needs to be placed before ALE actually loads


let g:ale_linters = {'python': ['flake8', 'mypy', 'black']}
let g:ale_fixers = {
            \ 'javascript': ['prettier', 'eslint'],
            \ 'python': ['isort'],
            \'*': ['remove_trailing_lines', 'trim_whitespace']
            \}
let g:ale_fix_on_save = 1
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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'zhou13/vim-easyescape'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'drn/zoomwin-vim'

call vundle#end()
filetype plugin indent on

" vundle end

" vim-lsp

if executable('pyls')
    " pip install python-language-server[all]
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gD <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> <leader>r <plug>(lsp-references)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


let g:lsp_signs_enabled = 0
let g:lsp_highlight_references_enabled = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/vim-lsp.log')
let g:lsp_signature_help_enabled = 0


" ctrl-p

set wildignore=build,node_modules,*.pyc
let g:ctrlp_working_path_mode = 'rc'
nnoremap <leader>a :CtrlPBuffer<CR>

" easyescape

let g:easyescape_chars = { "f": 1, "d": 1 }
let g:easyescape_timeout = 100
cnoremap fd <ESC>
cnoremap df <ESC>

" airline

let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='base16'
let g:airline#extensions#ale#enabled = 1
