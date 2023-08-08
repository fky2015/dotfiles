local k = vim.keymap.set
-- telescope
k("n", "<leader>f", "<cmd>Telescope find_files<cr>")
k("n", "<leader>F", "<cmd>Telescope git_files<cr>")
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

-- ["<leader>ff"] = { function() builtin.find_files({ cwd = utils.buffer_dir() }) end,
--       desc = "Find files in cwd" }
k("n", "<leader>FF", function() builtin.find_files({ cwd = utils.buffer_dir() }) end)
k("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
k("n", "<leader>b", "<cmd>Telescope buffers<cr>")
k("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
k("n", "<leader>s", "<cmd>Telescope treesitter<cr>")
k("n", "<leader>r", "<cmd>Telescope resume<cr>")
k("n", "<C-_>", "<cmd>Telescope<cr>")
k("n", "<leader-/>", "<cmd>Telescope><CR>")
vim.keymap.set("n", "<leader>T", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

return {
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      "folke/trouble.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local trouble = require("trouble.providers.telescope")

      -- require("telescope").load_extension("live_grep_args")

      local lga_actions = require("telescope-live-grep-args.actions")

      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<C-h>"] = "which_key",
              ["<c-o>"] = trouble.open_with_trouble,
            },
            n = {
              ["<c-o>"] = trouble.open_with_trouble
            }
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {
              -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          },
        }
      }
    end
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("emoji")
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function() require("telescope").load_extension("fzf") end
  },

  -- Consider deprecated.
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    dependencies = { "tami5/sqlite.lua", "nvim-telescope/telescope.nvim" },
  },
  {
    'prochri/telescope-all-recent.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require 'telescope-all-recent'.setup {}
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neoclip').setup()
      require('telescope').load_extension('neoclip')
    end,
  },
}
