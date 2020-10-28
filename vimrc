"------------------------------------------------------------
" Features
"
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
filetype off

:runtime macros/matchit.vim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif


"------------------------------------------------------------
" Set up Plug
"
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-rails'
Plug 'tpope/vim-git'
Plug 'altercation/vim-colors-solarized'
Plug 'kchmck/vim-coffee-script'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'slim-template/vim-slim'
Plug 'scrooloose/nerdtree'
Plug 'ngmy/vim-rubocop'
Plug 'benekastah/neomake'
Plug 'itchyny/lightline.vim'
Plug 'elzr/vim-json'
Plug 'itchyny/lightline.vim'
Plug 'elixir-lang/vim-elixir'

call plug#end()            " required

" Plugin Settings

let g:vim_json_syntax_conceal = 0

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '◣ ', 'right': '◀' },
      \ 'subseparator': { 'left': ' ', 'right': '|' }
      \ }
set laststatus=0
set noshowmode

" All of your Plugins must be added before the following line

" Enable syntax highlighting
syntax enable

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

"-----------------------------------------------------------
" Leader
let mapleader = ","
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

map <Leader>bi :! bundle install<CR><CR>
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <Leader>cp :%y+<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>mk :!mkdir -p %:p:h<CR><CR>
map <Leader>o :!open .<CR><CR>
map <Leader>p :set paste<CR>:r !pbpaste<cr>:set nopaste<cr>
map <Leader>re :w<CR>:!touch ./tmp/restart.txt<CR><CR>
map <Leader>rb :RuboCop<CR>
map <Leader>sp :setlocal spell! spelllang=en_us<CR>
map <Leader>sc :call SCSSLint()<CR>

map <Leader>ls :ls<CR>
map <Leader>b  :b
map <Leader>bn :bn<CR>
map <Leader>bp :bp<CR>

" Leaders for editing: Open Tab, Split, Vert Split
map <Leader>e :tabe ./
map <Leader>he :sp ./
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

function! SCSSLint()
  let current_file = shellescape(expand('%s:p'))
  let cmd = "scss-lint " . current_file
  let output = system(cmd)
  echo output
endfunction

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

" Clear last search highlight
nnoremap <Space> :noh<cr>

" Control S to save
map <c-s> <esc>:w<CR>
imap <c-s> <esc>:w<CR>

" Remap Semicolon to Colon
nnoremap ; :
