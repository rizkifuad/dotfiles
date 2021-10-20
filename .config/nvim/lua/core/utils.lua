function _G.ReloadConfig()
    local hls_status = vim.v.hlsearch
    for name,_ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
end

function _G.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.api.nvim_exec([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200}
    augroup end
    au BufEnter * set fo-=c fo-=r fo-=o
]], false)

