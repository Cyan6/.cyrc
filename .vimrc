set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
Bundle 'kovisoft/slimv'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vividchalk'

filetype plugin indent on     " required

colorscheme vividchalk
set wrap
set textwidth=0 wrapmargin=0
set tabstop=4
set number
set scrolloff=9000

function! TabComplete()
	if pumvisible()
		return "\<c-y>"
	endif
	let line = getline('.')

	let substr = strpart(line, -1, col('.')+1)

	let substr = matchstr(substr, "[^ \t]*$")
	if (strlen(substr)==0)
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1
	let has_slash = match(substr, '\/') != -1
	if (!has_period && !has_slash)
		return "\<c-x>\<c-p>"
	elseif ( has_slash)
		return "\<c-x>\<c-f>"
	else
		return "\<c-x>\<c-o>"
	endif
endfunction

function! AcpMeetsForLispOmni(context)
	return a:context =~ '\(\(\w\|-\|_\|\*\)\+\)\|\(:\(\w\|-\|_\|\*\)\{2,\}\)'
endfunction

function! AcpMeetsForLispLocal(context)
	return a:context =~ '\(:?\(\w\|-\|_\|\*\)\+\)'
endfunction

let g:acp_behavior = {
	\ 'lisp'   : [{
    \ "command": "\<c-x>\<c-p>",
	\ "meets"  : 'AcpMeetsForLispLocal',
	\ "repeat" : 0,
	\ }, {
	\ "command": "\<c-x>\<c-o>",
	\ 'meets'  : 'AcpMeetsForLispOmni',
	\ 'repeat' : 0,
	\ }]
	\ }

inoremap <expr> <tab> TabComplete()
