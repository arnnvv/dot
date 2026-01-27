vim.keymap.set('n', '<leader>n', ':Explore<CR>')
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set(
  'n',
  '<C-s>',
  vim.lsp.buf.definition,
  {
    noremap = true,
    silent = true,
  }
)
vim.keymap.set(
  'n',
  '<C-a>',
  function()
    vim.diagnostic.jump({ count = 1, float = true })
  end,
  {
    silent = true,
    noremap = true,
    desc = "Next Diagnostic",
  }
)
vim.keymap.set(
  'n',
  '<C-p>',
  function()
    require('fzf').find_files()
  end,
  {
    noremap = true,
    silent = true,
  }
)
vim.keymap.set(
  'n',
  '<C-n>',
  function()
    require('fzf').grep_project()
  end,
  {
    noremap = true,
    silent = true,
  }
)
