local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- General Purpose plugins
  use({ "wbthomason/packer.nvim" }, {
    mappings={},
  })
  use({ "tpope/vim-surround" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "windwp/nvim-autopairs" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })
  --use({ "akinsho/toggleterm.nvim" })
  --use({ "ahmedkhalf/project.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim", main = 'ibl' })
  use({ "moll/vim-bbye" })
  use({ 'famiu/bufdelete.nvim' })
  use("folke/which-key.nvim")
  use({ "numToStr/Comment.nvim" })
  use({ "nvim-lualine/lualine.nvim", requires = { 'nvim-tree/nvim-web-devicons', opt = true } })

  -- Colorschemes
  use({ "folke/tokyonight.nvim" })
  use({ "lunarvim/darkplus.nvim" })
  use({ "sainnhe/gruvbox-material" })
  
  -- Colorizer
  use("NvChad/nvim-colorizer.lua")

  -- cmp
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use("hrsh7th/cmp-cmdline")
  use({ "saadparwaiz1/cmp_luasnip" })

  -- snippets
  use({
    "L3MON4D3/LuaSnip",
    tag = "v2.*",
    run = "make install_jsregexp"
  })
  --use({ "rafamadriz/friendly-snippets" })
  
  -- Coc
  -- use({'github/copilot.vim'})
  -- use { 'neoclide/coc.nvim', branch = 'release' }


  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use "nvimtools/none-ls-extras.nvim"
  use({
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  })
  use({ "RRethy/vim-illuminate" })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { 'nvim-lua/plenary.nvim' } }
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  })

  --Treesitter
  use({
  "nvim-treesitter/nvim-treesitter",
  })
  use("windwp/nvim-ts-autotag")
  use("HiPhish/rainbow-delimiters.nvim")
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  --Python Tools

  --Debug
  --use({
  --	"mfussenegger/nvim-dap",
  --	opt = true,
  --	event = "BufReadPre",
  --	module = { "dap" },
  --	wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "which-key.nvim" },
  --	requires = {
  --		"Pocco81/DAPInstall.nvim",
  --		"theHamsta/nvim-dap-virtual-text",
  --		"rcarriga/nvim-dap-ui",
  --		"nvim-telescope/telescope-dap.nvim",
  --	},
  --})
  --use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })

  if PACKER_BOOTSRAP then
    require("packer").sync()
  end
end)
