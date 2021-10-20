vim.cmd('let mapleader=","')
map('n', '<leader>q', '<cmd>q<cr>')
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>b', '<cmd>b#<cr>')
map('n', '<leader>t', '<cmd>tabnew<cr>')
map('n', '<leader>,', '<cmd>tabnew<cr><cmd>lcd ~/.config/nvim<cr><cmd>e init.lua<cr>')
map('n', '<leader><space>', '<cmd>nohlsearch<cr>')
map('n', '<C-y>', '3<C-y>')
map('n', '<C-e>', '3<C-e>')

map('n', ';', ':')
map('v', ';', ':')
map('n', 'j', 'gj')
map('n', 'k', 'gk')

vim.cmd([[
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
]])

map('n', '<C-h>', ':call WinMove("h")<cr>', {silent=true})
map('n', '<C-j>', ':call WinMove("j")<cr>', {silent=true})
map('n', '<C-k>', ':call WinMove("k")<cr>', {silent=true})
map('n', '<C-l>', ':call WinMove("l")<cr>', {silent=true})

map('n', '[<space>', ':<c-u>put! =repeat(nr2char(10), v:count1)<cr>')
map('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>')

map('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>')
map('n', ']e', ':<c-u>execute "move +". v:count1<cr>')

map('n', '<space>r', '<cmd>lua require"plugins.plenary".reload_config()<cr>')

map('n', 'Y', 'y$')

map('v', '.', ':norm .<cr>')
map('x', '>', '>gv')
map('x', '<', '<gv')

map('n', '<space>ss', ':mksession! ~/.cache/nvim/sessions/*.vim<bs><bs><bs><bs><bs>')
map('n', '<space>sl', ':so ~/.cache/nvim/sessions/*.vim<c-d><bs><bs><bs><bs><bs>')

map('n', '<leader>2',':set tabstop=2 shiftwidth=2 softtabstop=2<CR>')
map('n', '<leader>4',':set tabstop=4 shiftwidth=4 softtabstop=4<CR>')
map('n', '<leader>8',':set tabstop=8 shiftwidth=8 softtabstop=8<CR>')

