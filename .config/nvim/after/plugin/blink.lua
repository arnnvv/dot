require("blink.cmp").setup({
  appearance = {
    nerd_font_variant = "mono",
  },
  keymap = {
    preset = "enter",
  },
  completion = {
    documentation = {
      auto_show = false,
    },
  },
  sources = {
    default = {
      "lsp",
      "path",
      "buffer",
    },
  },
  cmdline = {
    enabled = false,
  },
  fuzzy = {
    implementation = "rust",
    prebuilt_binaries = { force_version = "v1.8.0" }
  },
})
