set nocompatible
set t_Co=256
set hidden

" Plugins
call plug#begin('~/.vim/plugged')
" to use LaTex on vim
Plug 'lervag/vimtex' 
" to auto complete brackets
Plug 'jiangmiao/auto-pairs'
" to search files
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
" color scheme
Plug 'junegunn/seoul256.vim'
" distraction-free mode
Plug 'junegunn/goyo.vim'
" hyperfocus-writing mode
Plug 'junegunn/limelight.vim'
" Vim wiki
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
" Vim startify
Plug 'mhinz/vim-startify'
call plug#end()

" Syntax color on
syntax on
" Enables syntax highlighting and changes colorscheme
set background=dark
" Color theme for vim
colorscheme seoul256
" Enable mouse usage
set mouse=a
" Set tabs
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" Enable line number and relative line number
set relativenumber number
" Encoding type
set encoding=utf-8
" Enable highlight search
set hlsearch
"Use auto indentation
set autoindent
" A color line column
set colorcolumn=72

" Autopair
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsshortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" Vimwiki setting
let g:vimwiki_list = [
\]
let g:vimwiki_conceallevel = 0
" To not recognize other markdown files as vimwiki files
let g:vimwiki_global_ext = 0

" Vimtex setting
let g:tex_flavor='latex'
let g:vimtex_view_mode='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'

" vim-startify setting
let g:startify_bookmarks = [
\]

" Setup grepprg so :grep uses ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Map keys to use fzf and Rg faster
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <esc><esc> :noh<return><esc>

" Set leader prefix for mapping
let mapleader = ','
" Set local leader prefix for mapping
let maplocalleader = '\'
" Delete the current line, then paste it below the one we're on now
nnoremap <Leader> ddp
" Delete the current line, then paste it above the one we're on now
nnoremap _ ddkP
" Convert the current word to uppercase when you're in insert mode
inoremap <c-u> <esc>viwU
" Uppercase the current word in normal mode
nnoremap <c-u> viwU
" Open vimrc file in a vertical split for quick editing
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" Source vimrc file
nnoremap <Leader>sv :source $MYVIMRC<cr>
" Surround current word with double quotes
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" Surround current word with single quotes
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
" Go to the beginning of the current line
nnoremap H 0
" Go to the end of the current line
nnoremap L $
" Exit insert mode
inoremap jk <esc>

