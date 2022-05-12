local set = vim.opt

local options = {
	tabstop = 4,
	softtabstop = 4, -- Insert 2 spaces for a tab
	shiftwidth = 4, -- Change the number of space characters inserted for indentation
}

for k, v in pairs(options) do
	set[k] = v
end

local dapi_status_ok, dap_install = pcall(require, "dap-install")
if not dapi_status_ok then
	return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dapvt_status_ok, dapvt = pcall(require, "nvim-dap-virtual-text")
if not dapvt_status_ok then
	return
end

local fn = vim.fn

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

local dap_breakpoint = {
	breakpoint = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	},
	rejected = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

dapvt.setup({
	commented = true,
})

dapui.setup({}) -- use default
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { fn.stdpath("data") .. '/dapinstall/php/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9005
  }
}
