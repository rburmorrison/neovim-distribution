local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

return {
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    keys = {
      { "<leader>bd", function() MiniBufremove.delete() end,        desc = "Remove Buffer", },
      { "<leader>fb", function() MiniPick.builtin.buffers() end,    desc = "Buffers", },
      { "<leader>ff", function() MiniPick.builtin.files() end,      desc = "Find Files", },
      { "<leader>fg", function() MiniPick.builtin.grep_live() end,  desc = "Live Grep", },
      { "<leader>fh", function() MiniPick.builtin.help() end,       desc = "Help Tags", },
      { "<leader>fr", function() MiniExtra.pickers.registers() end, desc = "Find Register", },
      { "<leader>gP", "<cmd>Git push<cr>",                          desc = "Git Push", },
      { "<leader>ga", "<cmd>Git add --all --verbose<cr>",           desc = "Git Add All", },
      { "<leader>gc", "<cmd>Git commit<cr>",                        desc = "Git Commit", },
      { "<leader>gl", "<cmd>Git log<cr>",                           desc = "Git Log", },
      { "<leader>go", function() MiniDiff.toggle_overlay(0) end,    desc = "Git Diff Overlay", },
      { "<leader>gp", "<cmd>Git pull<cr>",                          desc = "Git Pull", },
      { "<leader>gr", "<cmd>Git reset<cr>",                         desc = "Git Reset", },
      { "<leader>gs", "<cmd>Git status<cr>",                        desc = "Git Status", },
      { "<leader>mf", function() MiniMap.toggle_focus() end,        desc = "Toggle Mini Map Focus", },
      { "<leader>mo", function() MiniMap.toggle() end,              desc = "Toggle Mini Map", },
      { "<leader>n",  function() MiniNotify.show_history() end,     desc = "Notification History", },
      { "<leader>of", function() MiniFiles.open() end,              desc = "Mini Files", },
    },
    config = function()
      require("mini.align").setup()
      require("mini.animate").setup()
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.git").setup()
      require("mini.icons").setup()
      require("mini.jump2d").setup()
      require("mini.move").setup()
      require("mini.operators").setup()
      require("mini.pick").setup()
      require("mini.splitjoin").setup()
      require("mini.statusline").setup()
      require("mini.surround").setup()
      require("mini.visits").setup()

      -- Round the notification borders
      require("mini.notify").setup({
        window = {
          config = { border = "rounded", },
        },
      })

      -- Start screen configuration
      local ministarter = require("mini.starter")
      ministarter.setup({
        header = vim.trim(header),
        evaluate_single = true,
        items = {
          ministarter.sections.builtin_actions(),
          ministarter.sections.pick(),
          { name = "Lazy", action = "Lazy", section = "Management actions", },
          { name = "Mason", action = "Mason", section = "Management actions", },
        },
        footer = "",
      })

      -- Include border lines as scope and disable cursor-dependency
      require("mini.indentscope").setup({
        options = {
          indent_at_cursor = false,
          try_as_border = true,
          symbol = "│",
        },
      })

      -- Disable indentscope for buffers that aren't regular text buffers
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("IndentscopeAutoDisable", {}),
        callback = function(ctx)
          if vim.bo.buftype ~= "" then
            vim.b[ctx.buf].miniindentscope_disable = true
          end
        end,
      })

      -- Add some integrations for Mini Map
      local minimap = require("mini.map")
      minimap.setup({
        integrations = {
          minimap.gen_integration.builtin_search(),
          minimap.gen_integration.diff(),
          minimap.gen_integration.diagnostic(),
        },
        symbols = {
          encode = minimap.gen_encode_symbols.dot("3x2"),
        },
      })

      -- Alaways Use Go In/Out Plus
      require("mini.files").setup({
        mappings = {
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
        },
      })

      -- Extra AI Textobjects
      local gen_ai_spec = require("mini.extra").gen_ai_spec
      require("mini.ai").setup({
        custom_textobjects = {
          B = gen_ai_spec.buffer(),
          D = gen_ai_spec.diagnostic(),
          I = gen_ai_spec.indent(),
          L = gen_ai_spec.line(),
          N = gen_ai_spec.number(),
        },
      })

      -- Configure Highlight Patterns
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme     = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme", },
          hack      = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack", },
          todo      = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo", },
          note      = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote", },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- Keybinding Hints
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>", },
          { mode = "x", keys = "<Leader>", },

          -- Built-in completion
          { mode = "i", keys = "<C-x>", },

          -- `g` key
          { mode = "n", keys = "g", },
          { mode = "x", keys = "g", },

          -- Marks
          { mode = "n", keys = "'", },
          { mode = "n", keys = "`", },
          { mode = "x", keys = "'", },
          { mode = "x", keys = "`", },

          -- Registers
          { mode = "n", keys = '"', },
          { mode = "x", keys = '"', },
          { mode = "i", keys = "<C-r>", },
          { mode = "c", keys = "<C-r>", },

          -- Window commands
          { mode = "n", keys = "<C-w>", },

          -- `z` key
          { mode = "n", keys = "z", },
          { mode = "x", keys = "z", },
        },

        clues = {
          -- Custom Clues
          { mode = "n", keys = "<leader>b", desc = "+buffer", },
          { mode = "n", keys = "<leader>f", desc = "+find", },
          { mode = "n", keys = "<leader>g", desc = "+git", },
          { mode = "n", keys = "<leader>h", desc = "+hurl", },
          { mode = "n", keys = "<leader>l", desc = "+lsp", },
          { mode = "n", keys = "<leader>m", desc = "+minimap", },
          { mode = "n", keys = "<leader>o", desc = "+open", },
          { mode = "n", keys = "<leader>p", desc = "+prompt", },
          { mode = "n", keys = "<leader>s", desc = "+search", },
          { mode = "n", keys = "<leader>x", desc = "+emmet", },

          -- Builtin Clues
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },

        window = { delay = 250, },
      })

      vim.ui.select = MiniPick.ui_select
      vim.notify = MiniNotify.make_notify()
    end,
  },
}
