return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      {
        "<Left>",
        function()
          require("smart-splits").resize_left(10)
        end,
      },
      {
        "<Right>",
        function()
          require("smart-splits").resize_right(10)
        end,
      },
      {
        "<Up>",
        function()
          require("smart-splits").resize_up(10)
        end,
      },
      {
        "<Down>",
        function()
          require("smart-splits").resize_down(10)
        end,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disabled_keys = {
        ["<Up>"] = false, -- Allow <Up> key
        ["<Down>"] = false, -- Allow <Down> key
        ["<Left>"] = false, -- Allow <Left> key
        ["<Right>"] = false, -- Allow <Right> key
      },
      disable_mouse = false,
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader><CR>",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>sR",
        false,
      },
    },
    opts = {
      picker = {
        matcher = {
          cwd_bonus = true,
          frecency = true,
          history_bonus = true,
        },
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            engine = "astgrep",
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "x" },
        desc = "Toggle Grug Far",
      },
    },
  },
}
