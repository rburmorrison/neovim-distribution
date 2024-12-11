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
      require("parrot").setup({
        user_input_ui = "buffer",
        providers = {
          openai = {
            api_key = os.getenv "OPENAI_API_KEY",
          },
        },
        hooks = {
          Commit = function(prt, params)
            local diff_output = vim.fn.system("git diff --no-color --no-ext-diff --staged")
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

            An example output would be in the form of:

            ```
            <CATEGORY>: <SUMMARY>

            - <DETAIL_ONE>
            - <DETAIL_TWO>
            ```

            Both `<CATEGORY>` and `<SUMMARY>` should be all lowercase, while
            each `<DETAIL_X>` should start with a captital letter and end with
            a period. Add as many detail bullets as required to get a full
            picture of the diff.

            Valid categories are:

            - fix (a bug fix)
            - feat (a new feature)
            - chore (an update to the environment, updating dependencies, etc.)
            - refactor (organization changes that neither fix bugs nor add features)
            - build (updates to the build system)
            - test (changes or additions to tests)
            - doc (documentation changes)

            Dont include scopes, and don't include text in the body outside
            of the details list.
            ]], diff_output)

            local model = prt.get_model("command")
            prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
          end,
        },
      })
    end,
  },
}
