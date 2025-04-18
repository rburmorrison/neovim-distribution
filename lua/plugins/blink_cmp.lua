if vim.g.vscode then
  return {}
end

return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

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
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,   -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100,   -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,   -- show at a higher priority than lsp
            opts = {},
          },
        },
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
