vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

vim.cmd.colorscheme('habamax')

vim.api.nvim_set_hl(0, "StatusLine", { fg = "white", bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "white", bg = "NONE" })
vim.api.nvim_set_hl(0, 'Normal', {
  bg = 'none',
})
vim.api.nvim_set_hl(0, 'NormalFloat', {
  bg = 'none',
})

vim.opt.shell = '/bin/dash'
vim.opt.clipboard:append('unnamedplus')
vim.opt.scrolloff = 10
vim.opt.mouse = ''
vim.opt.guicursor = ''
vim.opt.swapfile = false
vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.undofile = true

vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    require('autopair').setup_autopairs()
  end,
})
require('lsp')
require('keymaps')
vim.pack.add({
  "https://github.com/saghen/blink.cmp",
})
