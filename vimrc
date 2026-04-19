"------------------------------------------------------------
" Features
"
let &t_TI = ""
let &t_TE = ""

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

Plug 'jan-warchol/selenized', { 'rtp': 'editors/vim' }
Plug 'elzr/vim-json'
Plug 'itchyny/lightline.vim'
Plug 'jgdavey/tslime.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'noprompt/vim-yardoc'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-git'
Plug 'yuezk/vim-js'

call plug#end()

" Plugin Settings

let g:vim_json_syntax_conceal = 0

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '◣ ', 'right': '◀' },
      \ 'subseparator': { 'left': ' ', 'right': '|' }
      \ }
set noshowmode

" Enable syntax highlighting
syntax enable

filetype plugin indent on

"------------------------------------------------------------
" These are highly recommended options.

set hidden

" Better command-line completion
set wildmenu
set showcmd

"------------------------------------------------------------
" Usability options

set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
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
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

set autoread

"-----------------------------------------------------------
" Colors!

set termguicolors
colorscheme selenized

"-----------------------------------------------------------
" Leader
let mapleader = ","
let g:vimrubocop_config = './.rubocop.yml'

map <Leader>bi :! bundle install<CR><CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>mk :!mkdir -p %:p:h<CR><CR>
map <Leader>o :!open .<CR><CR>
map <Leader>p :r !pbpaste<cr>
map <Leader>cp :%y+<CR>
map <Leader>re :w<CR>:!touch ./tmp/restart.txt<CR><CR>
map <Leader>sp :setlocal spell! spelllang=en_us<CR>

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

" Highlight the 120th character to identify long lines
highlight ColorColumn ctermbg=blue
call matchadd('ColorColumn','\%120v',100)

" No Tabs, and no Trailing Whitespace
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"------------------------------------------------------------
" Mappings

" Map Y to act like D and C, i.e. to yank until EOL
map Y y$

" Remap jk to leave insert mode
imap jk <ESC>

" Clear last search highlight
nnoremap <Space> :noh<cr>

" Control S to save
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
nnoremap <C-p> :GFiles<CR>
inoremap <C-p> <Esc>:GFiles<CR>

" Remap Semicolon to Colon
nnoremap ; :
