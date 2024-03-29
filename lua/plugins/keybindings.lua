return {
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

    -- LSP Bindings
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
  end
}
