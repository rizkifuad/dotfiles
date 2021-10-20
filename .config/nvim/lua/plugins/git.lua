local M = {}

function M.setup_gitlinker()
    local job = require 'plenary.job'
    require("gitlinker").setup {
        opts = {
            add_current_line_on_normal_mode = true,
            action_callback = function(url)
                -- default open in chrome
                local command = {command = 'open', args = {url, '-a', '/Applications/Google Chrome.app'}}
                if url:find('kata-ai', 1, true) then
                    command = {command = 'open', args = {url}}
                end
                job:new(command):start()
            end,
            print_url = false,
        },
        callbacks = {
            ["gitlab.com"] = function(url_data)
                url_data.host = "gitlab.com"
                return
                require"gitlinker.hosts".get_gitlab_type_url(url_data)
            end,
        }
    }
end

function M.setup_config()
    map('n', '<leader>gs', '<cmd>Git<cr>')
    map('n', '<leader>gc', '<cmd>Git commit<cr>')
    map('n', '<leader>gn', ':Git checkout -b ')
    map('n', '<leader>gg', ':execute ":Git pull origin " . fugitive#head(0)<CR>')
    map('n', '<leader>gp', ':execute ":Git push origin " . fugitive#head(0)<CR>')
    map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>')
    map('n', '<leader>gx', '<cmd>GitBlameToggle<cr>')
    vim.api.nvim_set_keymap('n', '<leader>go', '<cmd>:lua require"gitlinker".get_buf_range_url("n")<cr>', {silent = true})
    vim.api.nvim_set_keymap('v', '<leader>go', '<cmd>:lua require"gitlinker".get_buf_range_url("v")<cr>', {silent = true})

    vim.cmd('let g:gitblame_enabled = 0')
end

return M
