" 🍻 Nate's VIMRC 🍻

" *************** REQUIREMENTS  *****************
"
" Vim 8+ with clipboard
"
" vim-plug
" https://github.com/junegunn/vim-plug
"
" RipGrep
" https://github.com/BurntSushi/ripgrep
"
" Fzf
" https://github.com/junegunn/fzf
"
" ******************* SETUP *********************
"
" Setup tmp directories
" mkdir ~/.tmp
" mkdir ~/.tmp/undodir

" ***************** PLUGINS *********************

call plug#begin('~/.vim/plugged')

" Praise the Pope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rhubarb'

" Productivity
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pretty Colors and Visual Stuff
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'

" YavaScripte™ & Frontend Dev
Plug 'kchmck/vim-coffee-script'
Plug 'w0rp/ale'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ElmCast/elm-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Misc Languages (Rust, Elixir, SASS)
Plug 'rust-lang/rust.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

" ******************* FZF ***********************

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" ************ General Commands o7 ***************

set nocompatible
filetype off

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

" Second paren
highlight MatchParen ctermbg=4

syntax enable "Enable syntax hl

"set font/shell
set gfn=Inconsolata\-dz\ for\ Powerline\ 10
set shell=/bin/bash

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

" 80 columns for life
set colorcolumn=80
colorscheme dracula

"************ PLUGIN SPECIFIC STUFF *************

let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.json,*.graphql PrettierAsync

" Dead or Alive You're Coming With Me
let g:ale_linters = {
\   'javascript': ['prettier'],
\   'ruby': ['rubocop']
\}

" use ctrl + p for fzf fuzzy file search with ripgrep
noremap <C-p> :Files <Enter>

" Ruby hates vim apparently
if v:version >= 703
  " Note: Relative number is quite slow with Ruby, so is cursorline
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline
else
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2
endif

" Toggle NERDTree with ,n
nnoremap <Leader>n :NERDTreeToggle<cr>

" correctly use airline symbols
let g:airline_powerline_fonts = 1

" JSX syntax highlight in .js files
let g:jsx_ext_required = 0

" for EMCAScript 6 and jsx
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
autocmd BufRead,BufNewFile *.jsx setfiletype javascript

let coffee_lint_options = '-f coffeelint.json'

" don't word wrap html
autocmd bufreadpre *.html setlocal textwidth=0

let g:airline_theme='dracula'

" Requires RipGrep
set grepprg=rg\ --vimgrep
