syntax on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'git://github.com/kien/ctrlp.vim.git'
Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
" Bundle 'git://github.com/scrooloose/nerdtree.git'
" Bundle 'eipipuz/factor.vim'
Bundle 'fholgado/vim-autoclose'
Bundle 'davidhalter/jedi-vim'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'wting/rust.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-bufferline'

set rtp+=/usr/local/Cellar/go/1.1.1/misc/vim/

filetype indent plugin on
filetype plugin on

set incsearch ignorecase hlsearch relativenumber

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

set expandtab
set softtabstop=2

autocmd FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4
autocmd FileType javascript set tabstop=2|set shiftwidth=2

let g:ctrlp_custom_ignore = { 'dir': '\.git$', 'file': '\.pyc$' }
let g:jedi#use_tabs_not_buffers = 0

set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<
" Normal backspace mode
set bs=2
" Draws a line on position 101 as a reminder of long lines
let &colorcolumn="101"
" Makes airline be always visible
set laststatus=2
" Prevents duplicating the buffer list in the command line and airline
let g:bufferline_echo = 0
" Fancy symbols for airline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_section_x = 0
let g:airline_section_y = 0
let g:airline_theme = 'base16'
