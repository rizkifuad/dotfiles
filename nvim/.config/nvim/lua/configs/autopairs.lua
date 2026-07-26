local autopairs = require('nvim-autopairs')
autopairs.setup({
  map_cr = false,
  map_bs = true,
})

vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
  end

  return autopairs.autopairs_cr()
end, {
  expr = true,
  replace_keycodes = false,
})
