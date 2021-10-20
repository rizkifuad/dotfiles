local M = {}
function M.reload_config()
    local plenary = require'plenary.reload'
    plenary.reload_module('core', true)
    plenary.reload_module('plugins', true)
    dofile(vim.env.MYVIMRC)
    vim.cmd [[PackerCompile]]
    print"Neovim config reloaded"
end

return M
