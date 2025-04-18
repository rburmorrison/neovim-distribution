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
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        server = {
          handlers = handlers,
          default_settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy", },
            },
          },
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr, })
          end,
        },
      }
    end,
  },
}
