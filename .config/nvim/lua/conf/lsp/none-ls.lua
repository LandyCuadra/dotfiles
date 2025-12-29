local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("null_ls not found")
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup {
  debug = true,
  sources = {
    --Javascript
    require("none-ls.formatting.eslint"),
    require("none-ls.diagnostics.eslint"),
    -- diagnostics.tsc,

    --Python
    formatting.black.with { extra_args = { "--fast" } },
    require("none-ls.diagnostics.flake8"),

    --PHP
    --formatting.phpcsfixer,
    --diagnostics.php,

    --Lua
    formatting.stylua,
    -- diagnostics.luacheck,
  },
}
