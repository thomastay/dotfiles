set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"Leader key and my own key settings. This has to come before plugins
let mapleader = ","

" Plugins will be downloaded under the specified directory.
call plug#begin()
"
" " Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'feline-nvim/feline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'akinsho/bufferline.nvim'
Plug 'folke/which-key.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-telescope/telescope-live-grep-raw.nvim'
Plug 'tmhedberg/SimpylFold'
Plug 'neovim/nvim-lspconfig'
Plug 'b3nj5m1n/kommentary'
Plug 'ziglang/zig.vim'
Plug 'rakr/vim-one'
Plug 'simrat39/rust-tools.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " Auto Completion engine
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " Snippets

" " List ends here. Plugins become visible to Vim after this call.
call plug#end()

""""""-----------PLUGIN CONFIGS-------------------
" For all lua based extensions
" feline (airline replacement)
set termguicolors
lua << ENDLUA
require('nvim-web-devicons').setup({
    default=true
})
require('gitsigns').setup {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
}
require('feline').setup()
require('bufferline').setup()
require('telescope').setup {
  defaults = {
    path_display = {
      truncate = 5,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  },
}
require('telescope').load_extension('fzf')
require('which-key').setup()
require('which-key').register {
    ["<leader>ut"] = "Convert word to UTC Date",

    -- For telescope (Ctrl P replacement)
    -- Find files using Telescope command-line sugar.
    ["<C-p>"]      = { require("telescope.builtin").find_files, "Find File" },
    ["<leader>rg"] = { require("telescope").extensions.live_grep_raw.live_grep_raw, "Search in files" },
    ["<leader>rs"] = { require("telescope.builtin").grep_string, "Search for string under cursor" },
}

--- =============================================
---
---         Language Server Protocols
---
--- =============================================

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', ',td', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', ',ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', ',te', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', ',fa', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = { 'zls', 'gopls' }
local lspConfig = require('lspconfig')
local coq = require "coq"
for _, lsp in ipairs(servers) do
    lspConfig[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
        }
    }))
end

local rustToolsOpts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(rustToolsOpts)
ENDLUA

"For Buffergator
" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" For fugitive (Git)
nmap <leader>ga :Git add %:p<CR><CR>
nmap <leader>gs :Git<CR>
nmap <leader>gc :Git commit -v -q<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gp :Git push<CR>
set diffopt+=vertical

" For Python executable
let g:python3_host_prog = 'C:/Program Files/WindowsApps/PythonSoftwareFoundation.Python.3.8_3.8.2800.0_x64__qbz5n2kfra8p0/python3.8.exe'

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
autocmd Filetype javascript,typescript,html,css setlocal ts=2 sw=2 expandtab
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

" Color scheme
colorscheme one
set bg=dark

"In general
syntax enable
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
      \      '+': ['win32yank', '-o', '--lf'],
      \      '*': ['win32yank', '-o', '--lf'],
      \   },
      \   'cache_enabled': 1,
      \ }

" For nvim-qt
set guifont=FiraCode\ NF

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
set foldlevel=99

"JSON handling
nnoremap <leader>jf :%!jq<cr><bar>:set ft=json<cr>

" Parse unix time stamps
" TODO possibly turn to lua
function! ParseMillisTimeStamp(timestamp)
    let tstamp = a:timestamp[:9]
    return strftime("%c", tstamp)
endfunction

nnoremap <leader>ut ciw<C-r>=ParseMillisTimeStamp(<C-r>")<cr><Esc>

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
" noremap <C-B> <C-U> Used this for tmux but now don't need it

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

