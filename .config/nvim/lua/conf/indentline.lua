local ibl_status_ok, ibl = pcall(require, "ibl")
if not ibl_status_ok then
	return
end

ibl.setup({
	indent = {
		char = "▏",
	},
	scope = {
		enabled = true,
		highlight = "Function",
	},
})
