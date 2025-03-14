return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", },

    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default", },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", },
      },

      completion = {
        menu = { border = "rounded", },

        documentation = {
          auto_show = true,
          window = { border = "rounded", },
        },

        accept = {
          auto_brackets = { enabled = true, },
        },
      },

      cmdline = {
        completion = { menu = { auto_show = true, }, },
      },

      signature = {
        enabled = true,
        window = { border = "rounded", },
      },

      fuzzy = { implementation = "prefer_rust_with_warning", },
    },
    opts_extend = { "sources.default", },
  },
}
