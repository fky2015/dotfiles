local k = vim.keymap.set
-- telescope
k("n", "<leader>f", "<cmd>Telescope find_files<cr>")
k("n", "<leader>t", "<cmd>Telescope live_grep<cr>")
k("n", "<leader>b", "<cmd>Telescope buffers<cr>")
k("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
k("n", "<leader>s", "<cmd>Telescope treesitter<cr>")

return {
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
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
    dependencies = { 'nvim-lua/plenary.nvim', "folke/trouble.nvim" },
    config = function()
      local trouble = require("trouble.providers.telescope")

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

  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    requires = { "tami5/sqlite.lua", "nvim-telescope/telescope.nvim" },
  }
}
