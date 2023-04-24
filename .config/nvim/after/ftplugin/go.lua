local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4
vo.expandtab = false

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>dr', function()
  vim.cmd("silent !killall dlv && tmux send-keys -t 1 'godb cmd/xms/main.go' Enter")
  require('dap').restart()
end, opts)
