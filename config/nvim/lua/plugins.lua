local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

local startup = require("packer").startup

startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Native Neovim LSP
  use 'neovim/nvim-lspconfig'

  -- configures language modules for tree sitting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      vim.cmd [[TSUpdate]]
    end
  }

  -- Praise the Pope
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-obsession'

  -- Productivity
  use 'christoomey/vim-tmux-navigator'
  use 'lewis6991/gitsigns.nvim'
  use 'airblade/vim-gitgutter'
  use 'scrooloose/nerdtree'
  use 'benmills/vimux'
  use 'ntenczar/todo.vim'
  use 'vim-test/vim-test'
  use "farmergreg/vim-lastplace"

  -- fzf
  use {
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end
  }
  use {'junegunn/fzf.vim', rtp = '~/.fzf'}

  -- Pretty Colors and Visual Stuff
  use {'dracula/vim', as = 'dracula'}
  use 'vim-airline/vim-airline-themes'
  use 'bling/vim-airline'
  use 'edkolev/tmuxline.vim'
  use "elixir-editors/vim-elixir"

  -- autocomplete and snippets
  use "hrsh7th/nvim-compe"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"
  use "ojroques/nvim-lspfuzzy"
end)
