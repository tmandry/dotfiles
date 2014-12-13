" Use VIM settings, rather than Vi settings
set nocompatible
filetype on " Prevent an error exit code if filetype is off already
filetype off

set shell=/bin/bash

source ~/.vim/vundle.vim

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

" Set visual bell rather than audible bell
set vb

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

" Make it easier to clear search results
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Make it easier to move around
noremap H ^
noremap L g_

" Ctrl-j/k inserts blank line below/above, and Alt-j/k deletes.
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent><A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" Set space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Have searches center the line the word is found on
map N Nzz
map n nzz

" Make block stay highlighted when changing indentation
vnoremap > >gv
vnoremap < <gv

" Bind eclim commands
"map <F2> :ProjectsTree<CR>

" Bind NERDTree commands
map <F2> :NERDTreeToggle<CR>
map <C-c> <Leader>ci

" Work better with splits
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
map <A-h> <C-w>h

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
command Wq wq
command WQ wq
command W w
command Q q
nnoremap W :w<cr>

" Make it easier to go to the last buffer
nnoremap <leader>b :b#<CR>

" Toggle ctags
nmap <F8> :TagbarToggle<CR>

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
"
"    " Set font
"    set gfn=Inconsolata:h14
"
"  else
"    " Linux specific bindings
"
"    " Set font
"    set gfn=Inconsolata\ 12
"
"    "Bind copy and paste to Ctrl-Shift-C/V
"    vnoremap <C-C> "+y
"    nnoremap <C-C> "+yy
"    noremap <C-V> "+p
"    imap <C-V> <Esc><C-V>a
"    cnoremap <C-V> <C-R>+
"    cnoremap <C-V> <C-R>+
"
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

vnoremap <leader>t :Tabularize /

" Set Powerline to use unicode rather than compatible
let g:Powerline_symbols="unicode"

" Turn off syntastics syntax highlighting and signs
"let g:syntastic_enable_highlighting = 0
"let g:syntastic_enable_signs = 0

"augroup ft_fugitive
"    au!
"
"    au BufNewFile,BufRead .git/index setlocal nolist
"augroup END

" Set indentation functions
function! AudiaTabs()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set smarttab noexpandtab
endfunction

function! GoogleTabs()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set smarttab expandtab
endfunction

command! Goog call GoogleTabs()
command! Audia call AudiaTabs()

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
colorscheme koehler

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

" Setup django templating highlighting for all html
au BufNewFile,Bufread *.html set filetype=htmldjango tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Setup the filetype for markdown
au BufNewFile,BufRead *.md set filetype=markdown

" Set indentation for Python according to Google Style Guide
au FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79

" Set indentation for Haskell according to the snap style guide
au FileType haskell set tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=78

" Set indentation for Ruby according to Google Style Guide
au Filetype ruby set tabstop=2 shiftwidth=2 expandtab

" Set indentation for C according to Google Style Guide
au Filetype c set tabstop=2 shiftwidth=2 expandtab

" Set indentation for C++ according to Google Style Guide
au Filetype cpp set tabstop=2 shiftwidth=2 expandtab

" Set indentention for Make files
au Filetype make set noexpandtab

" Set indentation for HTML files
au Filetype html set tabstop=2 shiftwidth=2 expandtab
au FileType xhtml set tabstop=2 shiftwidth=2 expandtab

" Set settings for LaTeX files
au Filetype tex SPCheck
au Filetype tex let dialect='US'

" Set settings for XML files
au Filetype xml set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
