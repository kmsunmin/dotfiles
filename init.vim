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
    Plug 'arcticicestudio/nord-vim'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'tomasiser/vim-code-dark'
    Plug 'w0ng/vim-hybrid'
    Plug 'jacoborus/tender'
    Plug 'morhetz/gruvbox'
    Plug 'ayu-theme/ayu-vim'
    Plug 'joshdick/onedark.vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'altercation/solarized'
    Plug 'tomasr/molokai'
    Plug 'dracula/vim', {'as': 'dracula'}
    Plug 'chriskempson/base16-vim'
    Plug 'sonph/onehalf', {'rtp': 'vim/'}
    Plug 'johngrib/FlatColor-johngrib'
    Plug 'yuttie/hydrangea-vim'
    Plug 'tyrannicaltoucan/vim-deep-space'
    " displays icons
    " Plug 'ryanoasis/vim-devicons'
    " vim plugin for git
    Plug 'tpope/vim-fugitive'
    " shows a git diff in number line
    Plug 'airblade/vim-gitgutter'
    " copilot
    Plug 'github/copilot.vim'
    " airline
    Plug 'vim-airline/vim-airline'
    " comment things out
    Plug 'tpope/vim-commentary'
    " for easier brackets, parantheses, quotes, etc.
    Plug 'tpope/vim-surround'
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
    " Plug 'tpope/vim-cucumber' 
    " Vim game
    Plug 'johngrib/vim-game-code-break'
    " minimap for Vim 
    " Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
    " indent line
    Plug 'Yggdroot/indentLine'
    " support for Golang
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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
set nomodeline
set colorcolumn=79

" display
set nu              " line number
set ruler           " coordinate of current cursor position
set laststatus=2    " status bar always on
set cursorline      " highlight current line
set showmatch       " display matching brackets
set termguicolors
set background=dark
let g:seoul256_background = 233
let ayucolor = 'dark'
colorscheme ayu "seoul256 ayu PaperColor seoul256 
highlight ColorColumn guibg=green

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

" automatically display all buffers when there is only one tab open
let g:airline#extensions#tabline#enabled = 1
" airline theme
" let g:airline_theme = 'codedark'

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

function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
            \ strftime('%Y-%m-%d %H:%M:%S -0500') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre *.md call LastModified()

" vim-startify setting
let g:startify_bookmarks = [
\]

let g:startify_list_order = [
\]

" NERDTree mappings
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
" nnoremap <C-t> :NERDTreeToggle<CR>

" map keys to use fzf and Rg faster
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-h> :History<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <esc><esc> :noh<return><esc>

" fzf window location
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = ['right:50%:', 'ctrl-/']


" Advanced ripgrep integration
" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" edit init.vim
nnoremap <Leader>ev :vsplit<space>~/.config/nvim/init.vim<CR>
" source init.vim
nnoremap <Leader>sv :source $MYVIMRC<CR>

" toggle tagbar
nnoremap <Leader>tt :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_sort = 0

" copy text from vim to the system clipboard
vnoremap <Leader>y "+y


" manage buffers
nnoremap <silent> <PageUp> :bnext!<CR>
nnoremap <silent> <PageDown> :bprevious!<CR>

" minimap configuration
" let g:minimap_width = 10
" let g:minimap_auto_start = 1
" let g:minimap_auto_start_win_enter = 1

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']
" let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_go_gometalinter_args = ['--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 2 
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 1 

" run go imports on file save
let g:go_fmt_command = "gopls"
let g:go_metalinter_autosave = 1
let g:go_mod_fmt_autosave = 1
" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0 

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_array_whitespace_error =1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_diagnostic_errors = 1

