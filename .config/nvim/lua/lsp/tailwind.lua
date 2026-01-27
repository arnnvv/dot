vim.lsp.config('tailwindcss', {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html',
    'css',
    'typescriptreact',
    'svelte',
    'vue',
    'astro',
  },
  root_markers = {
    'postcss.config.mjs',
    'postcss.config.ts',
    'package.json',
    'node_modules',
  },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        htmlangular = 'html',
        templ = 'html',
      },
      lint = {
        cssConflict = 'error',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'error',
      },
      validate = true,
    },
  },
})

vim.lsp.enable('tailwindcss')
