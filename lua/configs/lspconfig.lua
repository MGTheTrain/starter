-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- LSP Configuration for Go (gopls)
local lspconfig = require("lspconfig")

lspconfig.gopls.setup{
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  root_dir = lspconfig.util.root_pattern("go.mod"),
  settings = {
    gopls = {
      analyses = {
        unreachable_code = true,
        unused_params = true,
      },
      staticcheck = true,
    },
  },
}

-- Debugging Configuration with Delve (nvim-dap)
local dap = require('dap')

dap.adapters.go = {
  type = 'server',
  port = 38697,  -- Delve default port
  executable = {
    command = 'dlv',
    args = {'dap', '--listen=:38697', '--headless=true', '--api-version=2'}
  }
}

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    program = '${file}',
  },
}

