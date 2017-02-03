" Nate's VIMRC

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-pathogen'
Plugin 'rking/ag.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'taiansu/nerdtree-ag'
Plugin 'mileszs/ack.vim'
Plugin 'dracula/vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'othree/yajs.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'elixir-lang/vim-elixir'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'rust-lang/rust.vim'

call vundle#end()

" Pathogen stuff
execute pathogen#infect()

" Automatically cd into the directory that the file is in
set autochdir

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \   if line("'\"") > 1 && line("'\"") <= line("$") |
        \     let JumpCursorOnEdit_foo = line("'\"") |
        \     let b:doopenfold = 1 |
        \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \        let b:doopenfold = 2 |
        \     endif |
        \     exe JumpCursorOnEdit_foo |
        \   endif |
        \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

" This shows what you are typing as a command at the bottom of the page
set showcmd
set cmdheight=2

" Syntax Higlighting
filetype off
filetype plugin on
filetype plugin indent on

" read a file when it is changed from the outside
set autoread

" Use grep
" set grepprg=grep\ -nH\ $*

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Change tab to a space character
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2

" Spell checking (default=false)
if version >= 700
  set spl=en spell
  set nospell
endif

" Tab completion
set wildmenu
set wildmode=list:longest,full

set backspace=2

set autoindent
set smartindent

" Case handling
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch
set nolazyredraw

" For linux clipboard register
let g:clipbrdDefaultReg = '+'

" Second paren
highlight MatchParen ctermbg=4

syntax enable "Enable syntax hl

"set font/shell
set gfn=Inconsolata\-dz\ for\ Powerline\ 10
set shell=/bin/bash

" remove toolbar from GVim
set guioptions=

set t_Co=256
set background=dark
set encoding=utf8

let g:tex_flavor='latex'

try
  lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set backupdir=~/.tmp
set directory=~/.tmp

" Persistant undo
set undodir=~/.tmp/undodir
set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

let mapleader = ","

"Buffer Explorer
noremap <Leader>b :BufExplorer<CR>

"noremap <Leader>p :set paste<cr>
noremap <Leader>vi :tabe ~/.vimrc<CR>

" Always show line numbers and current position
set ruler
set number

" add cursorline!
set cursorline

" powerline doesn't display without this guy
set laststatus=2

set textwidth=80
set formatoptions+=t

" make it obvious when I go over 80 columns
"set colorcolumn=80

"{{{ Plugin Specific Stuff

let g:syntastic_always_populate_loc_list=1
let g:syntastic_hs_checkers=['ghc-mod', 'hlint']
let g:pandoc#formatting#mode='ha'

" don't bother me with HTML errors
let g:syntastic_html_checkers=['']

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_jvascript_eslint_exec = 'eslint_d'

" Open nerdtree if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:local_vimrc = {'names':['.local-vimrc'],'hash_fun':'LVRHashOfFile'}
" Toggle NERDTree with ,n
nnoremap <Leader>n :NERDTreeToggle<cr>

" correctly use airline symbols
let g:airline_powerline_fonts = 1

" for EMCAScript 6 and jsx
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx setfiletype javascript

let coffee_lint_options = '-f coffeelint.json'

" ctrlp Settings
"
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Use Ag instead of Ack.
let g:ackprg = 'ag --nogroup --nocolor --column -i'

" don't word wrap html
autocmd bufreadpre *.html setlocal textwidth=0

" fix mac copy/paste
set clipboard=unnamed

let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20

let g:airline_theme='bubblegum'
