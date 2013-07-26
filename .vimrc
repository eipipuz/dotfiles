syntax on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'git://github.com/kien/ctrlp.vim.git'
Bundle 'gmarik/vundle'
Bundle 'Syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'eipipuz/factor.vim'
Bundle 'fholgado/vim-autoclose'
Bundle 'davidhalter/jedi-vim'

set rtp+=/usr/local/Cellar/go/1.1.1/misc/vim/

filetype indent plugin on
filetype plugin on

set incsearch ignorecase hlsearch

if $COLOR_THEME == "Solarized Dark"
	set background=dark
	highlight OverLength ctermbg=darkblue
else
	set background=light
	highlight OverLength ctermbg=lightgray
endif
colorscheme solarized

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\<nl>\"|$
augroup END

autocmd BufNewFile *.factor 0put=\"! Copyright (C) 2013 Guillermo Alcantara\<nl>! See http://factorcode.org/license.txt for BSD license.\<nl>USING:  ;\<nl>IN: \"|$

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
let g:syntastic_python_pylint_args='-d C0103 -d R0914 -f parseable -r n -i y'
let g:ctrlp_custom_ignore = { 'dir': '\.git$', 'file': '\.pyc$' }
let g:jedi#use_tabs_not_buffers = 0

set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<

match OverLength /\%81v.\+/
