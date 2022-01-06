set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"Leader key and my own key settings. This has to come before plugins
let mapleader = ","

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
"
" " Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'feline-nvim/feline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'akinsho/bufferline.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-unimpaired'
Plug 'neovim/nvim-lspconfig'

" " List ends here. Plugins become visible to Vim after this call.
call plug#end()

""""""-----------PLUGIN CONFIGS-------------------

" For Airline
let g:airline_theme='luna'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" For feline (airline replacement) and other lua based syntax highlighting
set termguicolors
lua << ENDFELINE
require('nvim-web-devicons').setup({
    default=true
})
require('gitsigns').setup()
require('feline').setup()
require('bufferline').setup()
ENDFELINE

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
nmap <leader>gs :Git<CR>
nmap <leader>gc :Git commit -v -q<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gp :Git push<CR>
set diffopt+=vertical

" For nim
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" For zig and other Neovim LSPs
:lua << EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
-- 
--   -- Enable completion triggered by <c-x><c-o>
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- 
--   -- Mappings.
--   local opts = { noremap=true, silent=true }
-- 
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
--   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- 
-- end
-- 
-- local servers = { 'zls' }
-- for _, lsp in ipairs(servers) do
--     require('lspconfig').zls.setup {
--         on_attach = on_attach
--     }
-- end
EOF
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Enable completions as you type
let g:completion_enable_auto_popup = 1

" For Python executable
let g:python3_host_prog = 'C:/Users/z124t/AppData/Local/Microsoft/WindowsApps/python3.exe'


" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" For Fish
"" Set up :make to use fish for syntax checking.
autocmd Filetype fish compiler fish

"" Enable folding of block structures in fish.
autocmd Filetype fish setlocal foldmethod=expr

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
autocmd Filetype javascript,html,css setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype tex,text,markdown setlocal ts=2 sw=2 expandtab
autocmd Filetype nim setlocal ts=2 sw=2 expandtab
" Google Style guide
autocmd Filetype cpp setlocal ts=2 sw=2 expandtab

"4 space indents
autocmd Filetype python setlocal ts=4 sw=4 expandtab

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

" For the clipboard (speeds up booting on WSL)
set clipboard+=unnamedplus
let g:clipboard = {
      \   'name': 'windowsclipboard',
      \   'copy': {
      \      '+': ['win32yank', '-i', '--crlf'],
      \      '*': ['win32yank', '-i', '--crlf'],
      \    },
      \   'paste': {
      \      '+': ['win32yank', '-o', '--crlf'],
      \      '*': ['win32yank', '-o', '--crlf'],
      \   },
      \   'cache_enabled': 1,
      \ }

"Wrapping
set wrap
set wrapmargin=0
set textwidth=80
set linebreak
set nolist      " Turn it on manually when needed
set lcs+=space:⋅
set lcs+=trail:·
set lcs+=tab:░\
set lcs+=trail:·
set lcs+=extends:»
set lcs+=precedes:«
set lcs+=nbsp:⣿
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
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

"Mapping keys
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

map <Leader>ll :Silent pdflatex -synctex=1 -interaction=nonstopmode -output-directory %:p:h %:p<CR>
map <Leader>run :!%:p

" Edit this file
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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

command! W write
command! Q quit
command! WQ wq
command! Wq wq
cmap w!! w !sudo tee > /dev/null %

