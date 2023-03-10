local M = {}

M.setup = function(opts)
  local status_ok, flutter_tools = pcall(require, "flutter-tools")
  if not status_ok then
    return
  end

  vim.cmd [[
  autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePost *.dart silent !tmux send-keys -t1 r
  ]]

  -- alternatively you can override the default configs
  flutter_tools.setup {
    closing_tags = {
      -- highlight = "ErrorMsg", -- highlight for the closing tag
      -- prefix = ">", -- character to use for close tag e.g. > Widget
      enabled = true -- set to false to disable
    },
    outline = {
      open_cmd = "setlocal nosplitright | 40vnew", -- command to use to open the outline buffer
      auto_open = false -- if true this will open the outline automatically when it is first populated
    },
    lsp = {
      color = { -- show the derived colours for dart variables
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = false, -- highlight the background
        foreground = false, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
      },
      on_attach = opts.on_attach,
      capabilities = opts.capabilities -- e.g. lsp_status capabilities
    }
  }
end

return M
