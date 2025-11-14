return {
  {
    "git@code.byted.org:chenjiaqi.cposture/codeverse.vim.git",
    config = function()
      vim.g.trae_no_map_tab = true
      -- require("marscode").setup({})
      vim.cmd("inoremap <script><silent><nowait><expr> <M-CR> trae#Accept()")
      vim.cmd("inoremap <script><silent><nowait><expr> <C-CR> trae#Accept()")

      -- vim.keymap.set("i", "<C-J>", "<Plug>(marscode-accept-word)")
      -- vim.keymap.set("i", "<C-K>", "<Plug>(marscode-accept-line)")
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    opts = {
      auto_aprove = true,
      extensions = {},
    },
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
  },
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>Ac", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanion: new chat" },
      { "<leader>Aa", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion: action palette" },
      { "<leader>Ai", ":CodeCompanion ", desc = "CodeCompanion: inline prompt", mode = { "n", "v" } },
      { "<leader>Ar", "<cmd>CodeCompanionCmd<CR>", desc = "CodeCompanion: run command" },
    },
    opts = {
      language = "Chinese",
      strategies = {
        chat = {
          adapter = "doubao",
        },
        inline = {
          adapter = "doubao",
        },
        cmd = {
          adapter = "doubao",
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              -- commands = {
              --   default = {
              --     "ccr",
              --     "code",
              --   },
              -- },
            })
          end,
        },
        kimi = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "myadapter",
            url = "https://ark-cn-beijing.bytedance.net/api/v3/chat/completions",
            env = {
              api_key = function()
                return os.getenv("OPENAI_API_KEY")
              end,
            },
            schema = {
              model = {
                default = "ep-20250212171732-l92sk",
              },
            },
          })
        end,
        doubao = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "myadapter",
            url = "https://ark-cn-beijing.bytedance.net/api/v3/chat/completions",
            env = {
              api_key = function()
                return os.getenv("OPENAI_API_KEY")
              end,
            },
            schema = {
              model = {
                default = "ep-20251111191045-dpx5b",
              },
            },
          })
        end,
        ["my-deepseak"] = function()
          return require("codecompanion.adapters").extend("openai", {
            name = "myadapter",
            url = "https://ark-cn-beijing.bytedance.net/api/v3/chat/completions",
            env = {
              api_key = function()
                return os.getenv("OPENAI_API_KEY")
              end,
            },
            schema = {
              model = {
                default = "ep-20250619125827-fm72h",
              },
            },
          })
        end,
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "norg", "rmd", "org" },
      },
      {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
          preview = {
            filetypes = { "markdown", "codecompanion" },
            ignore_buftypes = {},
          },
        },
      },
      {
        "nvim-mini/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },
  },
}
