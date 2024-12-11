return {
  "tpope/vim-surround",
  "tpope/vim-commentary",

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
          filter = function(_buf, win)
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
      { "<leader>go", function() Snacks.gitbrowse() end,             desc = "Git Browse",           mode = { "n", "v", }, },
      { "<C-t>",      function() Snacks.terminal.toggle() end,       desc = "Toggle Terminal",      mode = { "n", "t", }, },
      { "<leader>lM", function() Snacks.rename.rename_file() end,    desc = "Rename File", },
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
        statuscolumn = { enabled = false, },
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
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", },
    keys = {
      { "<leader>ss", "<cmd>GrugFar<cr>", desc = "Grug Far", },
    },
    opts = {
      startInInsertMode = false,
    },
  },

  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>lua require('neogit').open()<cr>", desc = "Neogit", },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },

  {
    "gbprod/substitute.nvim",
    keys = {
      { "s",  "<cmd>lua require('substitute').operator()<cr>", },
      { "ss", "<cmd>lua require('substitute').line()<cr>", },
      { "S",  "<cmd>lua require('substitute').eol()<cr>", },
      { "s",  "<cmd>lua require('substitute').visual()<cr>",   mode = "x", },
    },
    opts = {},
  },

  {
    "echasnovski/mini.align",
    version = "*",
    opts = {},
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      { "echasnovski/mini.icons", opts = {}, },
    },
    keys = {
      { "<leader>oo", "<cmd>lua require('oil').toggle_float()<cr>", desc = "Open Oil", },
    },
  },

  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "hurl",
        group = vim.api.nvim_create_augroup("VisualSettings", {}),
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

          require("which-key").add({
            { "<leader>h",  group = "Hurl", },
            { "<leader>hR", "<cmd>HurlRunner<CR>",        buffer = true, desc = "Run all requests", },
            { "<leader>hr", "<cmd>HurlRunnerAt<CR>",      buffer = true, desc = "Run current request", },
            { "<leader>hA", "<cmd>HurlRunnerToEntry<CR>", buffer = true, desc = "Run requests above", },
            { "<leader>hB", "<cmd>HurlRunnerToEnd<CR>",   buffer = true, desc = "Run requests below", },
            { "<leader>hm", "<cmd>HurlToggleMode<CR>",    buffer = true, desc = "Toggle Hurl output mode", },
            { "<leader>hv", "<cmd>HurlVerbose<CR>",       buffer = true, desc = "Run request in verbose mode", },
            { "<leader>hV", "<cmd>HurlVeryVerbose<CR>",   buffer = true, desc = "Run API in very verbose mode", },
            { "<leader>hr", ":HurlRunner<CR>",            buffer = true, desc = "Run Selected Requests",        mode = "v", },
          })
        end,
      })
    end,
  },
}
