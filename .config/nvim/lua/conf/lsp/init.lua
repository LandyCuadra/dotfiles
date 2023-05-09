local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("lspconfig not found")
  return
end

require("conf.lsp.mason")
require("conf.lsp.handlers").setup()
require("conf.lsp.null-ls")
