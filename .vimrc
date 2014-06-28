set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kovisoft/slimv'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vividchalk'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Plugin 'nsf/gocode', {'rtp': 'vim/'}

filetype plugin indent on

colorscheme vividchalk
set wrap
set number
set laststatus=2
set noshowmode
set textwidth=0 wrapmargin=0
set tabstop=2
set shiftwidth=2
set scrolloff=5
set mouse=a
syntax enable

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeMirror<CR>

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

au BufNewFile,BufRead *.asd set filetype=lisp
