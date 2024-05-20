return {
  -- NeoVim Configuration LSP Setup
  {
    "folke/neodev.nvim",
    config = true,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- Snippets
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      -- LSP Symbols
      "onsails/lspkind.nvim",
    },
    config = function()
      local primary_sources = {
        { name = "nvim_lsp", },
        { name = "vsnip", },
      }

      if vim.g.enable_crates_nvim == 1 then
        table.insert(primary_sources, { name = "crates", })
      end

      local lspkind = require('lspkind')
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true, }),
        }),
        sources = cmp.config.sources(
          primary_sources,
          { { name = "buffer", }, }
        ),
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            before = function(_, vim_item)
              -- This fixes menus that get too long and overflow. When it gets too
              -- long, truncate it and add an ellipsis.
              --
              -- Derived from: https://github.com/hrsh7th/nvim-cmp/issues/1154#issuecomment-1872926479
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

      -- Setup vim-dadbod
      cmp.setup.filetype({ "sql", }, {
        sources = {
          { name = "vim-dadbod-completion", },
          { name = "buffer", },
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Automatic LSP Configuration
      --
      -- See ":help mason-lspconfig-automatic-server-setup".
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- General Inlay Hints
              --
              -- Inlay hints are available as of v0.10.0, so if the LSP in
              -- question supports them and NeoVim is a high enough version,
              -- support them.
              if client.server_capabilities.inlayHintProvider then
                if vim.fn.has("nvim-0.10") == 1 then
                  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
                end
              end
            end,
          })
        end,
        ["rust_analyzer"] = function()
          -- Disabled in favor of rustaceanvim.
        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = { globals = { "vim", }, },
              },
            },
          })
        end,
      })
    end,
  },
}
