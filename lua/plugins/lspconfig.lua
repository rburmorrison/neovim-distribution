local border = "rounded"

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border, }),
}

return {
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
      "brenoprata10/nvim-highlight-colors",

      "folke/lazydev.nvim",

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
          { name = "lazydev", },
          { name = "nvim_lsp", },
          { name = "luasnip", },
        }, {
          { name = "buffer", },
        }, {
          { name = "path", },
        }),
        formatting = {
          format = function(entry, vim_item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = vim_item.kind, })

            ---@diagnostic disable-next-line: redefined-local
            local vim_item = require("lspkind").cmp_format({
              mode = "symbol",
              maxwidth = 32,
              ---@diagnostic disable-next-line: redefined-local
              before = function(_, vim_item)
                local max_length = 32
                local m = vim_item.menu or ""
                if #m > max_length then
                  vim_item.menu = string.sub(m, 1, max_length) .. "..."
                end
                return vim_item
              end,
            })(entry, vim_item)

            if color_item.abbr_hl_group then
              vim_item.kind_hl_group = color_item.abbr_hl_group
              vim_item.kind = color_item.abbr
            end

            return vim_item
          end,
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

      -----------------------
      -- LSP Configuration --
      -----------------------

      require("mason").setup({
        ui = { border = border, },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "bashls",
          "biome",
          "cssls",
          "emmet_language_server",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "ruff",
          "rust_analyzer",
          "taplo",
          "ts_ls",
        },
      })

      ----------------------------
      -- Automatic Server Setup --
      ----------------------------

      require("lspconfig.ui.windows").default_options = {
        border = border,
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            handlers = handlers,
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            handlers = handlers,
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
            capabilities = capabilities,
            filetypes = { "html", "htmldjango", },
            handlers = handlers,
          })
        end,
        ["basedpyright"] = function()
          require("lspconfig").basedpyright.setup({
            capabilities = capabilities,
            handlers = handlers,
            on_attach = function(_, bufnr)
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
            end,
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "standard",
                },
              },
            },
          })
        end,
      })
    end,
  },
}
