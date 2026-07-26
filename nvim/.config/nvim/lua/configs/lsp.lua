
-- Setup LSP

-- Add each lsp server you want to enable here
-- Add the config to the lsp folder
-- Each LSP server will be added by Mason and enabled
local lsp_servers = { "jsonls", "cssls", "gopls", "html", "rust_analyzer", "astro", "ts_ls", "vue_ls", "intelephense", "tailwindcss", "lua_ls"}

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = lsp_servers,
  automatic_enable = false,
})

-- Enable snippets (built in)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
capabilities.textDocument.documentSymbol = {
  dynamicRegistration = false,
  hierarchicalDocumentSymbolSupport = true, -- <--- Enabler for nested outline symbols
}

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Enable LSP completion (this connects LSP to the native menu)
local function has_lsp_config(server_name)
  local config_path = vim.fn.stdpath("config")
  local target_path = vim.fs.joinpath(config_path, "lsp", server_name .. ".lua")
  if vim.uv.fs_stat(target_path) then
    return true
  else
    return false
  end
end

vim.iter(lsp_servers):each(
function(lsp_server)
  if not has_lsp_config(lsp_server) then
    vim.api.nvim_echo({ { 'Warning. lsp server ' .. lsp_server .. ' has no config file in the config lsp folder.' , 'WarningMsg' } }, true, {})
    else
      vim.lsp.enable(lsp_server)
  end
end
)

vim.diagnostic.config({
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",{ undercurl=true, bg = C.base, fg = C.red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl=true, bg = C.base, fg = C.blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl=true, bg = C.base, fg = C.yellow })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl=true, bg = C.base, fg = C.teal })

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {  fg = C.blue })
