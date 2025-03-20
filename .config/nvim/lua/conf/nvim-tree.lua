local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Vertical Split"))
end

-- following options are the default
nvim_tree.setup({
	on_attach = on_attach,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_root = {
      enable = true,
    },
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	view = {
		-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		width = "30%",
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = "right",
		number = true,
		relativenumber = true,
	},
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
  tab = {
    sync = {
      open = true
    }
  },
	-- updates the root directory of the tree on `DirChanged` (when you run `:cd` usually)
	sync_root_with_cwd = false,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
  filters = {
    dotfiles = false,
    git_ignored = false,
  }
})
