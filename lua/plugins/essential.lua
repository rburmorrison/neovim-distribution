return {
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    keys = {
      { "<leader>of", function() MiniFiles.open() end,              desc = "MiniFiles", },
      { "<leader>ff", function() MiniPick.builtin.files() end,      desc = "Find Files", },
      { "<leader>fr", function() MiniExtra.pickers.registers() end, desc = "Find Register", },
      { "<leader>fg", function() MiniPick.builtin.grep_live() end,  desc = "Live Grep", },
      { "<leader>fb", function() MiniPick.builtin.buffers() end,    desc = "Buffers", },
      { "<leader>fh", function() MiniPick.builtin.help() end,       desc = "Help Tags", },
      { "<leader>go", function() MiniDiff.toggle_overlay(0) end,    desc = "Git Diff Overlay", },
      { "<leader>ga", "<cmd>Git add --all --verbose<cr>",           desc = "Git Add All", },
      { "<leader>gc", "<cmd>Git commit<cr>",                        desc = "Git Commit", },
      { "<leader>gl", "<cmd>Git log<cr>",                           desc = "Git Log", },
      { "<leader>gr", "<cmd>Git reset<cr>",                         desc = "Git Reset", },
      { "<leader>gP", "<cmd>Git push<cr>",                          desc = "Git Push", },
      { "<leader>gp", "<cmd>Git pull<cr>",                          desc = "Git Pull", },
      { "<leader>gs", "<cmd>Git status<cr>",                        desc = "Git Status", },
    },
    config = function()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.git").setup()
      require("mini.jump2d").setup()
      require("mini.move").setup()
      require("mini.operators").setup()
      require("mini.pick").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()

      -- Alaways Use Go In/Out Plus
      require("mini.files").setup({
        mappings = {
          go_in = "",
          go_in_plus = "l",
          go_out = "",
          go_out_plus = "h",
        },
      })

      -- Hook Snacks Rename to Mini Files
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
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
          { mode = "n", keys = "<leader>x", desc = "+emmet", },
          { mode = "n", keys = "<leader>f", desc = "+find", },
          { mode = "n", keys = "<leader>g", desc = "+git", },
          { mode = "n", keys = "<leader>h", desc = "+hurl", },
          { mode = "n", keys = "<leader>l", desc = "+lsp", },
          { mode = "n", keys = "<leader>t", desc = "+neotest", },
          { mode = "n", keys = "<leader>o", desc = "+open", },
          { mode = "n", keys = "<leader>p", desc = "+parrot", },
          { mode = "n", keys = "<leader>s", desc = "+search", },

          -- Builtin Clues
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })

      vim.ui.select = MiniPick.ui_select
    end,
  },

  -- Configured according to the documentation from snacks.nvim.
  {
    "folke/edgy.nvim",
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right", }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4, },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_, win)
            return vim.w[win].snacks_win
                and vim.w[win].snacks_win.position == pos
                and vim.w[win].snacks_win.relative == "editor"
                and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History", },
      { "<leader>gO", function() Snacks.gitbrowse() end,             desc = "Git Browse",           mode = { "n", "v", }, },
      { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Git Blame Line", },
      { "<C-t>",      function() Snacks.terminal.toggle() end,       desc = "Toggle Terminal",      mode = { "n", "t", }, },
      { "<leader>z",  function() Snacks.zen.zen() end,               desc = "Zen Mode", },
      { "<leader>bd", function() Snacks.bufdelete() end,             desc = "Buffer Delete", },
      { "<leader>S",  function() Snacks.scratch() end,               desc = "Scratch", },
      { "<leader>os", function() Snacks.scratch.select() end,        desc = "Open Scratch", },
    },
    config = function()
      require("snacks").setup({
        bigfile = { enabled = true, },
        dashboard = { enabled = true, },
        indent = { enabled = true, },
        input = { enabled = true, },
        notifier = { enabled = true, },
        quickfile = { enabled = true, },
        scroll = { enabled = true, },
        statuscolumn = { enabled = true, },
        words = { enabled = true, },
      })

      -- LSP Progress
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params
              .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏", }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
  },

  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Bindings get put here since hurl.nvim needs to load before the filetype
      -- autocmd can trigger.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "hurl",
        group = vim.api.nvim_create_augroup("HurlSetup", {}),
        callback = function()
          require("hurl").setup({
            debug = false,
            show_notification = false,
            mode = "popup",
            formatters = {
              json = { "jq", }, -- Make sure you have install jq in your system, e.g: brew install jq
            },
            mappings = {
              close = "q",          -- Close the response popup or split view
              next_panel = "<C-n>", -- Move to the next response popup window
              prev_panel = "<C-p>", -- Move to the previous response popup window
            },
          })

          -- Normal Mode Bindings
          vim.keymap.set(
            "n",
            "<leader>hR",
            "<cmd>HurlRunner<CR>",
            { buffer = true, desc = "Run all requests", }
          )

          vim.keymap.set(
            "n",
            "<leader>hr",
            "<cmd>HurlRunnerAt<CR>",
            { buffer = true, desc = "Run current request", }
          )

          vim.keymap.set(
            "n",
            "<leader>hA",
            "<cmd>HurlRunnerToEntry<CR>",
            { buffer = true, desc = "Run requests above", }
          )

          vim.keymap.set(
            "n",
            "<leader>hB",
            "<cmd>HurlRunnerToEnd<CR>",
            { buffer = true, desc = "Run requests below", }
          )

          vim.keymap.set(
            "n",
            "<leader>hm",
            "<cmd>HurlToggleMode<CR>",
            { buffer = true, desc = "Toggle Hurl output mode", }
          )

          vim.keymap.set(
            "n",
            "<leader>hv",
            "<cmd>HurlVerbose<CR>",
            { buffer = true, desc = "Run request in verbose mode", }
          )

          vim.keymap.set(
            "n",
            "<leader>hV",
            "<cmd>HurlVeryVerbose<CR>",
            { buffer = true, desc = "Run API in very verbose mode", }
          )

          -- Visual Mode Bindings
          vim.keymap.set(
            "v",
            "<leader>hr",
            ":HurlRunner<CR>",
            { buffer = true, desc = "Run Selected Requests", }
          )
        end,
      })
    end,
  },
}
