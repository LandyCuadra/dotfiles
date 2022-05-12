local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	print("nvim-lsp-installer not installed")
	return
end

local servers = {
	"bashls",
	"cssls",
	"html",
	"intelephense",
	"pyright",
	"sumneko_lua",
	"tsserver",
	"yamlls",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  jsonls = require("conf.lsp.settings.jsonls"),
  sumneko_lua = require("conf.lsp.settings.sumneko_lua"),
  pyright = require("conf.lsp.settings.pyright"),
}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("conf.lsp.handlers").on_attach,
		capabilities = require("conf.lsp.handlers").capabilities,
    flags= {
      debounce_text_changes = 150,
    }
	}

	if enhance_server_opts[server.name] then
		opts = vim.tbl_deep_extend("force", enhance_server_opts[server.name], opts)
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
