"------------------------------------------------------------
" Features
"
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

"------------------------------------------------------------
" Set up Vunbler/Vundle
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" " required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-rails.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-git.git'
Bundle 'kchmck/vim-coffee-script'


"------------------------------------------------------------
" These are highly recommended options.

set hidden

" Better command-line completion
set wildmenu
set showcmd
set hlsearch
set incsearch

"------------------------------------------------------------
" Usability options
"

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=2

" Display line numbers on the left
set relativenumber
set number
set numberwidth=1

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

"------------------------------------------------------------
" Indentation options
"

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2

"------------------------------------------------------------
" No more Swap files in projects

set undodir=~/.vim/undo//

set autoread

"-----------------------------------------------------------
" Colors!

set background=dark
colorscheme solarized

"-----------------------------------------------------------
" Leader
let mapleader = ","

" NOTE: ; takes the place of : because I've remapped them

map <Leader>hl ;nohl<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>mk ;!mkdir -p %;p;h<CR><CR>
map <Leader>o ;!open .<CR><CR>
map <Leader>p ;set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>r ;!chrome-cli reload<CR><CR>
map <Leader>t ;tabedit ./

"------------------------------------------------------------
" Functions and Such

" Stolen from 'More Instantly Better Vim' by Damian Conway
" http://www.youtube.com/watch?v=aHm36-na4-4

" Highlight the 81st character to identify long lines
highlight ColorColumn ctermbg=blue
call matchadd('ColorColumn','\%81v',100)

" No Tabs, and no Trailing Whitespace
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db " Ignore these files, obviously

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"------------------------------------------------------------
" Mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Remap jk to leave insert mode
imap jk <ESC>

" Don't use the arrow keys
noremap <up>    :echoerr 'USE K TO GO UP'<CR>
noremap <down>  :echoerr 'USE J TO GO DOWN'<CR>
noremap <left>  :echoerr 'USE H TO GO LEFT'<CR>
noremap <right> :echoerr 'USE L TO GO RIGHT'<CR>

" Control S to save
map <c-s> <esc>;w<CR>
imap <c-s> <esc>;w<CR>

" Remap Semicolon to Colon
nnoremap ; :
nnoremap : ;
