vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  settings = {
    autoformat = false,
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
      cargo = { features = 'all' },
    },
  },
})

vim.lsp.enable('rust_analyzer')
