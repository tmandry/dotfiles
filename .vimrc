if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'godlygeek/tabular'
Plug 'keith/swift.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
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
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'roxma/nvim-yarp'
endif
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'zchee/deoplete-jedi'
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
Plug 'bkad/CamelCaseMotion'
if !has('nvim')
  Plug 'drmikehenry/vim-fixkey'
endif

Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

call plug#end()

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
nnoremap <leader>e :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>R :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
vnoremap <leader>R "hy:%s/<C-r>h/<C-r>h/gc<Left><Left><Left>

" Make it easier to clear search results
noremap <leader><space> :noh<cr>

" Make it easier to move around
noremap H ^
noremap L g_

" CamelCaseMotion (and snake case!)
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

map <silent> <leader>w <S-Right>
map <silent> <leader>b <S-Left>
omap <silent> <leader>w <S-Right>
omap <silent> <leader>b <S-Left>
xmap <silent> <leader>w <S-Right>
xmap <silent> <leader>b <S-Left>

" Alt-i/o inserts blank line below/above.
nnoremap <silent><A-i> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-o> :set paste<CR>m`O<Esc>``:set nopaste<CR>
"nnoremap <silent><A-e> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
"nnoremap <silent><A-q> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

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
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
"map <C-c> <Leader>ci

" Work better with splits
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
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

" Enable 24-bit color
if (has("termguicolors"))
  set termguicolors
endif

" Set colorscheme
"let g:one_allow_italics = 1
set background=dark
set guifont=Inconsolata\ Go\ 11
colorscheme one

" Don't let colorscheme clear vim-multiple-cursors highlight groups when
" re-sourcing vimrc
" I wish there was a more elegant way to fix this.
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link mulitple_cursors_visual Visual

" Better esc behavior with multiple-cursors.
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" Force vim to use 256 colors
set t_Co=256

" Move around tabs and buffers
nnoremap ]t gt
nnoremap [t gT
let g:nremap = {'[t': '', ']t': ''} " tell vim-unimpaired not to remap us
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

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
let g:racer_cmd="/Users/tyler/.cargo/bin/racer"
let $RUST_SRC_PATH="/Users/tyler/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
let g:racer_experimental_completer=1

" rust.vim settings
let g:rustfmt_autosave = 1

" Different textwidth for Rust comments vs code
" (can be done for all languages.. change rustComment -> Comment)
call OnSyntaxChange#Install('RustComment', 'rustComment', 0, 'a')
augroup rust_textwidth
  autocmd!
  autocmd User SyntaxRustCommentEnterA setlocal tw=80
  autocmd User SyntaxRustCommentLeaveA setlocal tw=100
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

" ctags settings
augroup rust_ctags
  autocmd!
  autocmd BufRead *.rs :setlocal tags=./TAGS;/,$RUST_SRC_PATH/TAGS
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
augroup END

augroup rust_make
  autocmd!
  autocmd BufRead *.rs :setlocal makeprg=cargo\ check

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
let g:session_autosave='yes'
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
  let g:airline_section_y = airline#section#create(['xcscheme'])

  call airline#add_statusline_func('AirlineTabsBuilder')
endfunction
augroup airline_init
  autocmd!
  autocmd VimEnter * call AirlineInit()
augroup END

""" Wintabs

let g:wintabs_display = 'statusline'
let g:airline_statusline_ontop = 1
map <A-H> <silent>:WintabsPrevious<CR>
map <A-L> <silent>:WintabsNext<CR>
map [b <Plug>(wintabs_previous)
map ]b <Plug>(wintabs_next)
map ,c <Plug>(wintabs_close)

let g:wintabs_ui_vimtab_name_format = '%n %t'
