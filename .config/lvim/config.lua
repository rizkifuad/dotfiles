-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- general
lvim.format_on_save = true
lvim.lint_on_save = false
lvim.colorscheme = "dogrun"
lvim.transparent_window = true
vim.opt.cmdheight = 1
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.splitbelow = false
vim.opt.fillchars = "vert:|"
vim.cmd([[
set diffopt+=vertical " Set vertical diff window
" Terminal config
autocmd! FileType TelescopePrompt imap <esc> <c-c>
let g:nvim_tree_disable_window_picker = 1
]])


-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"

lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.project.detection_methods = {"pattern"}
lvim.builtin.project.active = true
lvim.builtin.project.silent_chdir = true
lvim.builtin.bufferline.active = false

-- Additional Plugins
lvim.plugins = {
    {'wadackel/vim-dogrun'},
    {'mattn/emmet-vim'},
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {'seblj/nvim-tabline', requires = {'kyazdani42/nvim-web-devicons'}},
    {'folke/lsp-colors.nvim'},
    {'lumiliet/vim-twig'},
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
            vim.cmd "highlight default link gitblame SpecialComment"
            vim.g.gitblame_enabled = 0
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        event = "BufRead",
        config = function()
            require("gitlinker").setup {
                opts = {
                    -- remote = 'github', -- force the use of a specific remote
                    -- adds current line nr in the url for normal mode
                    add_current_line_on_normal_mode = true,
                    -- callback for what to do with the url
                    action_callback = require("gitlinker.actions").open_in_browser,
                    -- print the url after performing the action
                    print_url = false,
                    -- mapping to call url generation
                    mappings = "<leader>gy",
                },
                callbacks = {
                    ["gitlab.com"] = function(url_data)
                        url_data.host = "gitlab.com"
                        return
                            require"gitlinker.hosts".get_gitlab_type_url(url_data)
                    end,
                }
            }
        end,
        requires = "nvim-lua/plenary.nvim",
    },
}

require('tabline').setup{
    no_name = 'Untitled',    -- Name for buffers with no name
    modified_icon = '●',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "▎",          -- Separator icon on the left side
    padding = 3,              -- Prefix and suffix space
    color_all_icons = false,  -- Color devicons in active and inactive tabs
    always_show_tabs = true, -- Always show tabline
    right_separator = true,  -- Show right separator on the last tab
}

vim.cmd "au ColorScheme * hi TabLineSel cterm=bold ctermfg=235 ctermbg=104 gui=bold guifg=#a0a2c2 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineFill cterm=bold ctermfg=235 ctermbg=104 gui=bold guifg=#ff0000 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLinePaddingActive guifg=#929be5 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineCloseActive guifg=#eeeeee guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineSeparatorActive guifg=#b872b9 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineModifiedActive guifg=#ad7c21 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineModifiedSeparatorActive guifg=#ad7c21 guibg=#222432"
vim.cmd "au ColorScheme * hi TabLineFill cterm=bold ctermfg=235 ctermbg=104 guifg=#a0a2c2 guibg=#2a2c3e gui=none"
vim.cmd "au ColorScheme * hi TabLineSeparatorInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLineCloseInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLineCloseInactive guifg=#7f8490 guibg=#2a2c3f"
vim.cmd "au ColorScheme * hi TabLinePaddingInactive guifg=#2a2c3f guibg=#2a2c3f"

lvim.lang.rust.formatters = { { exe = 'rustfmt' } }
lvim.lang.go.formatters = {{ exe = "goimports" }}


-- keymappings [view all the defaults by pressing <leader>Lk]
require("customkeymap")
