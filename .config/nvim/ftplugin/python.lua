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

dap.adapters.python = {
  type = 'executable',
  command = fn.stdpath("data") .. '/dapinstall/python/bin/python3',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
        return cwd .. '/venv/bin/python3'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
        return cwd .. '/.venv/bin/python3'
      else
        return '/usr/bin/python3'
      end
    end
  },
}

