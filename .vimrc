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
Bundle 'kchmck/vim-coffee-script'

set rtp+=/usr/local/Cellar/go/1.1.1/misc/vim/

filetype indent plugin on
filetype plugin on

set incsearch ignorecase hlsearch

if $COLOR_THEME == "Solarized Dark"
	set background=dark
	highlight ColorColumn ctermbg=darkblue
else
	set background=light
	highlight ColorColumn ctermbg=lightgray
endif
let g:solarized_termtrans = 1
colorscheme solarized

set shiftwidth=2 tabstop=2

augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\<nl>\"|$
augroup END

autocmd BufNewFile *.factor 0put=\"! Copyright (C) 2013 Guillermo Alcantara\<nl>! See http://factorcode.org/license.txt for BSD license.\<nl>USING:  ;\<nl>IN: \"|$

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2
let g:syntastic_python_pylint_args='-d C0103 -d R0914 -f parseable -r n -i y'
let g:ctrlp_custom_ignore = { 'dir': '\.git$', 'file': '\.pyc$' }
let g:jedi#use_tabs_not_buffers = 0

set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<
set bs=2 "Normal backspace mode

let &colorcolumn="81"
