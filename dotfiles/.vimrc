if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'godlygeek/tabular'
Plug 'keith/swift.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-OnSyntaxChange'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer' }
Plug 'scrooloose/nerdtree'
"Plug 'racer-rust/vim-racer'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/vim-hug-neovim-rpc'
  "Plug 'roxma/nvim-yarp'
endif
"Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
"Plug 'sebastianmarkow/deoplete-rust'
"Plug 'zchee/deoplete-jedi'
"Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'gfontenot/vim-xcode'
Plug 'mitsuse/autocomplete-swift'
Plug 'tmandry/vim-one'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'bkad/CamelCaseMotion'
Plug 'chaoren/vim-wordmotion'
Plug 'jremmen/vim-ripgrep'
if !has('nvim')
  Plug 'drmikehenry/vim-fixkey'
endif
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

call plug#end()

let g:plug_window = "new"

" Use VIM settings, rather than Vi settings
set nocompatible
"filetype on " Prevent an error exit code if filetype is off already
"filetype off

" Define global vars used below
let g:session_persist_globals = []

if !empty(glob('~/.vim/config/local.vim'))
  source ~/.vim/config/local.vim
endif

" Turn on filetype based plugins
filetype plugin indent on

" Always show the status line
set laststatus=2

set encoding=utf-8

set ttyfast

set history=1000

" Prevent unwanted characters being inserted when a key is pressed quickly
" after pressing Esc.
set ttimeoutlen=0

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
set undodir=~/.vim/backup
set directory=~/.vim/tmp

" Keep at least 5 lines around whever I'm scrolling
set scrolloff=5
set sidescrolloff=5

" Make backspace work on everything, everywhere
set backspace=indent,eol,start

" Enable mouse
set mouse=a
if has('mouse_sgr')
  set ttymouse=sgr
endif

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

" Move , functionality to ,;
noremap <leader>; ,

" Replace all occurrences of a word
nnoremap <leader>e :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
vnoremap <leader>R "hy:%s/<C-r>h/<C-r>h/gc<Left><Left><Left>

" Make it easier to clear search results
noremap <leader><space> :noh<cr>

" Make it easier to move around
noremap H ^
noremap L g_

" CamelCaseMotion (and snake case!)
"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e
"map <silent> ge <Plug>CamelCaseMotion_ge
"sunmap w
"sunmap b
"sunmap e
"sunmap ge
"omap <silent> iw <Plug>CamelCaseMotion_iw
"xmap <silent> iw <Plug>CamelCaseMotion_iw
"omap <silent> ib <Plug>CamelCaseMotion_ib
"xmap <silent> ib <Plug>CamelCaseMotion_ib
"omap <silent> ie <Plug>CamelCaseMotion_ie
"xmap <silent> ie <Plug>CamelCaseMotion_ie

" Make cw and dw act like vanilla vim
nmap dw de
nmap cw ce

map <silent> <leader>w <S-Right>
map <silent> <leader>b <S-Left>
omap <silent> <leader>w <S-Right>
omap <silent> <leader>b <S-Left>
xmap <silent> <leader>w <S-Right>
xmap <silent> <leader>b <S-Left>

