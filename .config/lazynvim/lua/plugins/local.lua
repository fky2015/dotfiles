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
  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --     or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     selector = {
  --       provider = "snacks",
  --     },
  --     input = {
  --       provider = "snacks",
  --       provider_opts = {
  --         -- Additional snacks.input options
  --         title = "Avante Input",
  --         icon = " ",
  --       },
  --     },
  --     -- for example
  --     provider = "ark",
  --     providers = {
  --       ---@type AvanteProvider
  --       ark = {
  --         __inherited_from = "openai",
  --         endpoint = "https://ark-cn-beijing.bytedance.net/api/v3", -- The full endpoint of the provider
  --         model = "ep-20250212171732-l92sk", -- The model name to use with this provider
  --         api_key_name = "OPENAI_API_KEY", -- The name of the environment variable that contains the API key
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_completion_tokens = 12288, -- Increase this to include reasoning tokens (for reasoning models)
  --           reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
  --         },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion: toggle side panel" },
      { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanion: new chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion: action palette" },
      { "<leader>ai", ":CodeCompanion ", desc = "CodeCompanion: inline prompt", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>CodeCompanionCmd<CR>", desc = "CodeCompanion: run command" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
    },
    opts = {
      language = "Chinese",
      strategies = {
        chat = {
          adapter = "kimi",
        },
        inline = {
          adapter = "kimi",
        },
        cmd = {
          adapter = "kimi",
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
                -- default = "ep-20250619125827-fm72h",
                default = "ep-20250212171732-l92sk",
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
