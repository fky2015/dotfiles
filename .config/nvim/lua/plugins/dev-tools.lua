return {
  
  -- Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-J>", "copilot#Accept('<CR>')",
        { expr = true, silent = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

}
