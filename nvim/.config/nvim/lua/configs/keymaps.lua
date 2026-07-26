local map = vim.keymap.set
local opts = function(desc)
  return { noremap = true, silent = true, nowait = false, desc = desc }
end

map('i', '<C-Space>', function() vim.lsp.completion.get() end, { desc = 'Trigger LSP completion' })

-- Explorer
map('n', '<leader>a', function() MiniFiles.open() end, { desc = 'Open MiniFiles explorer' })
map('n', '<leader>k', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open MiniFiles explorer' })

-- Config
map('n', '<leader><leader>l', ':luafile %<CR>', { desc = 'Lua evaluate current file' })
map('n', '<leader><leader>r', function()
  -- Define a safe location for the temporary restart session
  local session = vim.fn.stdpath('state') .. '/restart_session.vim'

  -- 1. Save the layout, tabs, and open buffers
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session))

  -- 2. Restart Neovim and immediately load that session file
  vim.cmd('restart source ' .. vim.fn.fnameescape(session))
end, { desc = 'Reload config' })
map('n', '<leader><leader>c', function()
  vim.cmd("tabnew")
  vim.cmd("lcd ~/.config/nvim")
  vim.cmd("edit init.lua")
end, { desc = 'Lua evaluate current file' })

-- Picker
map('n', '<C-p>', ':Pick files_with_hidden<cr>', opts('Pick files'))
map('n', '<Leader>f', ':Pick grep_live<cr>', opts('Pick grep_live'))


-- QoL Navigation
map('n', '<C-y>', '3<C-y>', opts("Scroll up"))
map('n', '<C-e>', '3<C-e>', opts("Scroll down"))
map('n', ';', ':', { silent = false })
map('v', ';', ':', { silent = false })
map('n', 'j', 'gj', opts("Faster down"))
map('n', 'k', 'gk', opts("Faster up"))
map('n', '[<space>', ':<c-u>put! =repeat(nr2char(10), v:count1)<cr>', opts("Create line break above"))
map('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', opts("Create line break below"))
map('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>', opts("Move line  above"))
map('n', ']e', ':<c-u>execute "move +". v:count1<cr>', opts("Move line below"))
map("n", "gl", "$", opts("Jump to first available letter"))
map("n", "gh", "^", opts("Jump to last available letter"))
map("n", "gb", function() require("mini.pick").builtin.buffers() end, opts("Buffer list"))
map("n", "s", function() require("flash").jump() end, opts("Jump"))

-- Qflist Loclist
map("n", "<leader>co", ':copen<cr>', opts("Quickfix Open"))
map("n", "<leader>cc", ':cclose<cr>', opts("Quickfix Close"))
map("n", "<leader>ca", ':cafter<cr>', opts("Quickfix After"))
map("n", "<leader>cb", ':cbefore<cr>', opts("Quickfix Before"))
map("n", "<leader>cn", ':cnext<cr>', opts("Quickfix Next"))
map("n", "<leader>cp", ':cprev<cr>', opts("Quickfix Previous"))
map("n", "<leader>lo", ':lopen<cr>', opts("Loclist Open"))
map("n", "<leader>lc", ':lclose<cr>', opts("Loclist Close"))
map("n", "<leader>la", ':lafter<cr>', opts("Loclist After"))
map("n", "<leader>lb", ':lbefore<cr>', opts("Loclist Before"))
map("n", "<leader>ln", ':lnext<cr>', opts("Loclist Next"))
map("n", "<leader>lp", ':lprev<cr>', opts("Loclist Previous"))

-- Basic Navigation
map('n', '<leader>b', '<cmd>b#<cr>', opts("Previous buffer"))
map('n', '<leader>t', '<cmd>tabnew<cr>', opts("Open new tab"))
map('n', '<leader>w', '<cmd>w!<cr>', opts("Save file"))
map('n', '<leader>q', '<cmd>q!<cr>', opts("Quit"))
map('n', '<leader><space>', '<cmd>nohlsearch<cr>', opts("Disable highlight"))
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2 softtabstop=2<cr>', opts("Tab 2"))
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4 softtabstop=4<cr>', opts("Tab 4"))
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8 softtabstop=8<cr>', opts("Tab 8"))

-- Gitting
map('n', '<leader>gs', '<cmd>Git<cr>', opts("Git status"))
map('n', '<leader>gc', '<cmd>Git commit<cr>', opts("Git commit"))
map('n', '<leader>gn', ':Git checkout -b ', { silent = false, desc = "Create new git branch" })
map('n', '<leader>gg', '<cmd>!ggpull<cr>', opts("Git pull"))
map('n', '<leader>gp', '<cmd>!ggpush<cr>', opts("Git push"))
map('n', '<leader>go', '<cmd>GitLinker<cr>', opts("Git open file in browser"))
map('n', '<leader>gb', function() require('mini.extra').pickers.git_branches() end, opts("Git branches"))
map('n', '<leader>gd', '<cmd>Gdiff HEAD<cr>', opts("Diff to head"))


-- Visual QoL --
map("v", "<", "<gv", opts("Tab forward"))
map("v", ">", ">gv", opts("Tab backward"))
map("v", ".", ":norm .<cr>", opts("Repeat"))
--map("v", "go", '<cmd>:lua require"gitlinker".get_buf_range_url("v")<cr>', opts)


-- Debugging
map("n", "<leader>xb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts("Toggle Line Break"))
map("n", "<leader>xc", "<cmd>lua require'dap'.continue()<cr>", opts("Continue"))
map("n", "<leader>xi", "<cmd>lua require'dap'.step_into()<cr>", opts("Step into"))
map("n", "<leader>xo", "<cmd>lua require'dap'.step_over()<cr>", opts("Step over"))
map("n", "<leader>xO", "<cmd>lua require'dap'.step_out()<cr>", opts("Step out"))
map("n", "<leader>x.", "<cmd>lua require'dap'.repl.toggle()<cr>", opts("Repl Toggl"))
map("n", "<leader>xl", "<cmd>lua require'dap'.run_last()<cr>", opts("Run last"))
map("n", "<leader>xu", "<cmd>lua require'dapui'.toggle()<cr>", opts("DapUI Toggl"))
map("n", "<leader>xt", "<cmd>lua require'dap'.terminate()<cr>", opts("DapTerminal"))


-- Codeium --
map('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true })
map('i', '<c-l>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
map('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
map('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })


-- WinMove GOAT
local function win_move(key)
  local curwin = vim.fn.winnr()

  -- try move
  vim.cmd("wincmd " .. key)

  -- if still in same window, create split
  if curwin == vim.fn.winnr() then
    if string.match(key, "[jk]") then
      vim.cmd("wincmd s") -- vertical split
    else
      vim.cmd("wincmd v") -- horizontal split
    end

    -- move again
    vim.cmd("wincmd " .. key)
  end
end

vim.api.nvim_create_user_command("WinMove", function(opts)
  win_move(opts.args)
end, { nargs = 1 })

map("n", "<C-h>", function() win_move("h") end)
map("n", "<C-j>", function() win_move("j") end)
map("n", "<C-k>", function() win_move("k") end)
map("n", "<C-l>", function() win_move("l") end)
