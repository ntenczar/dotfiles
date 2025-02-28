-- general
lvim.format_on_save = true
lvim.colorscheme = "dracula"

-- key mappings
lvim.leader = ","

-- Configure builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "elixir",
  "erlang",
  "heex"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- autopairs sucks smell ya later
require('nvim-autopairs').disable()

-- Disable virtual text
--lvim.lsp.diagnostics.virtual_text = false

-- Setup Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  }
}

-- Setup Linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "Mofiqul/dracula.nvim" },
  { 'edkolev/tmuxline.vim' },
  { 'christoomey/vim-tmux-navigator' },
  { 'tpope/vim-rhubarb' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle"
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- remove trailing whitespace in files
vim.cmd [[
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
]]

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
