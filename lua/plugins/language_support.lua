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
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mrcjkb/rustaceanvim",
    },
    keys = {
      { "<leader>tt",  "<cmd>lua require('neotest').run.run()<cr>",                        mode = "n", desc = "Run Closest Test", },
      { "<leader>tq",  "<cmd>lua require('neotest').run.stop<cr>",                         mode = "n", desc = "Stop Closes Test", },
      { "<leader>tf",  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",      mode = "n", desc = "Run File Tests", },
      { "<leader>ts",  "<cmd>lua require('neotest').summary.toggle()<cr>",                 mode = "n", desc = "Toggle Summary", },
      { "<leader>tw",  "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>", mode = "n", desc = "Toggle Watch", },
      { "<leader>too", "<cmd>lua require('neotest').output.open()<cr>",                    mode = "n", desc = "Open Test Output", },
      { "<leader>top", "<cmd>lua require('neotest').output_panel.toggle()<cr>",            mode = "n", desc = "Toggle Output Panel", },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("rustaceanvim.neotest"),
        },
      }
      )
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

      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp", },
      "saadparwaiz1/cmp_luasnip",

      "onsails/lspkind.nvim",

      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mrcjkb/rustaceanvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({ select = true, })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s", }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", }),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", },
          { name = "luasnip", },
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
              local max_length = 32
              local m = vim_item.menu or ""
              if #m > max_length then
                vim_item.menu = string.sub(m, 1, max_length) .. "..."
              end
              return vim_item
            end,
          }),
        },
      })

      cmp.setup.cmdline({ "/", "?", }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path", },
        }, {
          { name = "cmdline", },
        }),
        matching = { disallow_symbol_nonprefix_matching = false, },
      })

      --------------------------
      -- Border Configuration --
      --------------------------

      local border = {
        { "╭", "FloatBorder", },
        { "─", "FloatBorder", },
        { "╮", "FloatBorder", },
        { "│", "FloatBorder", },
        { "╯", "FloatBorder", },
        { "─", "FloatBorder", },
        { "╰", "FloatBorder", },
        { "│", "FloatBorder", },
      }

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -----------------------
      -- LSP Configuration --
      -----------------------

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "cssls",
          "emmet_language_server",
          "html",
          "lua_ls",
          "rust_analyzer",
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