--[[
This file configures plugins from the mini.nvim suite.

Available in both VSCode and Neovim:
- mini.align
- mini.comment
- mini.move
- mini.operators
- mini.jump2d
- mini.surround
- mini.splitjoin
- mini.ai (with custom textobjects)
- mini.indentscope

Available only in Neovim:
- mini.animate
- mini.bufremove
- mini.cursorword
- mini.diff
- mini.extra
- mini.git
- mini.icons
- mini.pick
- mini.statusline
- mini.visits
- mini.bracketed
- mini.starter
- mini.notify
- mini.map
- mini.files
- mini.hipatterns
- mini.clue
--]]

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
    keys = function()
      local keys = {}

      if vim.g.vscode then
        return keys
      end

      table.insert(keys, { "<leader>bd", function() MiniBufremove.delete() end,        desc = "Remove Buffer", })
      table.insert(keys, { "<leader>fb", function() MiniPick.builtin.buffers() end,    desc = "Buffers", })
      table.insert(keys, { "<leader>ff", function() MiniPick.builtin.files() end,      desc = "Find Files", })
      table.insert(keys, { "<leader>fg", function() MiniPick.builtin.grep_live() end,  desc = "Live Grep", })
      table.insert(keys, { "<leader>fh", function() MiniPick.builtin.help() end,       desc = "Help Tags", })
      table.insert(keys, { "<leader>fr", function() MiniExtra.pickers.registers() end, desc = "Find Register", })
      table.insert(keys, { "<leader>go", function() MiniDiff.toggle_overlay(0) end,    desc = "Git Diff Overlay", })
      table.insert(keys, { "<leader>mf", function() MiniMap.toggle_focus() end,        desc = "Toggle Mini Map Focus", })
      table.insert(keys, { "<leader>mo", function() MiniMap.toggle() end,              desc = "Toggle Mini Map", })
      table.insert(keys, { "<leader>n",  function() MiniNotify.show_history() end,     desc = "Notification History", })
      table.insert(keys, { "<leader>of", function() MiniFiles.open() end,              desc = "Mini Files", })

      return keys
    end,
    config = function()
      require("mini.align").setup()
      require("mini.comment").setup()
      require("mini.move").setup()
      require("mini.operators").setup()
      require("mini.jump2d").setup()
      require("mini.surround").setup()
      require("mini.splitjoin").setup()

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

      -- Include border lines as scope and disable cursor-dependency
      require("mini.indentscope").setup({
        options = {
          indent_at_cursor = false,
          try_as_border = true,
          symbol = "│",
        },
      })

      -- End shared plugins.The rest are Neovim-only.
      if vim.g.vscode then
        return
      end

      require("mini.animate").setup()
      require("mini.bufremove").setup()
      require("mini.cursorword").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.git").setup()
      require("mini.icons").setup()
      require("mini.pick").setup()
      require("mini.statusline").setup()
      require("mini.visits").setup()

      -- Round the diagnostic borders
      require("mini.bracketed").setup({
        diagnostic = { options = { float = { border = "rounded", }, }, },
      })

      -- Start screen configuration
      local ministarter = require("mini.starter")
      ministarter.setup({
        header = vim.trim(header),
        evaluate_single = true,
        items = {
          ministarter.sections.builtin_actions(),
          ministarter.sections.pick(),
          { name = "Lazy",  action = "Lazy",  section = "Management actions", },
          { name = "Mason", action = "Mason", section = "Management actions", },
        },
        footer = "",
      })

      -- Round the notification borders
      require("mini.notify").setup({
        window = {
          config = { border = "rounded", },
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
