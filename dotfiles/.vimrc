" A small, self-contained Vim configuration.
" Add optional, machine-specific settings in ~/.vim/config/local.vim.

if &compatible
  set nocompatible
endif

set encoding=utf-8
set hidden
set history=1000
set backspace=indent,eol,start
set mouse=a
set number
set ruler
set showcmd
set laststatus=2
set splitright
set splitbelow
set scrolloff=5
set sidescrolloff=5
set ignorecase
set smartcase
set incsearch
set hlsearch
set linebreak
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set wildignore=*.o,*.obj,*.bak,*.exe,*.hi
set updatetime=1000

if exists('&termguicolors')
  set termguicolors
endif

filetype plugin indent on
syntax enable
set background=dark

let mapleader = ','
let maplocalleader = ','

" Useful editing shortcuts.
nnoremap <leader><Space> :nohlsearch<CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>f :find <C-R>=expand('<cword>')<CR><CR>
nnoremap H ^
nnoremap L g_
nnoremap j gj
nnoremap k gk
vnoremap > >gv
vnoremap < <gv
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Up> 3<C-w>-
nnoremap <C-Down> 3<C-w>+
nnoremap <C-Left> 3<C-w><
nnoremap <C-Right> 3<C-w>>

command! W write
command! Wq wq
command! WQ wq
command! Q quit

augroup dotfiles_vim
  autocmd!
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd FileType make setlocal noexpandtab
  autocmd FileType nix setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd BufWritePost * checktime
augroup END

if filereadable(expand('~/.vim/config/local.vim'))
  source ~/.vim/config/local.vim
endif
