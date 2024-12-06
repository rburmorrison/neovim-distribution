return {
  {
    "frankroeder/parrot.nvim",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim", },
    lazy = false,
    keys = {
      { "<leader>pa", ":PrtAppend<CR>",     mode = { "n", "v", }, desc = "Parrot Append", },
      { "<leader>pb", ":PrtPrepend<CR>",    mode = { "n", "v", }, desc = "Parrot Prepend", },
      { "<leader>pi", ":PrtImplement<CR>",  mode = { "n", "v", }, desc = "Parrot Implement", },
      { "<leader>pr", ":PrtRewrite<CR>",    mode = { "n", "v", }, desc = "Parrot Rewrite", },
      { "<leader>pc", ":PrtChatToggle<CR>", mode = { "n", "v", }, desc = "Parrot Chat Toggle", },
      { "<leader>py", ":PrtRetry<CR>",      mode = { "n", "v", }, desc = "Parrot Retry", },
      { "<leader>pp", ":PrtChatPaste<CR>",  mode = { "n", "v", }, desc = "Parrot Chat Paste", },
      { "<leader>pC", ":PrtCommit<CR>",     mode = { "n", },      desc = "Parrot Generate Commit Message", },
    },
    config = function()
      require("parrot").setup {
        user_input_ui = "buffer",
        providers = {
          openai = {
            api_key = os.getenv "OPENAI_API_KEY",
          },
        },
        hooks = {
          Commit = function(prt, params)
            local diff_output = vim.fn.system("git diff --no-ext-diff --staged")
            local chat_prompt = string.format([[
              You are an expert at the Conventional Commit format. Take the diff
              below, and output a text block of the suggested conventional
              commit block. Give no additional output other than the resulting
              block. If there should be a body, format in a markdown list with
              no additional header. The only time you should add any extra words
              is if the diff is empty. In that case, provide a short message for
              the user so they know what happened and suggest they should stage
              their changes first.

              Here is the diff:

              ```diff
              %s
              ```
            ]], diff_output)

            local model = prt.get_model("command")
            prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
          end,
        },
      }
    end,
  },
}
