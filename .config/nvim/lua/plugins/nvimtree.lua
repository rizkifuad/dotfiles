local M = {}

function M.setup()
    require'nvim-tree'.setup {
        auto_close = true,
        view = {
            side = 'right'
        },
        update_cwd = true,
        update_focused_file = {
            enable = true,
        }
    }

    map('n','<leader>a', '<cmd>NvimTreeToggle<cr>')
    map('n','<leader>k','<cmd>NvimTreeFindFile<cr>')
    vim.cmd('let g:nvim_tree_disable_window_picker = 1')
end

return M
