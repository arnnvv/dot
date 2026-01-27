vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '-j=' .. 2,
    '--background-index',
    '--clang-tidy',
    '--inlay-hints',
    '--fallback-style=llvm',
    '--all-scopes-completion',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--header-insertion-decorators',
    '--pch-storage=memory',
  },
  filetypes = {
    'c',
    'cpp',
    'objc',
    'cuda',
    'proto',
    'objcpp',
    },
  root_markers = {
    'CMakeLists.txt',
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
    vim.uv.cwd(),
  },
})

vim.lsp.enable('clangd')
