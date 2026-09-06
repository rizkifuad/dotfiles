local my_augroup = vim.api.nvim_create_augroup('CustomSettings', { clear = true })

vim.api.nvim_create_autocmd('TermEnter', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('TermLeave', {
  group = vim.api.nvim_create_augroup('custom-term-leave', { clear = true }),
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = my_augroup,
  pattern = '*', -- apply to all filetypes
  callback = function()
    -- This fixes annoying auto comments on newline
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
  desc = 'Disable auto-commenting on new lines'
})

pcall(vim.keymap.del, 'n', 'grn')
pcall(vim.keymap.del, 'n', 'gra')
pcall(vim.keymap.del, 'n', 'grr')
pcall(vim.keymap.del, 'n', 'gri')
pcall(vim.keymap.del, 'n', 'grt')
pcall(vim.keymap.del, 'n', 'grx')

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    if not client_id then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client and client:supports_method("textDocument/completion") then
      -- Enable native LSP completion for this client + buffer
      vim.lsp.completion.enable(true, client_id, args.buf, {
        autotrigger = true, -- auto-show menu as you type (recommended)
      })
    end

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gD', function() MiniExtra.pickers.lsp({ scope = "declaration" }) end, '[G]oto [D]eclaration')
    map('<space>f', vim.lsp.buf.format, 'Format')
    map('gO', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, 'Document symbol')
    map('<space>o', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, 'Document symbol')
    map('gr', function() MiniExtra.pickers.lsp({ scope = 'references' }) end, 'References')
    map('gi', function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end, 'Implementations')
    map('<leader>dn', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Diagnostic Next')
    map('<leader>dp', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Diagnostic Previous')
    map('<leader>dc', vim.diagnostic.open_float, 'Diagnostic Open')
    map('<space>e', vim.diagnostic.open_float, 'Diagnostic Open')
    map('<leader>da', function() MiniExtra.pickers.diagnostic() end, 'Diagnostic List')
    map('<leader>lc', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>lr', vim.lsp.buf.rename, 'Rename')

  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      -- Get current window details before jumping
      local is_loclist = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1

      -- Execute the jump (simulating the default Enter key)
      local keys = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
      vim.api.nvim_feedkeys(keys, "n", false)

      -- Close the correct list type
      vim.schedule(function()
        if is_loclist then
          vim.cmd("lclose")
        else
          vim.cmd("cclose")
        end
      end)
    end, { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    -- Sync request ensures imports finish BEFORE the file writes to disk
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})


vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    vim.b.did_indent = 1
    pcall(vim.treesitter.start, args.buf)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "slint" },
  callback = function(args)
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "blade", "vue" },
  callback = function(args)
    -- Fungsi map lokal untuk buffer ini saja
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = args.buf, desc = desc })
    end

    -- Pemetaan tombol format khusus Blade dan Vue
    map('<space>f', function()
      require("conform").format({ bufnr = args.buf })
    end, 'Format')
  end,
})
