local adapter = "openrouter"

local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>pC", "<cmd>CodeCompanion /commit<cr>", desc = "CodeCompanion Commit",  mode = "n", },
      { "<leader>pa", "<cmd>CodeCompanionActions<cr>",  desc = "CodeCompanion Actions", mode = { "v", "n", }, },
      { "<leader>pc", "<cmd>CodeCompanionChat<cr>",     desc = "CodeCompanion Chat",    mode = "n", },
      { "<leader>pi", "<cmd>CodeCompanion<cr>",         desc = "CodeCompanion Inline",  mode = { "v", "n", }, },
      { "<leader>px", ":CodeCompanionCmd ",             desc = "CodeCompanion Cmd",     mode = "n", },
    },
    opts = {
      strategies = {
        chat = {
          adapter = adapter,
          slash_commands = {
            ["buffer"] = { opts = { provider = "mini_pick", }, },
            ["file"] = { opts = { provider = "mini_pick", }, },
            ["help"] = { opts = { provider = "mini_pick", }, },
            ["symbols"] = { opts = { provider = "mini_pick", }, },
          },
        },
        inline = { adapter = adapter, },
        cmd = { adapter = adapter, },
      },
      adapters = {
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai",
              api_key = os.getenv("OPENROUTER_API_KEY"),
              chat_url = "/api/v1/chat/completions",
            },
            headers = {
              ["HTTP-Referer"] = "https://neovim.io/",
              ["X-Title"] = "Neovim - CodeCompanion",
            },
            schema = {
              model = { default = "google/gemini-flash-1.5", },
            },
          })
        end,
      },
      display = {
        action_palette = {
          provider = "mini_pick",
        },
        diff = {
          provider = "mini_diff",
        },
      },
      prompt_library = {
        ["Generate a Commit Message"] = {
          strategy = "chat",
          description = "Generate a commit message",
          opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "commit",
            auto_submit = true,
          },
          prompts = {
            {
              role = constants.SYSTEM_ROLE,
              content = function()
                return string.format(
                  [[You are an expert at the Conventional Commit format. When
the user gives you a diff, output a text block of the suggested conventional
commit block. Give no additional output other than the resulting block. If there
should be a body, format in a markdown list with no additional header. The only
time you should add any extra words is if the diff is empty. In that case,
provide a short message for the user so they know what happened and suggest they
should stage their changes first.

An example output would be in the form of:

```
<CATEGORY>: <SUMMARY>

- <DETAIL_ONE>
- <DETAIL_TWO>
```

Don't include the markdown code block syntax.

Both `<CATEGORY>` and `<SUMMARY>` should be all lowercase, while each
`<DETAIL_X>` should start with a captital letter and end with a period. Add as
many detail bullets as required to get a full picture of the diff.

Valid categories are:

- fix (a bug fix)
- feat (a new feature)
- chore (an update to the environment, updating dependencies, etc.)
- refactor (organization changes that neither fix bugs nor add features)
- build (updates to the build system)
- test (changes or additions to tests)
- doc (documentation changes)

Dont include scopes, and don't include text in the body outside of the details
list.
]],
                  vim.fn.system("git diff --no-color --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
            {
              role = constants.USER_ROLE,
              content = function()
                return string.format(
                  [[Here is my diff:

`````diff
%s
`````
]],
                  vim.fn.system("git diff --no-color --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
      },
    },
  },
}
