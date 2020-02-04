"Leader key and my own key settings. This has to come before plugins
let mapleader = ","

"For Vundle
set nocompatible  
filetype off 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'craigemery/vim-autotag'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'majutsushi/tagbar'
Plugin 'rust-lang/rust.vim'
" Plugin 'zah/nim.vim'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
""""""-----------PLUGIN CONFIGS-------------------

" For Airline
let g:airline_theme='luna'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"For CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nmap <leader>p :CtrlP<cr>
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap <leader>tg :CtrlPTag<cr>

"For Buffergator
let g:buffergator_suppress_keymaps = 1
" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>
nmap <leader>gt :BuffergatorMruCycleNext<cr>
nmap <leader>gT :BuffergatorMruCyclePrev<cr>
nmap <leader>tt :edit 

"For YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'
"map <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
set omnifunc=syntaxcomplete#Complete

" For fugitive (Git)
nmap <leader>ga :Git add %:p<CR><CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v -q<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Git local 
nmap <leader>gw :Gwrite<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gp :Git push<CR>
set diffopt+=vertical

"For Tagbar
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap <leader>tb :TagbarToggle<CR>

"For Syntastic
let g:syntastic_javascript_checkers=['eslint']

" For nim
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

""""""-----------END OF PLUGIN CONFIGS-------------------

" For spellchecking
nmap <leader>sc :setlocal spell spelllang=en_us<CR>
nmap <leader>ns :setlocal nospell<CR>

" For Browser
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4    " Open in previous buffer
let g:netrw_winsize=15
let g:netrw_altrv = 1
nmap <leader>nv :Vex<CR>

"Filetype indents
set tabstop=4
set shiftwidth=4
set expandtab

"2 space indents
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype tex,text,markdown setlocal ts=2 sw=2 expandtab

"4 space indents
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype nim setlocal ts=2 sw=2 expandtab
" Google Style guide
" autocmd Filetype cpp setlocal ts=2 sw=2 expandtab

"8 space indents (Linux Kernel style)
autocmd Filetype c setlocal ts=8 sw=8 expandtab

" Gofmt uses tabs
autocmd Filetype go setlocal ts=4 sw=4 sts=4 noet

"In general
syntax enable
set bg=dark
set autoindent
set smartindent
set number
set cursorline
set hidden				"For buffers
set formatoptions-=cro
set splitright
set backspace=indent,eol,start
set ff=unix
set encoding=utf-8
let python_highlight_all=1
set tags=tags;/             "Look for tags upwards
set mouse=a

"Wrapping
set wrap
set wrapmargin=0
set textwidth=80
set linebreak
set nolist  " list disables linebreak
autocmd Filetype tex,text,markdown setlocal textwidth=0

"Case insensitive search for lowercase query, case sensitive for mixed case
set incsearch       "Start searching with incomplete tag
set ignorecase
set smartcase
set hlsearch

" Enable folding
set foldmethod=syntax
autocmd Filetype python,html,nim setlocal foldmethod=indent
"set foldlevel=99
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

"Mapping keys
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

map <Leader>ll :Silent pdflatex -synctex=1 -interaction=nonstopmode -output-directory %:p:h %:p<CR>
map <Leader>run :!%:p

" Edit this file
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" C++ includes (Note: don't use #c!)
iabbrev #a #include <algorithm>
iabbrev #i #include <iostream>
iabbrev #s #include <string>
iabbrev #l #include <limits>
iabbrev #n #include <numeric>
iabbrev #q #include <queue>
iabbrev #r #include <random>
iabbrev #u #include <utility>
iabbrev #m #include <unordered_map>
iabbrev #v #include <vector>
iabbrev #d #include <bits/stdc++.h>
iabbrev iuns using namespace std;
iabbrev imain int main(int argc, char **argv)<cr>{<cr>return 0;<cr>}

" C includes (Note: #cs doesn't work somehow)
iabbrev #c #include <stdio.h><cr>#include <stdlib.h><cr>#include <assert.h>

" Get off my lawn
nnoremap <Left> <C-W>5<
nnoremap <Right> <C-W>5>
nnoremap <Up> <C-W>3-
nnoremap <Down> <C-W>3+

" Movement
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-N> gT
noremap <C-M> gt
noremap <C-B> <C-U>

"Remapping of Actual Keys
"Note: Made a major change. Now, carriage return returns a newline
imap jj <Esc>
inoremap <S-Tab> <C-d>
nnoremap <CR> o<Esc>
nnoremap 0 ^
nnoremap ^ 0
nnoremap <Space> za
nnoremap <C-n> :nohl<CR>
nmap S ciw
nmap Y y$

"Matchings
"inoremap ( ()<Esc>i
"inoremap " ""<Esc>i
"inoremap [ []<Esc>i
"inoremap { {<CR><BS>}<Esc>ko

command! W write
command! Q quit
command! WQ wq
command! Wq wq
cmap w!! w !sudo tee > /dev/null %

"Macros
let @b='o\begin{homeworkProblem}% Problem 0\end{homeworkProblem}jjkkA'
let @e='i\begin{enumerate}[(a)]\item\item\end{enumerate}^xkk$a'
let @c='i\[f(x) = \begin{cases}0 &\text{ if } x \leq 0\\x &\text{ if } x > 0\end{cases}\]'
let @a='o\begin{align*}a &= b\\\end{align*}jjkk0'
let @m='\begin{bmatrix} a & b & c \end{bmatrix}^T'
let @d='\frac{du}{dt}'

"Pasting shortcuts
let @s=' \text{ s.t. } '
let @t='^*'
let @i='^{-1}'
