"Leader key and my own key settings
let mapleader = ","

"For Vundle
set nocompatible  
filetype off 
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle')
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
"Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'majutsushi/tagbar'
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

""""""-----------PLUGIN CONFIGS-------------------
" For Airline
let g:airline_theme='simple'
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

" For fugitive (Git)
nmap <leader>ga :Git add %:p<CR><CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v -q<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Git local 
nmap <leader>gw :Gwrite<CR>
nmap <leader>gr :Gread<CR>
set diffopt+=vertical

"For YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader> gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"For Tagbar
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
nnoremap <leader>tb :TagbarToggle<CR>


""""""-----------END OF PLUGIN CONFIGS-------------------

" For spellchecking
nmap <leader>sc :setlocal spell spelllang=en_us<CR>
nmap <leader>ns :setlocal nospell<CR>

"In general
syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=79
set expandtab
set autoindent
set smartindent
set number
set cursorline
set hidden				"For buffers
set wrap
set linebreak
set nolist  " list disables linebreak
set wrapmargin=0
set formatoptions-=cro
set splitright
set backspace=indent,eol,start
set ff=dos
set encoding=utf-8
let python_highlight_all=1
set tags=tags;/             "Look for tags upwards

" Enable folding
set foldmethod=indent
set foldlevel=99

" Edit this file
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" C++ includes
iabbrev #a #include <algorithm>
iabbrev #d #include <deque>
iabbrev #c #include <cmath>
iabbrev #i #include <iostream>
iabbrev #l #include <limits>
iabbrev #n #include <numeric>
iabbrev #q #include <queue>
iabbrev #r #include <random>
iabbrev #u #include <utility>
iabbrev #m #include <unordered_map>
iabbrev #v #include <vector>
iabbrev iuns using namespace std;
iabbrev imain int main(int *argc, char **argv) {<cr> return 0;<cr>}

"Temporaryily disable this function
"nmap <leader>g :call Google()<CR>
fun! Google()
	let keyword = expand("<cword>")
	let url = "http://www.google.com/search?q=" . keyword
	let path = "C:/Program Files/Mozilla Firefox/"
	exec 'silent !"' . path . 'firefox.exe" ' . url
endfun

" Bad Whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h, *.cpp match BadWhitespace /\s\+$/

"VirtualEnv support 
""python with virtualenv support
"Temporarily disabled


" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Movement
noremap <C-H> <C-W>5<
noremap <C-L> <C-W>5>
noremap <C-J> <C-W>5-
noremap <C-K> <C-W>5+
noremap <C-N> gT
noremap <C-M> gt

"Mapping keys
map <Leader>ll :silent !pdflatex.exe -synctex=1 -interaction=nonstopmode -output-directory %:p:h %:p<CR><CR>
map <Leader>run :silent !%:p<CR>

"Remapping of Actual Keys
imap jj <Esc>
nnoremap <CR> i<CR><Esc>
nmap Y y$
nmap S ciw
nnoremap 0 ^
nnoremap ^ 0
nnoremap q: :q
nnoremap <Space> i<Space><Esc>

command! W write
command! Q quit
command! WQ wq
command! Wq wq

"Macros
let @b='i\begin{homeworkProblem}\end{homeworkProblem}jjkkA	'	
let @e='i\begin{enumerate}[label = (\alph*)]\item\item\end{enumerate}^xkk$a'
let @c='i\[f(x) = \begin{cases}0 &\text{ if } x \leq 0\\x &\text{ if } x > 0\end{cases}\]'
let @a='o\begin{align*}a &= b\\\end{align*}jjkk0'
let @m='\left(\begin{smallmatrix} a&b \\ c&d \end{smallmatrix} \right)'
let @d='\frac{du}{dt}'


"Pasting shortcuts
let @s=' \text{ s.t. } '
let @i='^{-1}'
