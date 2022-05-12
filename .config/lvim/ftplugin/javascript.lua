local formatters = require 'lvim.lsp.null-ls.formatters'

formatters.setup {
  {
    exe = "eslint_d",
    filetype = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
    }
  }
}

local linters = require 'lvim.lsp.null-ls.linters'

linters.setup  {
  {
    exe = "eslint_d",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "vue",
    },
  }
}

lvim.lsp.on_attach_callback = function (client, _)
  if client.name == "tsserver" or client.name == "jsonls" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

require("luasnip/loaders/from_vscode").load({
      paths = _G.join_paths(vim.fn.stdpath "config", "snippets", "typescript"),
    })

-- local dap_install = require "dap-install"
-- dap_install.config("jsnode_dbg", {})
