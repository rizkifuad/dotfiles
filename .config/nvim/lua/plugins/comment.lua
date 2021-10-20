local M = {}

function M.setup()
    require('nvim_comment').setup()

    map('n','<leader>c', '<cmd>CommentToggle<cr>')
    map('v','<leader>c', ':CommentToggle<cr>')
end

return M
