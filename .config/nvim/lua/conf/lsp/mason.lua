local servers = {
	"lua_ls",
	"cssls",
	"html",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"intelephense",
}

local serverLspConfig = {}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("conf.lsp.handlers").on_attach,
		capabilities = require("conf.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]
	server = serverLspConfig[server] or server

	local require_ok, conf_opts = pcall(require, "conf.lsp.settings." .. server)

	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	local ok = pcall(function()
		vim.lsp.config(server, opts)
	end)

	if ok then
		vim.lsp.enable(server)
	end
end
