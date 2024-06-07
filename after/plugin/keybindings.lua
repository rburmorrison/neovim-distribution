local wk = require("which-key")

-- LSP Bindings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function()
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    wk.register({
      g = {
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration", },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition", },
      },
    })

    wk.register({
      l = {
        name = "lsp",
        s = { "<cmd>Telescope lsp_document_symbols theme=dropdown<cr>", "Document Symbols", },
        S = { "<cmd>Telescope lsp_workspace_symbols theme=dropdown<cr>", "Workspace Symbols", },
        i = { "<cmd>Telescope lsp_implementations theme=dropdown<cr>", "Implementations", },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", },
        a = { "<cmd>lua require(\"actions-preview\").code_actions()<cr>", "Code Action", },
        R = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "References", },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format", },
        d = { "<cmd>Trouble diagnostics open focus=true filter.buf=0<cr>", "Document Diagnostics", },
        D = { "<cmd>Trouble diagnostics open focus=true<cr>", "Workspace Diagnostics", },
      },
    }, { prefix = "<leader>", })
  end,
})

-- crates.nvim Bindings
if vim.g.enable_crates_nvim == 1 then
  local crates = require("crates")

  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "Cargo.toml",
    callback = function(args)
      wk.register({
        r = {
          name = "crates",
          t = { crates.toggle, "Toggle", },
          r = { crates.reload, "Reload", },
          v = { crates.show_versions_popup, "Show Versions", },
          f = { crates.show_features_popup, "Show Features", },
          d = { crates.show_dependencies_popup, "Show Dependencies", },
          e = { crates.expand_plain_crate_to_inline_table, "Expand Crate", },
          E = { crates.extract_crate_into_table, "Extract Crate", },
          u = { crates.update_crate, "Update Crate", },
          a = { crates.update_all_crates, "Update All Crates", },
          U = { crates.upgrade_crate, "Upgrade Crate", },
          A = { crates.upgrade_all_crates, "Upgrade All Crates", },
        },
      }, { prefix = "<leader>", bufnr = args.bufnr, })
    end,
  })
end

-- DAP Bindings
local dap = require("dap")

wk.register({
  d = {
    name = "debug",
    b = { dap.toggle_breakpoint, "Toggle Breakpoint", },
    i = { "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", "Inspect", },
    c = { dap.continue, "Continue", },
    C = { dap.run_to_cursor, "Run To Cursor", },
    I = { dap.step_into, "Step Into", },
    n = { dap.step_over, "Step Over", },
    O = { dap.step_out, "Step Out", },
    r = { dap.restart, "Restart", },
    t = { dap.terminate, "Terminate", },
    l = { dap.run_last, "Run Last", },
    u = {
      name = "ui",
      o = { require("dapui").open, "Open", },
      c = { require("dapui").close, "Close", },
    },
  },
}, { prefix = "<leader>", })

-- ToggleTerm Bindings
vim.keymap.set("i", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")
vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm direction=float<cr>")

-- Hop Bindings
local hop_bindings = {
  name = "hop",
  w = { "<cmd>HopWord<cr>", "Word", },
  c = { "<cmd>HopChar1<cr>", "Character", },
  b = { "<cmd>HopChar2<cr>", "Bigram", },
  p = { "<cmd>HopPattern<cr>", "Bigram", },
  l = { "<cmd>HopLineStart<cr>", "Line", },
  a = { "<cmd>HopAnywhere<cr>", "Anywhere", },
  m = {
    name = "multi-window",
    w = { "<cmd>HopWordMW<cr>", "Word", },
    c = { "<cmd>HopChar1MW<cr>", "Character", },
    b = { "<cmd>HopChar2MW<cr>", "Bigram", },
    p = { "<cmd>HopPatternMW<cr>", "Bigram", },
    l = { "<cmd>HopLineStartMW<cr>", "Line", },
    a = { "<cmd>HopAnywhereMW<cr>", "Anywhere", },
  },
}

-- General Normal-Mode Bindings
wk.register({
  o = {
    name = "open",
    t = { "<cmd>NvimTreeToggle<cr>", "NvimTree", },
    m = {
      name = "mini map",
      m = { MiniMap.toggle, "Open", },
      r = { MiniMap.refresh, "Refresh", },
    },
    s = {
      name = "spectre",
      s = { "<cmd>lua require('spectre').toggle()<CR>", "Toggle", },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search Current Word", },
      f = { "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", "Search Current File", },
    },
  },
  f = {
    name = "find",
    f = { "<cmd>Telescope find_files theme=dropdown<cr>", "Find Files", },
    g = { "<cmd>Telescope live_grep theme=dropdown<cr>", "Live Grep", },
    b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Buffers", },
    h = { "<cmd>Telescope help_tags theme=dropdown<cr>", "Help Tags", },
  },
  h = hop_bindings,
}, { prefix = "<leader>", })

-- General Visual-Mode Bindings
wk.register({
  h = hop_bindings,
}, { prefix = "<leader>", mode = "v", })

-- Helix-Like Bindings
local bindings = {
  g = {
    l = { "$", "Line End", },
    s = { "^", "Line Start", },
    h = { "0", "Column 0", },
  },
}
wk.register(bindings, { mode = "n", })
wk.register(bindings, { mode = "v", })
