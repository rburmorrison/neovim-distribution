-- lazy.nvim Initialization {{{
-- Bootstrap lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- }}}
-- }}}

vim.g.mapleader = " "

-- Plugin Definitions {{{
require("lazy").setup({
  -- Essential Plugins {{{
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  { 'numToStr/Comment.nvim', config = true },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },

  {
    "phaazon/hop.nvim",
    version = "v2",
    config = true
  },
  -- }}}

  -- Aesthetic Plugins {{{
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = true,
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "rust",
          "go",
          "bash",
          "javascript",
          "typescript",
          "python",
          "ruby",
          "sql",
          "vim",
          "lua",
          "json",
          "toml",
          "yaml",
          "markdown",
          "gitignore",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      })
    end,
  },

  { "akinsho/toggleterm.nvim", version = "*", config = true },
  
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", config = true },

  { "lewis6991/gitsigns.nvim", config = true },
  -- }}}

  -- Search & Menus {{{
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = actions.close
            }
          }
        }
      })
    end
  },

  {
    "aznhe21/actions-preview.nvim",
    opts = {
      backend = { "telescope" },
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Close the buffer when it's the last one.
      --
      -- This works by checking if it's the last window when the buffer is
      -- entered, which will occur when all other windows are closed.
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
          end
        end
      })

      require("nvim-tree").setup({ view = { width = 30 } })
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  },
  -- }}}

  -- LSP {{{
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
      "hrsh7th/vim-vsnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = "buffer" }
        }),
        formatting = {
          format = function(_, vim_item)
            -- This fixes menus that get too long and overflow. When it gets too
            -- long, truncate it and add an ellipsis.
            --
            -- Derived from: https://github.com/hrsh7th/nvim-cmp/issues/1154#issuecomment-1872926479
            local max_length = 42
            local m = vim_item.menu or ""
            if #m > max_length then
              vim_item.menu = string.sub(m, 1, max_length) .. "..."
            end
            return vim_item
          end,
        },
      })
    end
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Automatic LSP Configuration
      --
      -- See ":help mason-lspconfig-automatic-server-setup".
      require("mason-lspconfig").setup_handlers({
        function (server_name) -- default handler
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
                  vim.lsp.inlay_hint.enable(bufnr, true)
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
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,
      })
    end
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy" },
            },
          },
          on_attach = function(_, bufnr)
            if vim.fn.has("nvim-0.10") == 1 then
              -- We know Rust supports inlay hints already, so support them
              -- if NeoVim does.
              vim.lsp.inlay_hint.enable(bufnr, true)
            end
          end,
        },
      }
    end,
  },
  -- }}}

  -- Keybindings {{{
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    config = function()
      -- Terminal Toggle
      vim.keymap.set("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })
      vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })
      vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { remap = true })

      local wk = require("which-key")

      -- Normal Bindings
      wk.register({
        o = {
          name = "open",
          t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
        },
        f = {
          name = "find",
          f = { "<cmd>Telescope find_files theme=dropdown<cr>", "Find Files" },
          g = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Live Grep" },
          b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Buffers" },
          h = { "<cmd>Telescope help_tags theme=dropdown<cr>", "Help Tags" },
        },
        h = {
          name = "hop",
          w = { "<cmd>HopWord<cr>", "Word" },
          c = { "<cmd>HopChar1<cr>", "Character" },
          b = { "<cmd>HopChar2<cr>", "Bigram" },
          p = { "<cmd>HopPattern<cr>", "Bigram" },
          l = { "<cmd>HopLineStart<cr>", "Line" },
          a = { "<cmd>HopAnywhere<cr>", "Anywhere" },
          m = {
            name = "multi-window",
            w = { "<cmd>HopWordMW<cr>", "Word" },
            c = { "<cmd>HopChar1MW<cr>", "Character" },
            b = { "<cmd>HopChar2MW<cr>", "Bigram" },
            p = { "<cmd>HopPatternMW<cr>", "Bigram" },
            l = { "<cmd>HopLineStartMW<cr>", "Line" },
            a = { "<cmd>HopAnywhereMW<cr>", "Anywhere" },
          }
        }
      }, { prefix = "<leader>" })

      wk.register({
        g = {
          l = { "$", "Goto line end" },
          s = { "^", "Goto first character" },
          h = { "0", "Goto line start" },
        }
      })
    end
  },
  -- }}}
})
-- }}}

-- Post-Configuration {{{
-- LSP Bindings {{{
local wk = require("which-key")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { remap = true })

    wk.register({
      g = {
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
      }
    })

    wk.register({
      l = {
        name = "lsp",
        s = { "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>", "Document Symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>", "Workspace Symbols" },
        i = { "<cmd>Telescope lsp_implementations theme=dropdown<cr>", "Implementations" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        a = { "<cmd>lua require(\"actions-preview\").code_actions()<cr>", "Code Action" },
        R = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "References" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
        D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      },
    }, { prefix = "<leader>" })
  end
})
-- }}}
-- }}}

-- vim:set foldenable:
-- vim:set foldlevel=1:
-- vim:set foldmethod=marker:
