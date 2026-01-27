local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.go', 'go.mod', 'go.work', '*.gotmpl' },
  callback = function()
    require('lsp.gopls')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.json', '*.jsonc' },
  callback = function()
    require('lsp.jsonls')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = {
    '*.ts',
    '*.js',
    '*.tsx',
    'package.json',
  },
  callback = function()
    require('lsp.ts')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = {
    '*.html',
    '*.css',
    '*.tsx',
    '*.svelte',
    '*.vue',
    '*.astro',
  },
  callback = function()
    require('lsp.tailwind')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.dart' },
  callback = function()
    require('lsp.dart')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.zig', '*.zir' },
  callback = function()
    require('lsp.zls')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.c', '*.cpp', '*.h', '*.hpp', '*.m', '*.mm', '*.cu', '*.proto' },
  callback = function()
    require('lsp.clangd')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.rs' },
  callback = function()
    require('lsp.rust')
  end,
  once = true,
})

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  pattern = { '*.py' },
  callback = function()
    require('lsp.pyright')
  end,
  once = true,
})
