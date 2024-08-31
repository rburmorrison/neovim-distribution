return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              check = { command = "check", },
            },
          },
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
          end,
        },
      }
    end,
  },

  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v", }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",

      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      "onsails/lspkind.nvim",

      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mrcjkb/rustaceanvim",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true, }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", },
          { name = "vsnip", },
        }, {
          { name = "buffer", },
        }, {
          { name = "path", },
        }),
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 32,
            before = function(_, vim_item)
              vim_item.menu = ""
              return vim_item
            end,
          }),
        },
      })

      -----------------------
      -- LSP Configuration --
      -----------------------

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "emmet_language_server",
        },
      })

      ----------------------------
      -- Automatic Server Setup --
      ----------------------------

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim", }, },
              },
            },
          })
        end,
        ["rust_analyzer"] = function()
          -- Disabled in favor of rustaceanvim.
        end,
        ["html"] = function()
          require("lspconfig").html.setup({
            filetypes = { "html", "htmldjango", },
          })
        end,
      })
    end,
  },
}
