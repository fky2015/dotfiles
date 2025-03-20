return {
  {
    "git@code.byted.org:chenjiaqi.cposture/codeverse.vim.git",
    config = function()
      vim.g.merscode_no_map_tab = true
      -- require("marscode").setup({})
      vim.cmd("inoremap <script><silent><nowait><expr> <M-CR> marscode#Accept()")
      vim.cmd("inoremap <script><silent><nowait><expr> <C-CR> marscode#Accept()")

      -- vim.keymap.set("i", "<C-J>", "<Plug>(marscode-accept-word)")
      -- vim.keymap.set("i", "<C-K>", "<Plug>(marscode-accept-line)")
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://ark-cn-beijing.bytedance.net/api/v3",
        model = "ep-20250212171732-l92sk", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 32000,
        disable_tools = true,
      },
      file_selector = {
        provider = "snacks",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
