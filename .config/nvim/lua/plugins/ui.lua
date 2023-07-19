return {
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  { 'kevinhwang91/nvim-ufo',  dependencies = 'kevinhwang91/promise-async' },
  "stevearc/qf_helper.nvim",
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      {
        "junegunn/fzf",
        run = function()
          vim.fn["fzf#install"]()
        end,
        config = function()
          vim.g.fzf_preview_window = { "right:40%:hidden", "ctrl-/" }
        end,
      },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  { "akinsho/toggleterm.nvim" },
  {
    "numToStr/FTerm.nvim",
    config = function()
      require('FTerm').setup({
        dimensions = {
          height = 0.9, -- Height of the terminal window
          width = 0.9,  -- Width of the terminal window
        },
      })
    end
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({
        autocmd = { enabled = true },
        number = {
          enabled = true,
        },
      })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
      -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
      -- local function open_nvim_tree(data)
      --   -- buffer is a [No Name]
      --   local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
      --
      --   -- buffer is a directory
      --   local directory = vim.fn.isdirectory(data.file) == 1
      --
      --   if not no_name and not directory then
      --     return
      --   end
      --
      --   -- change to the directory
      --   if directory then
      --     vim.cmd.cd(data.file)
      --   end
      --
      --   -- open the tree
      --   require("nvim-tree.api").tree.open()
      -- end
      --
      -- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

      require("nvim-tree").setup({
        actions = {
          open_file = {
            resize_window = true,
          },
        },
      })
    end
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      vim.keymap.set('n', '<leader>z', function() require("zen-mode").toggle { window = { width = 0.90 } } end,
        { silent = true, nowait = true })
    end
  },
  "camspiers/animate.vim",

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end,
  },
  { "petertriho/nvim-scrollbar" },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },
  -- Tabbar
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  "stevearc/dressing.nvim",
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  }
}
