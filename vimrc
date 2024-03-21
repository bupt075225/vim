"--------------------------------------------------
" Descriptor: vimrc including plugins for Linux 
" Author: Bill Liu
" Email: nonprivatemail@163.com
"--------------------------------------------------

"--------------------------------------------------
" vim-plug setting
"--------------------------------------------------
call plug#begin()

" Make sure you use single quotes

" Added nerdtree
Plug 'scrooloose/nerdtree'

let NERDTreeIgnore=['\.pyc$'] " ignore files in NERDTree
let NERDTreeWinPos='right'   " nerdtree locate at right side
let NERDTreeShowBookmarks = 1
" Open NERDTree with F2
map <F2> :NERDTreeToggle<cr>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree 
autocmd vimenter * wincmd p  " focus main windows on launch

" Added Ctrlp, Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'kien/ctrlp.vim'

" Exclude files and directories
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|svn)$',
  \ 'file': '\v\.(swp|pyc|so|tar|tar.gz|zip)$',
  \ }
" Open a new file in a new tab
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }

" Added ack(You will need ack (>= 2.0)),a search tool as a replacement for
" grep
Plug 'mileszs/ack.vim'

" highlight the keyword
let g:ackhighlight = 1

" Added gutentags(management of tags files)
" required vim version >=8.0 and ctags
Plug 'ludovicchabant/vim-gutentags'

" To know when Gutentags is generating tags
"set statusline+=%{gutentags#statusline()}
let g:gutentags_project_root = ['.git']

" To know when Gutentags is generating tags
set statusline+=%{gutentags#statusline()}
let g:gutentags_project_root = ['.svn', '.git']
" the suffix of tags data files
let g:gutentags_ctags_tagfile = '.tags'
" To avoid tags files to pollute your projects
let s:vim_tags = expand('~/.cache/vim_tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" Added autotag
Plug 'craigemery/vim-autotag'

let g:autotagTagsFile="tags"

call plug#end()
filetype plugin indent on  " not to ignore plugin indent changes

" Brief help
" :PluginList        - lists configured plugins
" :PluginInstall     - installs plugins; append `!` to update or :PluginUpdate
" :PluginSearch foo  - searches for foo; append `!` to refresh local cache
" :PluginClean       - confirms removal of unused plugins; append `!` to auto

"--------------------------------------------------
" General setting
"--------------------------------------------------
set nocompatible     " Use Vim defaults (much better!)
" To allow backspacing over everything in insert mode when compile vim
" manually
set backspace=indent,eol,start
set history=50       " keep 50 lines of command line history
set nu!              " dispaly the line numbers
set nowrap           " no auto new line 
set ruler            " show the cursor position all the time
set ignorecase
set smartcase
set autoread         " when the file is modified externally, the file is automatically updated
set nobackup
set noswapfile
set clipboard+=unnamed " the default register is shared with the system clipboard
set winaltkeys=no
set mouse=a          " enable mouse under any mode
set tags=tags;       " begin find tags file from working directory
set autochdir        " set current dir as working directory

" record last edit location
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------
" Lang & Encoding setting
"--------------------------------------------------
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936  " encode supported
set fileencoding=utf-8  " current file encode
set encoding=utf-8      " vim internal file encode
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
language messages zh_CN.utf-8  " avoid consle output garbled under windows system

" avoid menu garbled under windows system
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set fileformat=unix     " new file <EOL>

"--------------------------------------------------
" GUI setting
"--------------------------------------------------
colorscheme evening
set splitbelow       " the split window is located below
set splitright       " the split window is located to right
set guioptions-=T    " hide the toolbar
set guioptions-=m    " hide the menu bar
set guioptions-=L
set guioptions-=r
set guioptions-=b

set guioptions-=e    " use vim tab

set guifont=Courier\ New:h14  " font and size
au GUIEnter * simalt ~x " the window is automatically maximized when it starts up

" status line
set statusline=%F%m\ \ \ \ %{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ \ \ \ \ %l,%v\ %p%%
set laststatus=2     " show status line anyway

"--------------------------------------------------
" Find/replace setting 
"--------------------------------------------------
set hlsearch         " highlight search result
set incsearch        " Incremental search

"--------------------------------------------------
" Coding setting
"--------------------------------------------------
syntax enable        " syntax highlight
syntax on            " turn on file type detection
set autoindent       " always set autoindenting on
set expandtab        " use spaces instead of tabs
set shiftwidth=4     " 1 tab == 4 spaces
set tabstop=4
set showmatch        " show parentheses matching

" use the below highlight group when displaying bad whitespace is desired
highlight BadWhitespace ctermbg=red guibg=red

" it can mark whitespace issues
au BufRead,BufNewFile *.py,*.c,*.h match BadWhitespace /\s\+$/

" add the proper PEP 8 indentation
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=79
    \set expandtab
    \set autoindent
    \set fileformat=unix

let mapleader = ","
" mapping key to edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" mapping key for quickfix
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap  <leader>oq :<C-u>copen<CR>
nnoremap  <leader>cq :<C-u>cclose<CR>

" mapping key for ack
" -i case-insensitive, Ctrl+r" to paste from the register
nnoremap <Leader>a :Ack!<space>-i<space><C-r>"<CR>
