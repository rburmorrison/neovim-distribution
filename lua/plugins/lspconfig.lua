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
      "saghen/blink.cmp",

      "folke/lazydev.nvim",

      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mrcjkb/rustaceanvim",
    },
    config = function()
      -----------------------
      -- LSP Configuration --
      -----------------------

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      -- Manually activate `fish_lsp`

      lspconfig.fish_lsp.setup({
        capabilities = capabilities,
        handlers = handlers,
      })

      -- Manually activate `nushell`

      lspconfig.nushell.setup({
        capabilities = capabilities,
        handlers = handlers,
      })

      -- Configure Mason

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
