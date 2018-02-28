call plug#begin('~/.vim/plugged')

Plug 'geoffharcourt/one-dark.vim'
Plug 'godlygeek/tabular'
Plug 'keith/swift.vim'
Plug 'kien/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Mark--Karkat'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }
Plug 'scrooloose/nerdtree'
"Plug 'racer-rust/vim-racer'
Plug 'vim-scripts/vim-misc'
Plug 'xolox/vim-session'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'sebastianmarkow/deoplete-rust'
"Plug 'zchee/deoplete-jedi'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'

call plug#end()

" Use VIM settings, rather than Vi settings
set nocompatible
"filetype on " Prevent an error exit code if filetype is off already
"filetype off

set shell=/bin/bash

" Turn on filetype based plugins
filetype plugin indent on

" Always show the status line
set laststatus=2

set encoding=utf-8

set ttyfast

set history=1000

" Persistent undos
set undolevels=10000
if v:version >= 730
  set undofile
  set undoreload=10000
endif

" Keep temporary files and backup files in one dir rather than cluttering
" source dirs.
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Keep at least 5 lines around whever I'm scrolling
set scrolloff=5
set sidescrolloff=5

" Make backspace work on everything, everywhere
set backspace=indent,eol,start

" Enable mouse
set mouse=a

" Turn on line numbers
set nu

" Have ctags look all the way up to root for a tags file
set tags=tags;/

"Enable syntax highlighting
syntax on

" Auotmatically indent based on file type
set autoindent

" Case insensitive search (smartcase)
set ignorecase smartcase

" Highlight search
set hls

" Wrap text instead of being on one line
set lbr

" Turn the ruler on
set ruler

" Incremental search
set incsearch

" show commands as you're typing them
set showcmd

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Fix the leader to be something a little nicer
let localmapleader=","
let mapleader=","

" Move , functionality to ? (which I never use)
noremap ? ,

" Replace all occurrences of a word
nnoremap <leader>R :%s/<C-r><C-w>//g<Left><Left>

" Make it easier to clear search results
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Make it easier to move around
noremap H ^
noremap L g_

" Ctrl-j/k inserts blank line below/above, and Alt-j/k deletes.
nnoremap <silent><C-e> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-q> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent><A-e> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-q> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" Set space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Have searches center the line the word is found on
map N Nzz
map n nzz

" Make block stay highlighted when changing indentation
vnoremap > >gv
vnoremap < <gv

" Bind NERDTree commands
map <F2> :NERDTreeToggle<CR>
map <C-c> <Leader>ci

" Work better with splits
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
if has('nvim')
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  "tnoremap <C-l> <C-\><C-n><C-w>l
endif
autocmd BufWinEnter,WinEnter term://* startinsert | set mouse=vchi | sleep 100m | set mouse=a
autocmd BufLeave term://* stopinsert | set mouse=a
if has('nvim')
  autocmd TermOpen * setlocal statusline=%{b:term_title}
endif

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

" C-t for new tab
map <C-t> :tabnew<CR>

" Make j/k work as expected with wrapped lines
map j gj
map k gk

" Save and exit insert mode using kj
inoremap kj <Esc>:w<CR>

" These don't have bindings anyways
command! Wq wq
command! WQ wq
command! W w
command! Q q
nnoremap S :w<cr>

" Make it easier to go to the last buffer
nnoremap <leader>b :b#<CR>

" After 4s of inactivity, check for external file modifications on next keypress
au CursorHold * checktime

"if has("unix")
"  let s:uname = system("echo -n $(uname)")
"  if s:uname == "Darwin"
"    " Mac specific bindings
"
"    " Alt key doesn't seem to work on Mac, so use the actual char receieved
"    nnoremap <silent>∆ m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
"    nnoremap <silent>˚ m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
"  endif
"endif

" Treat tmux like normal xterm
if &term == "screen-256color"
  set term=xterm-256color
end

" Set window title based on current file
if &term == "xterm" || &term == "xterm-256color"
  set title
end

" Fugitive bindings
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
"nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

if exists(":Tabularize")
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
  nmap <leader>aa :Tabularize /
  vmap <leader>aa :Tabularize /

  " Swift multi-line parameter lists
  vmap <leader>aP :Tabularize /\w*:<CR>
endif

set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab expandtab

" Have it keep changes to open buffers without saving to the files
set hidden

" Setup OmniComplete to be context aware
let g:SuperTabDefaultCompletionType="context"

" Prevents Vim 7.0 from setting filetype to 'plaintex'
let g:tex_flavor='latex'

" Ignore silly files
set wildignore=*.o,*.obj,*.bak,*.exe,*.hi,*.6

" Set colorscheme
set background=dark
colorscheme onedark

" Force vim to use 256 colors
set t_Co=256

" Mark trailing whitespace
set listchars=tab:\ \ ,trail:\ ,extends:»,precedes:«
if &background == "dark"
  highlight ExtraWhitespace ctermbg=Red guibg=Red
else
  highlight ExtraWhitespace ctermbg=Yellow guibg=Yellow
end
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove the toolbar if it's macvim or gvim
if has("gui_running")
  set guioptions-=T
endif

" Setup the filetype for markdown
au BufNewFile,BufRead *.md set filetype=markdown

" Set indentention for Make files
au Filetype make set noexpandtab

" Set settings for LaTeX files
au Filetype tex SPCheck
au Filetype tex let dialect='US'

" Racer settings
set hidden
let g:racer_cmd="/Users/tyler/.cargo/bin/racer"
let $RUST_SRC_PATH="/Users/tyler/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
let g:racer_experimental_completer=1

" deoplete settings
let g:deoplete#enable_at_startup = 1

" deoplete-rust settings
let g:deoplete#sources#rust#racer_binary="/Users/tyler/.cargo/bin/racer"
let g:deoplete#sources#rust#rust_source_path="/Users/tyler/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
nmap <buffer> gs <plug>DeopleteRustGoToDefinitionSplit
nmap <buffer> gv <plug>DeopleteRustGoToDefinitionVSplit
nmap <buffer> gb <plug>DeopleteRustGoToDefinitionTab

" vim-session settings
let g:session_autosave='yes'
let g:session_periodic_autosave=2

" Syntastic settings
"set statusline=%f\ %h%w%m%r\ 
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"set statusline+=%=%(%l,%c%V\ %=\ %P%)
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_rust_checkers = ['rustc']
