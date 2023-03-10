require("user.lsp.settings.dart.prefixes")
local color = require("user.lsp.settings.dart.color")

vim.cmd [[
autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePost *.dart silent !tmux send-keys -t1 r
]]

vim.api.nvim_create_autocmd(
  { "TextChanged", "InsertLeave" }, {
  pattern = "*.dart",
  callback = function()
    color.document_color()
  end
})


return {
  init_options = {
    closingLabels = true,
    outline = true,
  },

  -- capabilities = capabilities,

  handlers = {
    ['dart/textDocument/publishClosingLabels'] = require("lsp_extensions.dart.closing_labels").get_callback({ highlight = "Special", prefix = " >> " }),
    ['dart/textDocument/publishOutline'] = require("lsp_extensions.dart.outline").get_callback(),
    ['textDocument/documentColor'] = function(_, result, ctx, _)
      local client_id = ctx.client_id
      local bufnr = ctx.bufnr
      color.buf_clear_color(client_id, bufnr)
      if not result then
        return
      end
      for _, color_info in ipairs(result) do
        local rgba, range = color_info.color, color_info.range
        local r, g, b, a = rgba.red * 255, rgba.green * 255, rgba.blue * 255, rgba.alpha
        local rgb = color.rgba_to_rgb({ r = r, g = g, b = b, a = a }, color.get_background_color())


        color.color_virtual_text(client_id, bufnr, range, rgb, "■")
      end
    end
  }
}
