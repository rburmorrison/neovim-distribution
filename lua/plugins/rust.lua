return {
  {
    "saecki/crates.nvim",
    cond = vim.g.enable_crates_nvim == 1,
    tag = "stable",
    config = true,
  },
}
