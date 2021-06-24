require('plugins')

vim.cmd 'syntax enable'

local lspconfig = require("lspconfig")

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup our autocompletion. These configuration options are the default ones
-- copied out of the documentation.
require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "disabled",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true
  }
}

-- A callback that will get called when a buffer connects to the language server.
-- Here we create any key maps that we want to have on that buffer.
local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = {noremap = true, silent = true}

  map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

  -- These have a different style than above because I was fiddling
  -- around and never converted them. Instead of converting them
  -- now, I'm leaving them as they are for this article because this is
  -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

  vim.cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  vim.cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  vim.cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]

  vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
  vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]
end

-- Finally, let's initialize the Elixir language server

-- Replace the following with the path to your installation
local path_to_elixirls = vim.fn.expand("~/.cache/nvim/lspconfig/elixirls/elixir-ls/release/language_server.sh")

lspconfig.elixirls.setup({
  cmd = path_to_elixirls,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false
    }
  }
})

--[[
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}
]]--

local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- ******************* FZF ***********************
-- --column: Show column number
-- --line-number: Show line number
-- --no-heading: Do not show file headings in results
-- --fixed-strings: Search term as a literal string
-- --ignore-case: Case insensitive search
-- --no-ignore: Do not respect .gitignore, etc...
-- --hidden: Search hidden files and folders
-- --follow: Follow symlinks
-- --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
-- --color: Search color options
-- TODO(nate): this ain't work yet?
cmd([[command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob --!.git/*-- --color --always-- '.shellescape(<q-args>), 1, <bang>0)]])

-- Helper to noremap always
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- General
cmd 'colorscheme dracula'            -- Put your favorite colorscheme here
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for deoplete)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 2                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.autoread = true
opt.backupdir = "/home/nate/.tmp"
opt.undofile = true
opt.undodir = "/home/nate/.tmp/undodir"
opt.undolevels = 1000
opt.undoreload = 10000
opt.ruler = true
opt.number = true
opt.cursorline = true
opt.laststatus = 2

-- Plugin Variables
g.airline_theme = 'dracula'
g.airline_powerline_fonts = 1
--g.tex_flavor = 'latex'

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

cmd 'filetype plugin indent on'

-- highlight other matching parens
cmd('highlight MatchParen ctermbg=4')
-- remove all extra whitespace in the file
cmd([[autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif]])

cmd('noremap <C-p> :Files <Enter>')

-- use 80 columns everywhere
cmd('set textwidth=80')
cmd('set colorcolumn=80')

-- ..except elixir files use the default 98 cols
cmd('autocmd BufRead,BufNewFile *.ex,*.exs setlocal textwidth=98')
cmd('autocmd BufRead,BufNewFile *.ex,*.exs setlocal colorcolumn=98')

-- set ripgrep as grep of choice
cmd([[set grepprg=rg\ --vimgrep]])

cmd('let mapleader = ","')
-- toggle nerdtree with ,
cmd('nnoremap <Leader>n :NERDTreeToggle<cr>')

cmd('set clipboard+=unnamedplus')
