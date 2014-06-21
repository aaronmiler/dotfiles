"------------------------------------------------------------
" Features
"
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
filetype off

:runtime macros/matchit.vim

" Enable syntax highlighting
syntax on

"------------------------------------------------------------
" Set up Vunbler/Vundle
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" " required!
Plugin 'gmarik/vundle'

Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-git.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kchmck/vim-coffee-script'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------
" These are highly recommended options.

set hidden

" Better command-line completion
set wildmenu
set showcmd

" Searches
set hlsearch
set incsearch
set ignorecase
set smartcase

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
set number
set relativenumber
set numberwidth=1

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

"------------------------------------------------------------
" Indentation options
"

" Indentation settings for using 2 spaces instead of tabs.
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2


"------------------------------------------------------------
" Split Preferences

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Easier Split Navigation

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Split Opening

set splitbelow
set splitright

"------------------------------------------------------------
" No more Swap files in projects

set undodir=~/.vim/undo//

set autoread

"-----------------------------------------------------------
" Colors!

set background=dark
colorscheme solarized

"-----------------------------------------------------------
" Overrides

let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

"-----------------------------------------------------------
" Leader
let mapleader = ","

map <Leader>cp :%y+<CR>
map <Leader>bi :! bundle install<CR><CR>
map <Leader>e :tabe ./
map <Leader>hl :nohl<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>mk :!mkdir -p %:p:h<CR><CR>
map <Leader>o :!open .<CR><CR>
map <Leader>p :set paste<CR>:r !pbpaste<cr>:set nopaste<cr>
map <Leader>r :w<CR>:!chrome-cli reload<CR><CR>
map <Leader>hl :nohl<CR>
map <Leader>sp :setlocal spell! spelllang=en_us<CR>

" Leaders for editing: Open Tab, Split, Vert Split
map <Leader>he :sp ./
map <Leader>te :tabe ./
map <Leader>ve :vsp ./

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
map <c-s> <esc>:w<CR>
imap <c-s> <esc>:w<CR>

" Remap Semicolon to Colon
nnoremap ; :
