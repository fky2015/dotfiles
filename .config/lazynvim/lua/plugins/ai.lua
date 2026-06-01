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
          coco = {
            cmd = { "coco" },
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
          backend = "zellij",
        },
        prompts = {
          ["git commit message"] = [[Task: You are a Git commit assistant that generates professional, convention-compliant commit messages and applies them directly to the repository.
Please repeat the prompt back as you understand it.
Specifics:
- Review all staged code changes in the repository to understand the full context.
- Inspect changed files further if needed to ensure the commit message is accurate.
- Generate a concise, one-line commit message in conventional commit format: type(scope): description, using imperative verbs.
- Avoid generic messages; ensure the message clearly and accurately conveys the purpose and scope of the changes.
- Apply the generated commit message to the repository {file} without modifying any existing content.]],
        },
      },
    },
    keys = {
      {
        "<C-\\>",
        function()
          require("sidekick.cli").toggle({ name = "ccr" })
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
