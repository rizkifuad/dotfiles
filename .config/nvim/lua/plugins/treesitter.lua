local M = {}

function M.setup()
    local options = {
        ensure_installed = {
            "bash",
            "lua",
            "html",
            "javascript",
            "css",
            "json",
            "yaml",
            "rust",
            "go",
            "typescript",
        },
        matchup = {
            enable = false, -- mandatory, false will disable the whole extension
            -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = true,
            -- use_languagetree = true,
            disable = { "latex" },
        },
        context_commentstring = {
            enable = false,
            config = { css = "// %s" },
        },
        indent = {
            enable = true,
            disable = { "python" },
        },
        -- windwp/nvim-autopairs
        autopairs = {
            enable = true,
        },
        -- windwp/nvim-ts-autotag
        autotag = {
            enable = true,
            filetypes = { "html", "xml" },
        },
    }

    require("nvim-treesitter.configs").setup(options)
end

return M
