function _G.telescope_symbols()
    local opts= {
        symbols = {
            "function",
            "constructor",
            "method",
        }
    }
    require('telescope.builtin').lsp_document_symbols(opts)
end

function _G.telescope_code_actions()
    local opts = {
        winblend = 15,
        layout_config = {
            prompt_position = "top",
            width = 80,
            height = 12,
        },
        borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        border = {},
        previewer = false,
        shorten_path = false,
    }
    require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_dropdown(opts))
end

local M = {}

function M.setup()
    local telescope = require'telescope'
    telescope.setup{
       extensions = {
           fzy_native = {
               override_generic_sorter = false,
               override_file_sorter = true,
           }
       }
    }
    require'project_nvim'.setup {
        manual_mode = false,
        detection_methods = { 'lsp', 'pattern' },
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        datapath = vim.fn.stdpath('data'),
    }

    telescope.load_extension('projects')
    telescope.load_extension('fzy_native')

    map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
    map('n', '\\', '<cmd>Telescope buffers<cr>')
    map('n', '<space><space>', '<cmd>Telescope projects<cr>')
    map('n', '<leader>f', '<cmd>Telescope live_grep<cr>')
    map('n', '<space>o', '<cmd>lua telescope_symbols()<cr>')
    vim.cmd('autocmd! FileType TelescopePrompt imap <esc> <c-c>')
end

return M
