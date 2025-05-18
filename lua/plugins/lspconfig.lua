if vim.g.vscode then
  return {}
end

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

      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",

      "mrcjkb/rustaceanvim",
    },
    config = function()
      -----------------------
      -- LSP Configuration --
      -----------------------

      require("lspconfig.ui.windows").default_options = {
        border = border,
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      -- Manually activate `fish_lsp`
      vim.lsp.config("fish_lsp", {
        capabilities = capabilities,
        handlers = handlers,
      })
      vim.lsp.enable("fish_lsp")

      -- Define configs for Mason-managed servers using vim.lsp.config()
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", }, },
          },
        },
      })
      
      vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html", "htmldjango", },
        handlers = handlers,
      })

      vim.lsp.config("basedpyright", {
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
        automatic_enable = true,
      })
    end,
  },
}
