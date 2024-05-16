local wk = require("which-key")

if vim.g.enable_github_copilot == 1 then
  wk.register({
    c = {
      name = "copilot",
      e = { "<cmd>Copilot enable<cr><cmd>Copilot status<cr>", "Enable" },
      d = { "<cmd>Copilot disable<cr><cmd>Copilot status<cr>", "Disable" },
      p = { "<cmd>Copilot panel<cr>", "Panel" },
      s = { "<cmd>Copilot status<cr>", "Status" },
    }
  }, { prefix = "<leader>" })
end
