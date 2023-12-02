" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Add your bundles here

" Syntax checking
Bundle 'Syntastic'
" Git
Bundle 'https://github.com/tpope/vim-fugitive'
" Ctags-powered outline
Bundle 'Tagbar'
Bundle 'Mark'
" Fuzzy file opening
Bundle 'kien/ctrlp.vim'
" Align things
Bundle 'Tabular'
" Surround things with quotes, parens, etc.
Bundle 'tpope/vim-surround'
" Multiple cursors
Bundle 'terryma/vim-multiple-cursors'

" Syntax highlighting
Bundle 'https://github.com/peterhoeg/vim-qml.git'
Bundle 'derekwyatt/vim-scala'

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
