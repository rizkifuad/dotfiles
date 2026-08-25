return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  cmd = { 'typescript-language-server', '--stdio' },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"),
        languages = { "vue", "javascript", "typescript" },
      },
    },
  },
}
