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
    Plug 'arcticicestudio/nord-vim'
    Plug 'NLKNguyen/papercolor-theme'
    " vim plugin for git
    Plug 'tpope/vim-fugitive'
    " copilot
    Plug 'github/copilot.vim'
    " airline
    Plug 'vim-airline/vim-airline'
    " comment things out
    Plug 'tpope/vim-commentary'
    " rainbow braces
    Plug 'luochen1990/rainbow'
        " Rainbow braces enabled
        let g:rainbow_active = 1
    " a class outline viewer
    Plug 'preservim/tagbar'
    " autogenerate tags
    Plug 'ludovicchabant/vim-gutentags'
    " status and tabline
    Plug 'vim-airline/vim-airline'
    " gherkin cucumber
    Plug 'Gee19/coc-cucumber', {'do': 'yarn install --frozen-lockfile'}
    " language packs
    Plug 'sheerun/vim-polyglot'
call plug#end()

function InstallCocPlugins()
    CocInstall coc-pyright
    CocInstall coc-eslint
    CocInstall coc-prettier
endfunction

" theme
syntax enable
filetype plugin indent on " Put your non-Plugin stuff after this line

" set ------------------------------------------------------------------
set conceallevel=0
set nocompatible " Use only functions from vim, not vi
set encoding=UTF-8
set mouse=a
set hidden " Buffer should still exist if window is closed
set smartcase ignorecase hlsearch incsearch
set noshowmode " hide mode since vim-airline covers it

" display
set nu              " line number
set ruler           " coordinate of current cursor position
set laststatus=2    " status bar always on
set cursorline      " highlight current line
set showmatch       " display matching brackets
set background=dark
colorscheme ayu

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

" automatically display all buffers when there is only one tab open
let g:airline#extensions#tabline#enabled = 1

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
\]
let g:vimwiki_conceallevel = 0
" To not recognize other markdown files as vimwiki files
let g:vimwiki_global_ext = 0

" To auto-generate templates for md files
" reference: JohnGrib's dotfiles
function! WikiNewTemplate()
    let l:wiki_directory = v:false
    for wiki in g:vimwiki_list
        if expand('%:p:h') =~ expand(wiki.path)
            let l:wiki_directory = v:true
            break
        endif
    endfor

    if !l:wiki_directory
        return
    endif

    if line("$") > 1
        return
    endif

    let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout    : post')
    call add(l:template, 'title     : ')
    call add(l:template, 'summary   : ')
    call add(l:template, 'date      : ' . strftime('%Y-%m-%d %H:%M:%S -0500'))
    call add(l:template, 'updated   : ' . strftime('%Y-%m-%d %H:%M:%S -0500'))
    call add(l:template, 'tags      : ')
    call add(l:template, 'toc       : true')
    call add(l:template, 'public    : true')
    call add(l:template, 'parent    : ')
    call add(l:template, 'daily     : ')
    call add(l:template, 'latex     : false')
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '## ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has been created'
endfunction

" register auto-generation of templates to autocmd so that
" the function gets called automatically
autocmd BufRead,BufNewFile *.md call WikiNewTemplate()

" vim-startify setting
let g:startify_bookmarks = [
\]

let g:startify_list_order = [
    \ [' Bookmarks'],
    \ 'bookmarks',
\]

" NERDTree mappings
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>

" map keys to use fzf and Rg faster
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <esc><esc> :noh<return><esc>

" edit init.vim
nnoremap <Leader>ev :vsplit<space>~/.config/nvim/init.vim<CR>
" source init.vim
nnoremap <Leader>sv :source $MYVIMRC<CR>

" toggle tagbar
nnoremap <Leader>tt :TagbarToggle<CR>
let g:tagbar_width=40
let g:tagbar_sort=0

" vim-spector debugger config
" let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector

" copy text from vim to the system clipboard
vnoremap <Leader>y "+y
