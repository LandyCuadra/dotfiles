local set = vim.opt

local options = {
	exrc = true,
	fileencoding = "utf-8", -- The encoding displayed
	cmdheight = 2, -- More space for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	smartcase = true,
	smartindent = true,
	splitbelow = true, -- Horizontal splits will automatically be below
	splitright = true, -- Vertical splits will automatically be to the right
	relativenumber = true,
	hlsearch = true,
	hidden = true, -- Required to keep multiple buffers open multiple buffers
	mouse = "a", -- Enable your mouse
	tabstop = 2,
	softtabstop = 2, -- Insert 2 spaces for a tab
	shiftwidth = 2, -- Change the number of space characters inserted for indentation
	expandtab = true, -- Converts tabs to spaces
	number = true, -- Line number
	wrap = false, -- Display long lines as just one line
	-- set background=dark                     -- tell vim what the background color looks like
	ignorecase = true,
	showtabline = 2, -- Always show tabs
	swapfile = false,
	backup = false, -- This is recommended by coc
	writebackup = false, -- This is recommended by coc
	updatetime = 300, -- Faster completion
	timeoutlen = 300, -- By default timeoutlen is 1000 ms
	clipboard = "unnamedplus", -- Copy paste between vim and everything else
	undodir = vim.fn.stdpath("config") .. "/undodir",
	undofile = true,
	incsearch = true,
	termguicolors = true,
	scrolloff = 5,
	signcolumn = "yes",
	colorcolumn = "100",
	wildoptions = "pum",
	fcs = "fold:-", -- verticle split is just bg color
	foldcolumn = "0", -- visual representation of folds
	foldmethod = "syntax",
	foldnestmax = 4,
	foldenable = false,
	cursorline = true,
	lazyredraw = true,
	synmaxcol = 128,
}

for k, v in pairs(options) do
	set[k] = v
end

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.loader.enable()
vim.opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
set.formatoptions:remove({ "c", "r", "o" }) -- Stop newline continution of comments
vim.cmd("filetype plugin on")

vim.api.nvim_command([[
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=500}
]])
