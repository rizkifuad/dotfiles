lvim.leader = ","


lvim.builtin.which_key.mappings["w"] = { "<cmd>w<cr>", "Save"}
lvim.builtin.which_key.mappings["q"] = { "<cmd>q<cr>", "Quit"}
lvim.builtin.which_key.mappings["t"] = { "<cmd>tabnew<cr>", "New Tab"}
lvim.builtin.which_key.mappings[","] = { "<cmd>tabnew<cr><cmd>lcd ~/.config/lvim<cr><cmd>e config.lua<cr>", "Edit Config"}
lvim.builtin.which_key.mappings["b"] = { "<cmd>b#<cr>", "Previous Buffer"}
lvim.builtin.which_key.mappings["/"] = nil
lvim.builtin.which_key.mappings["c"] = { "<cmd>CommentToggle<cr>", "Toggle Comment"}
lvim.builtin.which_key.vmappings["c"] = { ":CommentToggle<cr>", "Toggle Comment"}
lvim.builtin.which_key.mappings["a"] = { "<cmd>execute('lcd '.getcwd())<cr><cmd>NvimTreeToggle<cr>", "Explorer"}

lvim.keys.normal_mode["<space><space>"] = ":Telescope projects<CR>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<CR>"

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

lvim.keys.normal_mode["<C-h>"] = ":call WinMove('h')<CR>"
lvim.keys.normal_mode["<C-j>"] = ":call WinMove('j')<CR>"
lvim.keys.normal_mode["<C-k>"] = ":call WinMove('k')<CR>"
lvim.keys.normal_mode["<C-l>"] = ":call WinMove('l')<CR>"

lvim.keys.normal_mode["<C-e>"] = "3<C-e><CR>"
lvim.keys.normal_mode["<C-y>"] = "3<C-y><CR>"

vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = false, silent = false })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = false, silent = false })


lvim.keys.normal_mode['<space>t'] = "<cmd>Trouble lsp_workspace_diagnostics<cr>"
lvim.keys.normal_mode['[g'] = "<Cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>"
lvim.keys.normal_mode[']g'] = "<Cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>"

lvim.lsp.buffer_mappings.normal_mode['gr'] = { "<Cmd>Telescope lsp_references<cr>", "Go to references" }
