local autopairs = require('nvim-autopairs')
autopairs.setup({
  map_cr = true,
  map_bs = true,
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- vim.keymap.set("i", "<CR>", function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
--   end
--
--   return autopairs.autopairs_cr()
-- end, {
--   expr = true,
--   replace_keycodes = false,
-- })
