vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = vim.fs.root(0, { 'go.work', 'go.mod', '.git' }),
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = { unusedparams = true },
      completeUnimported = true,
      hints = {
        parameterNames = true,
        constantValues = true,
        rangeVariableTypes = true,
        assignVariableTypes = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
        compositeLiteralFields = true,
      },
    },
  },
})

vim.lsp.enable('gopls')
