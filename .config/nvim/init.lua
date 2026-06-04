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
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 10
vim.opt.mouse = ''
vim.opt.guicursor = ''
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true

vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    require("lsp")
  end,
})

require('keymaps')
