" Nate's VIMRC
"
" Started by Marshall Moutenot
" github.com/mmoutenout/Vimrc

" Necessary for a lot of cool vim things
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'ervandew/supertab'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/right_align'

" Snipmate and dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'

"Bundle 'Valloric/YouCompleteMe'

Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/Align'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/nerdtree-ack'

" awesome tabbing
Bundle 'godlygeek/tabular'

" solarized goods
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline-fonts'

"misc
Bundle 'tpope/vim-markdown'
Bundle 'sophacles/vim-processing'
Bundle 'tpope/vim-dispatch'
Bundle 'dag/vim2hs'
"Bundle 'scrooloose/syntastic'
Bundle 'itchyny/calendar.vim'
Bundle 'bling/vim-airline'

" syntastic stop annoying me
"let g:syntastic_haskell_ghc_mod_post_args="-g -fno-warn-name-shadowing"
"let g:syntastic_haskell_hlint_post_args="-g -fno-warn-name-shadowing"

"{{{Auto Commands

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

"}}}

"{{{Misc Settings

":make runs this script!
"set makeprg=./compile

" This shows what you are typing as a command at the bottom of the page
set showcmd
set cmdheight=2

" Folding Stuffs
"set foldmethod=syntax
"let g:RightAlign_RightBorder=80
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

" Syntax Higlighting
filetype off
filetype plugin on
filetype plugin indent on

" read a file when it is changed from the outside
set autoread

" Use grep
set grepprg=grep\ -nH\ $*


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
set shiftwidth=2 "necessary for 80 cols, clean looking code
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

"}}}


"{{{Look and Feel and sound
syntax enable "Enable syntax hl

"set font/shell
set gfn=Inconsolata\-dz\ for\ Powerline\ 10
set shell=/bin/zsh
" add powerline
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" remove toolbar
set guioptions=

set t_Co=256
set background=dark
colorscheme solarized
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
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files

" }}}

"{{{Functions

"{{{ Open URL in Browser

function! Browser()
  let line = getline (".")
  let line = matchstr (line,"http[^  ]*")
  exec "!chrome ".line
endfunction

"}}}

"{{{ Todo List Mode

function! TodoListMode()
  e ~/.todo.otl
  Calendar
  wincmd l
  set foldlevel=1
  tabnew ~/.notes.txt
  tabfirst
  "or 'norm! zMzr'
endfunction

"}}}

"{{{ Persistant Undo
set undodir=~/.tmp/undodir
set undofile                " Save undo's after file closes
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
"}}}

"}}}

"{{{ Mappings

let mapleader = ","

"Android dev remaps
noremap <Leader>d :Ant debug install<CR>

"Make remap
noremap <Leader>m :make<CR>

"Git remaps
noremap <Leader>gac :Gcommit -m -a ""<LEFT>
noremap <Leader>gc :Gcommit -m ""<LEFT>
noremap <Leader>gs :Gstatus<CR>

" Other remaps
noremap <Leader>n :set nopaste<cr>
noremap <Leader>p :set paste<cr>
noremap <Leader>vi :tabe ~/.vimrc<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>s :split
noremap <Leader>v :vnew
noremap <Leader>t :tabe <C-R><CR>
" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" Open Url with the browser \w
map <Leader>w :call Browser ()<CR>

" Trigger the above todo mode
noremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Folds html tags
nnoremap <leader>ft Vatzf

" Next Tab
noremap <silent> <C-Right> :tabnext<CR>
" Previous Tab
noremap <silent> <C-Left> :tabprevious<CR>
" New Tab
noremap <silent> <C-t> :tabnew<CR>

" Centers the next result on the page
map N Nzz
map n nzz

" Move up and down easier
let g:C_Ctrl_j = 'off'
nmap <C-j> <C-d>
nmap <C-k> <C-u>

" Swap ; and : (one less keypress)
nnoremap ; :
nnoremap : ;

" resize current buffer by +/- 5
nnoremap <D-S-left> :vertical resize -5<cr>
nnoremap <D-S-down> :resize +5<cr>
nnoremap <D-S-up> :resize -5<cr>
nnoremap <D-S-right> :vertical resize +5<cr>

" open terminal in vim
noremap <leader>zsh :ConqueTermSplit /bin/zsh<cr>

" DJANGO STUFF
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>
map <F8> :vertical wincmd f<CR>

fun! RelatedFile(file)
  "This is to check that the directory looks djangoish
  if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
    exec "edit %:h/" . a:file
    let g:last_relative_dir = expand("%:h") . '/'
    return ''
  endif
  if g:last_relative_dir != ''
    exec "edit " . g:last_relative_dir . a:file
    return ''
  endif
  echo "Cant determine where relative file is : " . a:file
  return ''
endfun

function! Grep(name)
  let l:pattern = input("Other pattern: ")
  "let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("grep -nIR '".a:name."' * | grep -v 'svn-base' | grep '" .l:pattern. "' | cat -n -")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif

  echo l:list
  let l:input=input("Which?\n")

  if strlen(l:input)==0
    return
  endif

  if strlen(substitute(l:input, "[0-9]", "", "g"))>0
    echo "Not a number"
    return
  endif

  if l:input<1 || l:input>l:num
    echo "Out of range"
    return
  endif

  let l:line=matchstr("\n".l:list, "".l:input."\t[^\n]*")
  let l:lineno=matchstr(l:line,":[0-9]*:")
  let l:lineno=substitute(l:lineno,":","","g")
  "echo "".l:line
  let l:line=substitute(l:line, "^[^\t]*\t", "", "")
  "echo "".l:line
  let l:line=substitute(l:line, "\:.*", "", "")
  "echo "".l:line
  "echo "\n".l:line
  execute ":e ".l:line
  execute "normal ".l:lineno."gg"
endfunction
command! -nargs=1 Grep :call Grep("<args>")
map <leader>g "syiw:Grep^Rs<cr>

" Always show line numbers and current position
set ruler
set number

" For better C/Java indentation on function parameters
"set cino=(0<Enter>

" Needed for Will Clarkson's UMS syntax highlighting
filetype on
au BufNewFile,BufRead *.ums set filetype=ums

" Needed for Comp 105 impcore syntax highlighting
au BufRead,BufNewFile *.imp set filetype=scheme

" Needed for Smalltalk syntax highlighting
au BufRead,BufNewFile *.smt set filetype=st

" add cursorline!
set cursorline

" powerline doesn't display without this guy
set laststatus=2

"let g:syntastic_always_populate_loc_list=1
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
