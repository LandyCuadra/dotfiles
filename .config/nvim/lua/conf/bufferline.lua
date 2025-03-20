local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
bufferline.setup({
	options = {
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
	},
})

keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-[>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<C-]>", ":BufferLineMoveNext<CR>", opts)
