local adapter = "openrouter"

local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

local git_commit_system_prompt = [[
Analyze the provided Git diff and generate a conventional commit message using ONLY these types: `fix`, `feat`, `chore`, `refactor`, `build`, `test`, `doc`. Do NOT use scopes. Follow these examples:

**Example 1:**
```
Diff:
```diff
--- a/utils/error_handler.py
+++ b/utils/error_handler.py
@@ -5,4 +5,4 @@ def handle_error(e):
         "error": str(e),
         "timestamp": datetime.now().isoformat()
     }
-    logger.eror(response)  # Typo here
+    logger.error(response)
```

Output:
```plaintext
fix: correct logger method name typo

- Change 'eror' to 'error' in logger call
```

**Example 2:**
```
Diff:
```diff
--- a/tests/test_api.py
+++ b/tests/test_api.py
@@ -12,3 +12,7 @@ def test_get_users(client):
     response = client.get('/users')
     assert response.status_code == 200
     assert isinstance(response.json(), list)
+
+def test_create_user(client):
+    response = client.post('/users', json={'name': 'test'})
+    assert response.status_code == 201
```

Output:
```plaintext
test: add user creation endpoint test

- Implement test for POST /users endpoint
- Verify 201 status code on successful creation
```

**Rules:**
1. Begin with type prefix followed by colon and space
2. Keep description under 50 characters
3. Use bullet points for key changes (markdown hyphen syntax)
4. Focus on user impact for `fix`/`feat`, implementation details for others
5. Output ONLY this format:

```
[type]: [brief description]

- [Change detail 1]
- [Change detail 2]
```

Respond with JUST the formatted commit message in plain text within ```
]]

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
              model = { default = "openai/gpt-4o-mini", },
              temperature = { default = 0.3, },
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
                return git_commit_system_prompt
              end,
              opts = {
                contains_code = true,
              },
            },
            {
              role = constants.USER_ROLE,
              content = function()
                return string.format(
                  "```diff\n%s\n```",
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
