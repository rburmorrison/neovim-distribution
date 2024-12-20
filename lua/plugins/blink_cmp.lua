return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", },

    version = "v0.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default", },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        menu = { border = "rounded", },
        documentation = {
          auto_show = true,
          window = { border = "rounded", },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", },
      },

      signature = {
        enabled = true,
        window = { border = "rounded", },
      },
    },

    opts_extend = { "sources.default", },
  },
}
