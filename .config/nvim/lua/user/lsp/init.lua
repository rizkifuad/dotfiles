local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.plugins.fidget"
require "user.plugins.null-ls"

local servers = { "jsonls", "cssls", "tsserver", "lua_ls", "gopls", "html", "rust_analyzer", "astro" }

require("mason").setup()

local mason_lspconfig = require 'mason-lspconfig'

require("user.lsp.handlers").setup()

mason_lspconfig.setup {
  ensure_installed = servers,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.langs" .. server_name)
    if has_custom_opts then
      opts.settings = server_custom_opts
    end

    lspconfig[server_name].setup(opts)
  end,
}


local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_ok then
  return
end

mason_nvim_dap.setup {
  automatic_setup = true,

  ensure_installed = {
    'delve',
  },
}
mason_nvim_dap.setup_handlers()
