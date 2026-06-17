return {
  {
    "zbirenbaum/copilot.lua",
  },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = true,
      },
      cli = {
        tools = {
          traex = {
            cmd = { "traex" },
            keys = {
              submit = {
                "<c-s>",
                function(t)
                  t:send("\n")
                end,
              },
            },
          },
          ccr = {
            cmd = { "ccr", "code", "--allow-dangerously-skip-permissions" },
            keys = {
              submit = {
                "<c-s>",
                function(t)
                  t:send("\n")
                end,
              },
            },
          },
          claude = {
            keys = {
              submit = {
                "<c-s>",
                function(t)
                  t:send("\n")
                end,
              },
            },
          },
          ["aiden codex"] = {
            cmd = { "aiden", "x", "codex" },
            keys = {
              submit = {
                "<c-s>",
                function(t)
                  t:send("\n")
                end,
              },
            },
          },
          ["aiden claude"] = {
            cmd = { "aiden", "x", "claude" },
            keys = {
              submit = {
                "<c-s>",
                function(t)
                  t:send("\n")
                end,
              },
            },
          },
        },
        mux = {
          enabled = true,
          backend = "tmux",
        },
        prompts = {
          ["git commit message"] = [[Task: You are a Git commit assistant that generates professional, convention-compliant commit messages and applies them directly to the repository.
Please repeat the prompt back as you understand it.
Specifics:
- Review all staged code changes in the repository to understand the full context (fully understand the code before changes and after).
- Inspect changed files further if needed to ensure the commit message is accurate.
- Generate a concise, one-line commit message in conventional commit format: type(scope): description, using imperative verbs.
- Avoid generic messages; ensure the message clearly and accurately conveys the purpose and scope of the changes.
- Apply the generated commit message to the repository {file} without modifying any existing content.]],
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            return -- jumped or applied
          end

          -- if you are using Neovim's native inline completions
          if vim.lsp.inline_completion.get() then
            return
          end

          -- any other things (like snippets) you want to do on <tab> go here.

          -- fall back to normal tab
          return "<tab>"
        end,
        mode = { "i", "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<C-\\>",
        function()
          require("sidekick.cli").toggle({ name = "traex" })
        end,
        desc = "Sidekick cli toggle",
      },
    },
  },
  {
    "Cannon07/code-preview.nvim",
    config = function()
      require("code-preview").setup()
    end,
  },
}
