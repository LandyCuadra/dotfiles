-- local dap_install = require "dap-install"
-- dap_install.config("php_dbg", {})

lvim.autocommands.custom_groups = {
  {"BufWinEnter", "*.php", "setlocal ts=4 sw=4"}
}
