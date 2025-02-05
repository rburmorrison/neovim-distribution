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
              model = { default = "google/gemini-2.0-flash-001", },
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
              role = constants.USER_ROLE,
              content = function()
                return string.format(
                  [[You are an expert at the Conventional Commit format.

Given a diff, output a conventional commit block. Output *ONLY* the commit block, and nothing else.

Example 1:

Diff:
```diff
--- a/README.md
+++ b/README.md
@@ -1,4 +1,4 @@
-# My Project
+# My Awesome Project

 This is a sample project.
```

Output:
```
doc: update project name in readme

- Change project name from "My Project" to "My Awesome Project".
```

Example 3:

Diff:
```diff
--- a/src/main.py
+++ b/src/main.py
@@ -1,3 +1,5 @@
 def main():
-    pass
+    print("Hello, world!")
+    x = 1 + 1
+    print(f"The value of x is: {x}")
```

Output:
```
feat: add hello world message and calculate a value

- Print "Hello, world!" in the main function.
- Calculate the value of 1 + 1 and store it in the variable 'x'.
- Print the value of 'x' using an f-string.
```

Example 3:

Diff:

Output:
```
Empty diff. Stage your changes first.
```

Instructions:

*   Category and summary should be lowercase.
*   Details in the body should be a markdown list.
*   Detail bullets should start with a capital letter and end with a period. Include as many as needed. No extra text outside the list.
*   Don't use scopes.
*   Valid categories: fix, feat, chore, refactor, build, test, doc.
*   If the diff is empty, output "Empty diff. Stage your changes first.".
*   Output **ONLY** the commit block. Do not add any follow-up text.

Now, generate a commit message for the following diff:
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
