" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1
map <F2> i#!/usr/bin/env bash<ESC>
map <F3> o# This file was create on <ESC>:r!date "+\%x"<ESC>kJ
" More natural split opening:set splitbelow
set splitright
set mouse-=a
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set colorcolumn=80
set tabstop=4
"Bracket duplication
"inoremap " ""<esc>i
"inoremap ' ''<esc>i
"inoremap ( ()<esc>i
"inoremap { {}<esc>i
"inoremap [ []<esc>i
"inoremap " ""<Esc>:let leavechar="""<CR>i
"inoremap ' ''<Esc>:let leavechar="'"<CR>i
"inoremap { {}<Esc>:let leavechar="}"<CR>i
"inoremap ( ()<Esc>:let leavechar=")"<CR>i
"inoremap [ []<Esc>:let leavechar="]"<CR>i
"imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

"NerdTree
nnoremap <C-t> :NERDTreeToggle<CR>
"Command help full list
"This one for bash-like:
"set wildmode=longest,list
"This one for zsh-like:
set wildmenu
set wildmode=full

"Set netrw config
"https://shapeshed.com/vim-netrw/
let g:netrw_liststyle = 3
"Disable default banner:
let g:netrw_banner = 0


au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css,*.sls
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

au BufNewFile,BufRead *.sls
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |

au BufNewFile,BufRead *.{yaml,yml}
"	\set filetype=yaml
	\set foldmethod=indent
	\set expandtab
	\set tabstop=2
	\set softtabstop=2
	\set shiftwidth=2

set encoding=utf-8
set number
"Don't interpret oct numbers
"set nrformats=
filetype plugin indent on
set backspace=indent,eol,start
" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>

"vim-plug
" Specify a directory for plugins
" vim --startuptime /tmp/log - to debug
"call plug#begin('~/.vim/plugged')
"-----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'adelarsq/vim-matchit'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'jpalardy/vim-slime'
Plug 'hanschen/vim-ipython-cell'
Plug 'preservim/nerdtree'
Plug 'xolox/vim-misc'
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'Taverius/vim-colorscheme-manager'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
"System Shortcuts:
"    <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
"    <BS>  : Delete brackets in pair
"    <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
"    <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
"    <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
"    <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)
"
"If <M-p> <M-e> or <M-n> conflict with another keys or want to bind to another keys, add
"
"    let g:AutoPairsShortcutToggle = '<another key>'
"
"to .vimrc, if the key is empty string '', then the shortcut will be disabled.
"Plug 'LunarWatcher/auto-pairs'
"Plug 'jiangmiao/auto-pairs'
"Collection of configurations for built-in LSP client
Plug 'neovim/nvim-lspconfig'
"Autocompletion plugin
Plug 'hrsh7th/nvim-cmp'
"LSP source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
"Snippets source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip'
"Snippets plugin
Plug 'L3MON4D3/LuaSnip'
call plug#end()

" Set completeopt to have a better completion experience
lua << EOF
vim.o.completeopt = 'menuone,noselect'
EOF
" luasnip setup
lua << EOF
local luasnip = require 'luasnip'
EOF
" nvim-cmp setup
lua << EOF
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<M-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<M-S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF



"------------------------------------------------------------------------------
lua << EOF
require'lspconfig'.pyright.setup{}
EOF
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" slime configuration
"------------------------------------------------------------------------------
let g:slime_python_ipython = 1

"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default
" map <Leader>s to start IPython
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>

" map <Leader>r to run script
nnoremap <Leader>r :IPythonCellRun<CR>

" map <Leader>R to run script and time the execution
nnoremap <Leader>R :IPythonCellRunTime<CR>

" map <Leader>c to execute the current cell
nnoremap <Leader>c :IPythonCellExecuteCell<CR>

" map <Leader>C to execute the current cell and jump to the next cell
nnoremap <Leader>C :IPythonCellExecuteCellJump<CR>

" map <Leader>l to clear IPython screen
nnoremap <Leader>l :IPythonCellClear<CR>

" map <Leader>x to close all Matplotlib figure windows
nnoremap <Leader>x :IPythonCellClose<CR>

" map <Leader>p to run the previous command
nnoremap <Leader>p :IPythonCellPrevCommand<CR>
" Remove trailing whitespaces after :w
" https://vim.fandom.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e
" Ex command stop to bg vim
nnoremap <leader>t :stop<CR>
" netrw toggle
nmap <leader>f :Explore<CR>
nmap <leader><q-f> :edit.<CR>
"Auto-pairs option
let g:AutoPairsCompleteOnlyOnSpace=1

let g:LanguageClient_serverCommands = {
    \ 'sql': ['sql-language-server', 'up', '--method', 'stdio'],
    \ }

" https://github.com/spf13/spf13-vim/issues/540#issuecomment-78849489
"
"set shortmess=at
set syntax=on