" Alt-i/o inserts blank line below/above.
noremap <silent><A-i> :set paste<CR>m`o<Esc>``:set nopaste<CR>
noremap <silent><A-o> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent><A-e> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-q> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" Set space to toggle folds
nnoremap <leader><Tab> :set foldmethod=syntax<CR>
nnoremap <Space> za
vnoremap <Space> za

" Have searches center the line the word is found on
map N Nzz
map n nzz

" Make block stay highlighted when changing indentation
vnoremap > >gv
vnoremap < <gv

" Bind NERDTree commands
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
"map <C-c> <Leader>ci

" Work better with splits
"Removed in favor of vim-tmux-navigator
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l
"noremap <C-h> <C-w>h
noremap <C-'> <C-w><C-p>
if has('nvim')
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-;> <C-\><C-n><C-w>l
  tnoremap <C-'> <C-\><C-n><C-w><C-p>
elseif has('terminal')
  " TODO: Put <C-q> in a variable somehow
  tnoremap <C-h> <C-q>h
  tnoremap <C-j> <C-q>j
  tnoremap <C-k> <C-q>k
  tnoremap <C-;> <C-q>l
  tnoremap <C-'> <C-\><C-n><C-p>

  tnoremap <C-q>p <C-q>""

  if exists('&termwinkey')
    set termwinkey=<C-q>
  elseif exists('&termkey')
    set termkey=<C-q>
  endif
endif
set splitright
set splitbelow
set noequalalways
set fillchars+=vert:│

" Terminal
augroup terminal
  autocmd!

  if has('nvim')
    " Automatically go into terminal mode when enterint terminal.
    autocmd BufWinEnter,WinEnter term://* startinsert | set mouse=vchi | sleep 100m | set mouse=a
    autocmd BufLeave term://* stopinsert | set mouse=a

    autocmd BufWinEnter,WinEnter !* feedkeys('i') | set mouse=vchi | sleep 100m | set mouse=a
    autocmd BufLeave !* stopinsert | set mouse=a

    autocmd TermOpen * setlocal statusline=%{b:term_title} nonumber norelativenumber
  elseif has('terminal')
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | call VimTerminalEntered() | endif

    if exists('##TerminalOpen')
      autocmd TerminalOpen * call VimTerminalCreated()
    else
      autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | call VimTerminalCreated() | endif
    endif

    " Note: This might be called more than once for a terminal.
    function! VimTerminalCreated()
      setlocal nonumber norelativenumber
      if exists('*term_setkill')
        call term_setkill('', 'term')
      endif
    endfunction

    function! VimTerminalEntered()
      if v:version >= 810
        try
          normal! i
        catch /E21/ " Cannot make changes, 'modifiable' is off
          " Still seems to work even when it throws this error.
        catch /E490/ " No fold found
          " I don't know why this error occurs, but we don't want it.
          " Seems to be fixed in Vim 8.1.
        endtry
      endif
    endfunction
  endif
augroup END
if has('nvim') || has('terminal')
  tnoremap <C-\><C-v> <C-\><C-n>pi
endif

let g:terminal_ansi_colors = [
            \ "#373c40", "#ff5454", "#8cc85f", "#e3c78a",
            \ "#80a0ff", "#ce76e8", "#7ee0ce", "#de935f",
            \ "#f09479", "#f74782", "#42cf89", "#cfcfb0",
            \ "#78c2ff", "#ae81ff", "#85dc85", "#e2637f"
            \]

command! BT call BottomTerminal()
function! BottomTerminal()
  execute 'bot 40sp'
  execute 'terminal fish'
  set winfixheight
endfunction

" Window yank, paste
function! HOpen(dir,what_to_open)
  let [type,name] = a:what_to_open

  if a:dir=='left' || a:dir=='right'
      vsplit
  elseif a:dir=='up' || a:dir=='down'
      split
  end

  if a:dir=='down' || a:dir=='right'
      exec "normal! \<c-w>\<c-w>"
  end

  if type=='buffer'
      exec 'buffer '.name
  else
      exec 'edit '.name
  end
endfunction

function! HYankWindow()
  let g:window = winnr()
  let g:buffer = bufnr('%')
  let g:bufhidden = &bufhidden
endfunction

function! HDeleteWindow()
  call HYankWindow()
  set bufhidden=hide
  close
endfunction

function! HPasteWindow(direction)
  let old_buffer = bufnr('%')
  call HOpen(a:direction,['buffer',g:buffer])
  let g:buffer = old_buffer
  let &bufhidden = g:bufhidden
endfunction

noremap <c-w>d :call HDeleteWindow()<cr>
noremap <c-w>y :call HYankWindow()<cr>
" These directions don't always seem to work, just use 'here' for now
noremap <c-w>p :call HPasteWindow('here')<cr>
"noremap <c-w>pk :call HPasteWindow('up')<cr>
"noremap <c-w>pj :call HPasteWindow('down')<cr>
"noremap <c-w>ph :call HPasteWindow('left')<cr>
"noremap <c-w>pl :call HPasteWindow('right')<cr>
"noremap <c-w>pp :call HPasteWindow('here')<cr>

" Resize window splits
" TODO Fix mousewheel
nnoremap <Up>    3<C-w>-
nnoremap <Down>  3<C-w>+
nnoremap <Left>  3<C-w><
nnoremap <Right> 3<C-w>>

nnoremap <C-Up>    3<C-w>-
nnoremap <C-Down>  3<C-w>+
nnoremap <C-Left>  3<C-w><
nnoremap <C-Right> 3<C-w>>
tnoremap <C-Up>    <C-\><C-n>3<C-w>-i
tnoremap <C-Down>  <C-\><C-n>3<C-w>+i
tnoremap <C-Left>  <C-\><C-n>3<C-w><i
tnoremap <C-Right> <C-\><C-n>3<C-w>>i

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

" C-t for new tab
map <C-t> :tabnew<CR>

" Make j/k work as expected with wrapped lines
if !exists('g:actualvim')
  map j gj
  map k gk
endif

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

" CtrlP
" Disable switching buffers when opening files.
let g:ctrlp_switch_buffer = '0'
let g:ctrlp_user_command = ['.git', 'cd %s; and git ls-files -co --exclude-standard']

" FZF: Don't open files in NERDTree buffer.
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

nnoremap <silent> <C-p> :call FZFOpen(':GFiles --cached --others --exclude-standard')<CR>
nnoremap <silent> <C-f> :call FZFOpen(':BTags')<CR>
nnoremap <silent> <C-g> :call FZFOpen(':Tags')<CR>

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
if &term == "screen-256color" || &term == "tmux-256color"
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
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gx :Gremove<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gg :Ggrep<cr>

nnoremap <silent> <leader>gu :GitGutterToggle<cr>

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

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab expandtab

" Have it keep changes to open buffers without saving to the files
set hidden

" Setup OmniComplete to be context aware
let g:SuperTabDefaultCompletionType="context"

" Prevents Vim 7.0 from setting filetype to 'plaintex'
let g:tex_flavor='latex'

" Ignore silly files
set wildignore=*.o,*.obj,*.bak,*.exe,*.hi,*.6

" Enable 24-bit color
if (has("termguicolors"))
  set termguicolors
endif

" Set colorscheme
"let g:one_allow_italics = 1
set background=dark
set guifont=Inconsolata-g\ for\ Powerline\ Bold\ 8
augroup override_colors
  autocmd!
  " Hide all the ~ characters past end of file.
  autocmd ColorScheme * highlight EndOfBuffer ctermfg=bg guifg=bg
augroup END

" Apply colorscheme only if it hasn't been applied already, to prevent it from
" overriding plugin highlight groups. unlet g:colorscheme_applied to change
" the colorscheme.
if !exists('g:colorscheme_applied')
  let g:colorscheme_applied = 1
  colorscheme one
endif

" Better esc behavior with multiple-cursors.
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" Force vim to use 256 colors
set t_Co=256

augroup highlight_current_line
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" Move around tabs and buffers
nnoremap ]t gt
nnoremap [t gT
" tell vim-unimpaired not to remap us
let g:nremap = {'[t': '', ']t': '', '[b': '', ']b': ''}
"nnoremap [b :bprevious<CR>
"nnoremap ]b :bnext<CR>

" Move around in command line (doesn't work..)
"cmap <M-b> <S-Left>
"cmap <M-f> <S-Right>

" Mark trailing whitespace
set listchars=tab:\ \ ,trail:\ ,extends:»,precedes:«
if &background == "dark"
  highlight ExtraWhitespace ctermbg=Red guibg=Red
else
  highlight ExtraWhitespace ctermbg=Yellow guibg=Yellow
end
match ExtraWhitespace /\s\+$/
augroup match_extra_whitespace
  autocmd!
  autocmd BufWinEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &buftype != 'terminal' | match ExtraWhitespace /\s\+$/ | endif
  " Counteract constant memory alloc by BufWinEnter by clearing matches on
  " BufWinLeave.
  autocmd BufWinLeave * call clearmatches()

  " Apparently Vim 8.1 doesn't set buftype to terminal on initial BufWinEnter.
  if !has('nvim') && has('terminal')
    if exists('##TerminalOpen')
      autocmd TerminalOpen * call clearmatches()
    else
      autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | call clearmatches() | endif
    endif
  endif
augroup END

" Remove the toolbar if it's macvim or gvim
if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
endif

augroup file_types
  autocmd!

  " Setup the filetype for markdown
  au BufNewFile,BufRead *.md set filetype=markdown

  " Set indentention for Make files
  au Filetype make set noexpandtab

  " Set settings for LaTeX files
  au Filetype tex SPCheck
  au Filetype tex let dialect='US'
augroup END

" Mark.vim settings
let g:mwDefaultHighlightingPalette = 'extended'
nmap <leader>N <Plug>MarkToggle
nmap <leader>M <Plug>MarkConfirmAllClear
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
nmap [m <Plug>MarkSearchCurrentPrev
nmap ]m <Plug>MarkSearchCurrentNext
nmap ]M <Plug>MarkSearchUsedGroupNext
nmap [M <Plug>MarkSearchUsedGroupPrev
nmap <leader>1 <Plug>MarkSearchGroup1Next
nmap <leader>2 <Plug>MarkSearchGroup2Next
nmap <leader>3 <Plug>MarkSearchGroup3Next
nmap <leader>4 <Plug>MarkSearchGroup4Next
nmap <leader>5 <Plug>MarkSearchGroup5Next
nmap <leader>6 <Plug>MarkSearchGroup6Next
nmap <leader>7 <Plug>MarkSearchGroup7Next
nmap <leader>8 <Plug>MarkSearchGroup8Next
nmap <leader>9 <Plug>MarkSearchGroup9Next
nmap <leader>! <Plug>MarkSearchGroup1Prev
nmap <leader>@ <Plug>MarkSearchGroup2Next
nmap <leader># <Plug>MarkSearchGroup3Next
nmap <leader>$ <Plug>MarkSearchGroup4Next
nmap <leader>% <Plug>MarkSearchGroup5Next
nmap <leader>^ <Plug>MarkSearchGroup6Next
nmap <leader>& <Plug>MarkSearchGroup7Next
nmap <leader>* <Plug>MarkSearchGroup8Next
nmap <leader>( <Plug>MarkSearchGroup9Next
let g:session_persist_globals += ['g:MARK_MARKS']

" Racer settings
set hidden
let g:racer_cmd=$HOME."/.cargo/bin/racer"
if executable("rustc")
  let $RUST_SRC_PATH=systemlist("rustc --print sysroot")[0]."/lib/rustlib/src/rust/src"
endif
let g:racer_experimental_completer=1

" rust.vim settings
"let g:rustfmt_autosave = 1

augroup rust_misc
  autocmd!
  autocmd BufNewFile,BufRead *.mir set filetype=rust
augroup END

" Different textwidth for Rust comments vs code
" (can be done for all languages.. change rustComment -> Comment)
call OnSyntaxChange#Install('RustComment', 'rustComment', 0, 'a')
augroup rust_textwidth
  autocmd!
  autocmd User SyntaxRustCommentEnterA setlocal tw=80
  autocmd User SyntaxRustCommentLeaveA setlocal tw=100
  autocmd FileType rust setlocal colorcolumn=81,101 comments^=:///
augroup END

"let g:ale_linters = {'rust': ['rls']}
let g:ale_linters = {'rust': ['cargo']}

" deoplete settings
"call deoplete#enable()

" deoplete-rust settings
let g:deoplete#sources#rust#racer_binary="/Users/tyler/.cargo/bin/racer"
let g:deoplete#sources#rust#rust_source_path="/Users/tyler/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
nmap <buffer> gs <plug>DeopleteRustGoToDefinitionSplit
nmap <buffer> gv <plug>DeopleteRustGoToDefinitionVSplit
nmap <buffer> gb <plug>DeopleteRustGoToDefinitionTab

let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/local/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" ctags settings
augroup rust_ctags
  autocmd!
  autocmd BufRead *.rs :setlocal tags=./TAGS;/,$RUST_SRC_PATH/TAGS
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet 2>/dev/null &"
augroup END

augroup rust_make
  autocmd!
  "autocmd BufRead *.rs :setlocal makeprg=cargo\ check

  " Automatically open, but do not go to (if there are errors) the quickfix /
  " location list window, or close it when is has become empty.
  "
  " Note: Must allow nesting of autocmds to enable any customizations for quickfix
  " buffers.
  " Note: Normally, :cwindow jumps to the quickfix window if the command opens it
  " (but not if it's already open). However, as part of the autocmd, this doesn't
  " seem to happen.
  autocmd QuickFixCmdPost [^l]* nested botright cwindow
  autocmd QuickFixCmdPost    ]* nested botright lwindow
augroup END
nnoremap <leader>j :Make<CR>

" Disable Deoplete when selecting multiple cursors starts
function! Multiple_cursors_before()
    if exists('*deoplete#disable')
        exe 'call deoplete#disable()'
    elseif exists(':NeoCompleteLock') == 2
        exe 'NeoCompleteLock'
    endif
endfunction

" Enable Deoplete when selecting multiple cursors ends
function! Multiple_cursors_after()
    if exists('*deoplete#enable')
        exe 'call deoplete#enable()'
    elseif exists(':NeoCompleteUnlock') == 2
        exe 'NeoCompleteUnlock'
    endif
endfunction

" vim-session settings
let g:session_autosave='no'
let g:session_autoload='no'
let g:session_periodic_autosave=2
command! -bar -bang -nargs=? -complete=customlist,xolox#session#complete_names OpenSess call xolox#session#open_cmd(<q-args>, <q-bang>, 'OpenSession') | silent MarkLoad

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
let g:syntastic_python_checkers = ['python']
let g:syntasic_cpp_compiler_options = '-std=c++14'

""" Swift

" Jump to the first placeholder by typing `<C-k>`.
augroup swift
  autocmd!
  autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
  autocmd BufNewFile,BufRead *.swift set filetype=swift
  autocmd FileType swift set sts=4 ts=4 sw=4 tw=100 colorcolumn=101 comments^=:/// fo+=2
augroup END

if !exists('g:xcrunwindows')
  let g:xcrunwindows = {}
endif

" Intended to fix a problem where '20sp' is not respected after a second
" :botright window... not actually working yet.
function! FixWindowSizes()
  let l:winid = win_getid()
  for win in keys(g:xcrunwindows)
    if win_gotoid(g:xcrunwindows[win])
      execute 'resize 20'
    endif
  endfor
  call win_gotoid(l:winid)
endfunction

function! GoToRunWindow(win)
  if has_key(g:xcrunwindows, a:win)
    if win_gotoid(g:xcrunwindows[a:win])
      return
    endif
  endif
  execute 'bot 20sp'
  set winfixheight
  "call FixWindowSizes()
  let g:xcrunwindows[a:win] = win_getid()
endfunction

function! CloseRunWindow(win)
  let l:winid = win_getid()
  if has_key(g:xcrunwindows, a:win)
    if win_gotoid(g:xcrunwindows[a:win])
      execute 'wincmd c'
    endif
  endif
  call win_gotoid(l:winid)
endfunction

function! RunInWindow(win, cmd)
  let l:winid = win_getid()
  call GoToRunWindow(a:win)
  execute a:cmd
  normal G
  call win_gotoid(l:winid)
endfunction

command! MyXrunCmd call MyXrun()
function! MyXrun()
  if exists('b:terminal_job_pid')
    echom "Killing " . b:terminal_job_pid
    echom system("kill " . b:terminal_job_pid)
  endif
  execute 'Xrun'
endfunction

command! -nargs=+ RunEscaped call DoRunEscaped(<f-args>)
function! DoRunEscaped(...)
  let cmd = substitute(join(a:000, '\ '), '"', '\\"', 'g')
  if has('nvim')
    let l:flags = ''
  else
    let l:flags = ' ++curwin'
  endif
  execute 'terminal' . flags . ' bash -c ' . cmd
endfunction

augroup xbuild
  "nnoremap <leader>b :Xbuild<CR>G
  autocmd!
  autocmd FileType swift nnoremap <buffer><silent> <leader>B :silent call RunInWindow('build', 'Xbuild')<CR>
  autocmd FileType swift nnoremap <buffer><silent> <leader>T :silent call RunInWindow('build', 'Xtest')<CR>
  autocmd FileType swift nnoremap <buffer>         <leader>s :Xscheme
  autocmd FileType swift nnoremap <buffer><silent> <leader>C :silent call RunInWindow('build', 'Xclean')<CR>
  autocmd FileType swift nnoremap <buffer><silent> <leader>c :silent call CloseRunWindow('build') \| call CloseRunWindow('run')<CR>
  autocmd FileType swift nnoremap <buffer><silent> <leader>N :silent call RunInWindow('run', 'MyXrunCmd')<CR>
augroup END
let g:xcode_runner_command = "RunEscaped {cmd}"

""" Airline

let g:airline_powerline_fonts = 1
" Clean up the position information (removed total # lines; use %L to get back)
let g:airline_section_z = "%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#:%-3v (%3p%%)"
let g:airline_skip_empty_sections = 1

" Builds an airline statusline with vimtabs fragment at the end.
function! AirlineTabsBuilder(...)
  let builder = a:1

  " Call the core builder functions first, then apply our change.
  " This may break in the future.
  " Function names taken from https://bit.ly/2U0poe4
  if 0 == call(function('airline#extensions#apply'), a:000)
    call call(function('airline#extensions#default#apply'), a:000)
  endif

  call builder.add_section('Tabs', wintabs#ui#get_vimtabs_fragment())

  return 1
endfunction

function! AirlineInit()
  call airline#parts#define_function('xcscheme', 'g:xcode#scheme')
  call airline#parts#define_condition('xcscheme', '&filetype =~ "swift"')
  " Remove fileencoding, fileformat and replace with xcscheme.
  let g:airline_section_y = airline#section#create(['xcscheme'])

  call airline#add_statusline_func('AirlineTabsBuilder')
endfunction
augroup airline_init
  autocmd!
  autocmd VimEnter * call AirlineInit()
augroup END

augroup airline_events
  autocmd!
  autocmd FileType vim let b:airline_whitespace_checks = ['indent', 'mixed-indent-file']
augroup END

""" Wintabs

let g:wintabs_display = 'statusline'
let g:airline_statusline_ontop = 1
map <A-H> <silent>:WintabsPrevious<CR>
map <A-L> <silent>:WintabsNext<CR>
map [b <Plug>(wintabs_previous)
map ]b <Plug>(wintabs_next)
map ,c <Plug>(wintabs_close)
map <silent> gb :<C-U>call WintabGoBuf(v:count)<CR>
map gB [b

function! WintabGoBuf(count)
  if a:count == 0
    WintabsNext
  else
    exec 'WintabsGo ' . a:count
  endif
endfunction

let g:wintabs_ui_vimtab_name_format = '%n %t'

" In buffer line show tail dir/filename
function! s:custom_buf_label(bufnr, config)
  let path = bufname(a:bufnr)
  let name = fnamemodify(path, ':p:h:t')
  if !empty(name)
    let name = name . '/'
  endif
  let name = name . fnamemodify(path, ':t')
  if getbufvar(a:bufnr, '&modified')
    let name = name . '[+]'
  endif
  let name = ' ' . a:config.ordinal . ' ' . name . ' '
  return name
endfunction
function! s:wintabs_custom_buffer(bufnr, config)
  " Copied from wintabs-powerline source since we can't just override buf_label.
  let label = s:custom_buf_label(a:bufnr, a:config)
  let highlight = a:config.is_active ? 'WintabsActive' : 'WintabsInactive'
  let highlight = s:maybe_nc(highlight, a:config)
  return { 'label': label, 'highlight': highlight }
endfunction
function! s:maybe_nc(higroup, config)
  let is_nc = has_key(a:config, 'is_active_window') && !a:config.is_active_window
  let higroup = is_nc ? a:higroup.'NC' : a:higroup
  return higroup
endfunction
augroup wintabs_init
  autocmd!
  autocmd VimEnter * let g:wintabs_renderers.buffer = function('s:wintabs_custom_buffer')
augroup END

""" Gundo

let g:gundo_prefer_python3 = 1
let g:gundo_right = 1
nnoremap <F9> :GundoToggle<CR>

""" Outline

function! s:outline_format(lists)
  for list in a:lists
    let linenr = list[2][:len(list[2])-3]
    let line = getline(linenr)
    let idx = stridx(line, list[0])
    let len = len(list[0])
    let fg = synIDattr(synIDtrans(hlID("LineNr")), 'fg', 'cterm')
    let bg = synIDattr(synIDtrans(hlID("LineNr")), 'bg', 'cterm')
    let list[0] = ''
          \ . printf("\x1b[%sm %4d \x1b[m ", '38;5;'.fg.';48;5;'.bg, linenr)
          \ . line[:idx-1]
          \ . printf("\x1b[%sm%s\x1b[m", "34", line[idx:idx+len-1])
          \ . line[idx+len:]
    let list = list[:2]
  endfor
  return a:lists
endfunction
function! s:outline_source(tag_cmds)
  if !filereadable(expand('%'))
    throw 'Save the file first'
  endif
  for cmd in a:tag_cmds
    let lines = split(system(cmd), "\n")
    if !v:shell_error
      break
    endif
  endfor
  if v:shell_error
    throw get(lines, 0, 'Failed to extract tags')
  elseif empty(lines)
    throw 'No tags found'
  endif
  return map(s:outline_format(map(lines, 'split(v:val, "\t")')), 'join(v:val, "\t")')
endfunction
function! s:outline_sink(lines)
  if !empty(a:lines)
    let line = a:lines[0]
    execute split(line, "\t")[2]
  endif
endfunction
function! s:outline(...)
  let args = copy(a:000)
  let tag_cmds = [
    \ printf('ctags -f - --sort=no --excmd=number --language-force=%s %s 2>/dev/null', &filetype, expand('%:S')),
    \ printf('ctags -f - --sort=no --excmd=number %s 2>/dev/null', expand('%:S'))]
  try
    return fzf#run(fzf#wrap('outline', {
      \ 'source':  s:outline_source(tag_cmds),
      \ 'sink*':   function('s:outline_sink'),
      \ 'options': '--tiebreak=index --reverse +m -d "\t" --with-nth=1 -n 1 --ansi --extended --prompt "Outline> "'}))
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction
command! -bang Outline call s:outline()
nnoremap <silent> <space>o :Outline<CR>

""" CoC

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader><leader>r <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of
" languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
vmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>g  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
