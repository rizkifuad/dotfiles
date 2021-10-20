local M = {}

function M.setup()
    require("trouble").setup {}
    map('n', '<space>t', ':Trouble<cr>')
end

return M
