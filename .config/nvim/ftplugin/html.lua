local set = vim.opt

local options = {
  tabstop = 4,
  softtabstop = 4, -- Insert 4 spaces for a tab
  shiftwidth = 4, -- Change the number of space characters inserted for indentation
}

for k, v in pairs(options) do
  set[k] = v
end
