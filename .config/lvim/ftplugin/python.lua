lvim.lang.python.linters = {
  {
    exe = "flake8"
  }
}

local opts = {
  before_init = function(_, config)
    local stub_path = _G.join_paths(
      _G.get_runtime_dir(),
      "site",
      "pack",
      "packer",
      "opt",
      "python-type-stubs"
    )
    config.settings.python.analysis.stubPath = stub_path
  end
}

require('lvim.lsp.manager').setup('pyright', opts)

local dap_install = require "dap-install"
dap_install.config("python_dbg", {})
