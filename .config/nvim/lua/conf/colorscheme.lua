local colorscheme = "gruvbox-material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	print("colorscheme " .. colorscheme .. " not found!")
	return
end

