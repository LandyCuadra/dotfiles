-- let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
-- if empty(glob(data_dir . '/autoload/plug.vim'))
--   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
-- endif

require("conf.basic")
require("conf.keymaps")
require("conf.plugins")
require("conf.nvim-tree")
require("conf.which-key")
require("conf.bufferline")
require("conf.lualine")
require("conf.autopairs")
require("conf.comment")
require("conf.indentline")
require("conf.nvim-web-devicons")
require("conf.gitsigns")
require("conf.nvim-colorizer")
require("conf.colorscheme")
require("conf.telescope")
require("conf.treesitter")
-- require("conf.toggleterm")
require("conf.lsp")
require("conf.cmp")
-- require('conf.dap-nvim')

-- require('conf.coc.coc-nvim')
