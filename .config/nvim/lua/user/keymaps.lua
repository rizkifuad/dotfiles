local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap colon as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- TODO: convert to lua
vim.cmd[[
function! OpenConfig()
  exec "tabnew"
  exec "lcd ~/.config/nvim"
  exec "e init.lua"
endfunction
]]
vim.cmd([[
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
]])

-- Normal --
keymap('n', '<C-y>', '3<C-y>', opts)
keymap('n', '<C-e>', '3<C-e>', opts)

keymap('n', ';', ':', { silent = false })
keymap('v', ';', ':', { silent = false })
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)


-- Basic Navigation
keymap('n', '<leader>b', '<cmd>b#<cr>', opts)
--[[ keymap('n', '<leader>a', '<cmd>NeoTreeFocusToggle<cr>', opts) ]]
keymap('n', '<leader>a', '<cmd>NeoTreeRevealToggle<cr>', opts)
keymap('n', '<leader>k', '<cmd>NeoTreeReveal<cr>', opts)
keymap('n', '<leader>z', '<cmd>NeoTreeFloatToggle<cr>', opts)
keymap('n', '<leader>r', '<cmd>Telescope oldfiles<cr>', opts)
keymap('n', '<leader>,', '<cmd>call OpenConfig()<cr>', opts)
keymap('n', '<leader>t', '<cmd>tabnew<cr>', opts)
keymap('n', '<leader>w', '<cmd>w!<cr>', opts)
keymap('n', '<leader>q', '<cmd>q!<cr>', opts)
keymap('n', '<leader>c', '<cmd>norm gcc<cr>', opts)
keymap('n', '<leader><space>', '<cmd>nohlsearch<cr>', opts)
--[[ keymap('n', '<leader>f', '<cmd>Telescope live_grep_args theme=ivy<cr>', opts) ]]
keymap('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2 softtabstop=2<cr>', opts)
keymap('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4 softtabstop=4<cr>', opts)
keymap('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8 softtabstop=8<cr>', opts)

-- Packer things
keymap('n', '<leader>pc', '<cmd>PackerCompile<cr>', opts)
keymap('n', '<leader>pi', '<cmd>PackerInstall<cr>', opts)
keymap('n', '<leader>pS', '<cmd>PackerSync<cr>', opts)
keymap('n', '<leader>ps', '<cmd>PackerStatus<cr>', opts)
keymap('n', '<leader>pu', '<cmd>PackerUpdate<cr>', opts)

-- Gitting
keymap('n', '<leader>gs', '<cmd>Git<cr>', opts)
keymap('n', '<leader>gc', '<cmd>Git commit<cr>', opts)
keymap('n', '<leader>gn', ':Git checkout -b ', { silent=false })
keymap('n', '<leader>gg', '<cmd>!ggpull<cr>', opts)
keymap('n', '<leader>gp', '<cmd>!ggpush<cr>', opts)
keymap('n', '<leader>go', '<cmd>:lua require"gitlinker".get_buf_range_url("v")<cr>', opts)
keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', opts)
keymap('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', opts)

-- Better window navigation

keymap('n', '<C-h>', ':call WinMove("h")<cr>', {silent=true})
keymap('n', '<C-j>', ':call WinMove("j")<cr>', {silent=true})
keymap('n', '<C-k>', ':call WinMove("k")<cr>', {silent=true})
keymap('n', '<C-l>', ':call WinMove("l")<cr>', {silent=true})

keymap('n', '[<space>', ':<c-u>put! =repeat(nr2char(10), v:count1)<cr>', opts)
keymap('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', opts)

keymap('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>', opts)
keymap('n', ']e', ':<c-u>execute "move +". v:count1<cr>', opts)

keymap("n", "<C-t>", ":tabnew<cr>:term<cr>a", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", ".", ":norm .<cr>", opts)
keymap("v", "<leader>b", ":norm gbc<cr>", opts)
keymap("v", "<leader>c", ":norm gcc<cr>", opts)
keymap("v", "go", '<cmd>:lua require"gitlinker".get_buf_range_url("v")<cr>', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

--Term--
keymap("t", "<Esc>", "<C-\\><C-n>", opts)

keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
