set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')
" to use LaTex on vim
Plug 'lervag/vimtex' 
let g:tex_flavor='latex'
let g:vimtex_view_mode='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" to auto complete brackets
Plug 'jiangmiao/auto-pairs'
call plug#end()

" Syntax color on
syntax on
" Enables syntax highlighting and changes colorscheme
set background=dark
" Color theme for vim
colorscheme gruvbox 
" Enable mouse usage
set mouse=a 
" Set tabs
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Enable line number
set number
" Encoding type
set encoding=utf-8
" Enable highlight search
set hlsearch
" Use auto indentation
set autoindent
" A color line column
set colorcolumn=72

" Autopair
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsshortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

