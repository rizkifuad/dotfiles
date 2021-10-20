-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- for language server setup see: https://github.com/neovim/nvim-lspconfig

local nvim_lsp = require('lspconfig')
local util = require('lspconfig.util')

-- LSP sign
vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR><cmd>e!<cr>', opts)
    buf_set_keymap('n', '<leader>lc', '<Cmd>lua telescope_code_actions()<cr>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
end

local handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false
    }
    ),
}

--[[

Language servers:

Add your language server to `servers`

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

Bash --> bashls
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#bashls

Python --> pyright
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#pyright

C-C++ -->  clangd
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#clangd

HTML/CSS/JSON --> vscode-html-languageserver
https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#html

JavaScript/TypeScript --> tsserver
https://github.com/typescript-language-server/typescript-language-server

--]]

-- Set settings for language servers below
local M = {}
function M.setup()
    nvim_lsp.gopls.setup {
        handlers = handlers,
        on_attach = function()
            on_attach()
            require"plugins.lspconfig.gopls"
        end,
        capabilities = capabilities,
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            },
        },
    }


    nvim_lsp.tsserver.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
    }

    nvim_lsp.rust_analyzer.setup{
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
    }

    nvim_lsp.intelephense.setup{
        root_dir = util.root_pattern( "composer.json", ".git", "wp-content", "license.txt" ),
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
    }

    nvim_lsp.cssls.setup{
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
    }

    vim.cmd([[
    autocmd! FileType css set ft=scss
    autocmd FileType scss setl iskeyword+=@-@
    autocmd FileType scss setlocal commentstring=/*\ %s\ */
    ]])

    nvim_lsp.svelte.setup{
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities
    }

    local lua_server_dir = '/Users/rizki/.local/share/nvim/lsp_servers/sumneko_lua'
    local lua_server_binary = lua_server_dir..'/extension/server/bin/macOS/lua-language-server'
    local lua_server_root_path = lua_server_dir..'/extension/server/main.lua'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    nvim_lsp.sumneko_lua.setup {
        cmd =  {lua_server_binary,  '-E', lua_server_root_path},
        handlers = handlers,
        on_attach= on_attach,
        capabilities = capabilities,
        root_dir = util.root_pattern{'git', '.luaroot'},
        log_level = 2,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end
return M
