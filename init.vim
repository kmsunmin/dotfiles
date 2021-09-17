call plug#begin('~/.vim/plugged')
    " to search files 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
        Plug 'junegunn/fzf.vim'
    " color scheme
    Plug 'junegunn/seoul256.vim'
    " distraction free mode
    Plug 'junegunn/goyo.vim'
    " hyperfocus-writing mode
    Plug 'junegunn/limelight.vim'
    " Vimwiki
    Plug 'vimwiki/vimwiki', {'branch': 'dev'}
    " Vim startify
    Plug 'mhinz/vim-startify'
    " to display tags in a window
    Plug 'preservim/tagbar'
    " coc.nvim
    Plug 'neoclide/coc.nvim', {
        \'branch': 'release'
	\}
    " syntastic for status bar
    Plug 'vim-syntastic/syntastic'
    " file viewer
    Plug 'preservim/nerdtree'
    " auto pairing
    Plug 'jiangmiao/auto-pairs'
    " colorschemes
    Plug 'flazz/vim-colorschemes'
call plug#end()

" theme
syntax enable
filetype plugin indent on " Put your non-Plugin stuff after this line

" set ------------------------------------------------------------------
set conceallevel=0
set nocompatible " Use only functions from vim, not vi
set mouse=a
set hidden " Buffer should still exist if window is closed
set smartcase ignorecase hlsearch incsearch

" display
set nu              " line number
set ruler           " coordinate of current cursor position
set laststatus=2    " status bar always on
set cursorline      " highlight current line
set showmatch       " display matching brackets
set background=dark
colorscheme wombat

" no swp, backup files
set noswapfile
set nobackup

" usage
set bs=indent,eol,start " use backspace key
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set cindent autoindent smartindent
set history=200 undolevels=2000
set splitbelow
set splitright
set autoread

" initialize
" put cursor to where last modified
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line ("$") |
    \ exe "norm g`\"" |
    \ endif

" status line
" Syntastic setting
" https://thechefprogrammer.blogspot.kr/2014/05/syntax-check-for-php-and-javascript.html
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_auto_loc_list = 0

" set up grepprg so :grep uses ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" set leader prefix for mapping
let mapleader = ','

" Autopair
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" Vimwiki setting
let g:vimwiki_list = [
    \{ 
    \    'path': '~/Study/kmsunmin.github.io/_posts/',
    \    'syntax': 'markdown', 'ext': '.md',
    \}
\]
let g:vimwiki_conceallevel = 0
" To not recognize other markdown files as vimwiki files
let g:vimwiki_global_ext = 0

" vim-startify setting
let g:startify_bookmarks = [
    \{
    \'w': '~/Study/kmsunmin.github.io/_posts/'
    \},
    \{
\]

let g:startify_list_order = [
    \ [' Bookmarks'],
    \ 'bookmarks',
    \ ['  Most Recently Used Files'],
    \ 'files'
\]

" NERDTree mappings 
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" map keys to use fzf and Rg faster
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <esc><esc> :noh<return><esc>

" edit init.vim
nnoremap <Leader>ev :vsplit<space>~/.config/nvim/init.vim<CR>
" source init.vim
nnoremap <Leader>sv :source $MYVIMRC<CR>
