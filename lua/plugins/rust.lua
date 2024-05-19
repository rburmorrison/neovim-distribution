return {
  {
    "saecki/crates.nvim",
    cond = vim.g.enable_crates_nvim == 1,
    tag = "stable",
    config = true,
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
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end,
        },
      }
    end,
  },
}
