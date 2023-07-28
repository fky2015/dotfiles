return {

  "vim-test/vim-test",

  -- https://github.com/samjwill/nvim-unception
  -- Prevent vim-in-vim
  {
    "samjwill/nvim-unception",
    config = function()
      vim.api.nvim_create_autocmd(
        "User",
        {
          pattern = "UnceptionEditRequestReceived",
          callback = function()
            -- Toggle the terminal off.
            require('FTerm').close()
          end
        }
      )
    end
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false })
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false })
    end
  },

  "elkowar/yuck.vim",

  {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient')
    end
  },

  {
    "mizlan/iswap.nvim",
    config = function()
      require("iswap").setup({})
    end,
  },
  "mg979/vim-visual-multi",

  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require("ccc")

      ccc.setup({
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        disable_default_mappings = true
      })
    end
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" },
      })
    end,
  },
  {
    "ggandor/leap.nvim",
  },

  "mattn/emmet-vim",
  "lukas-reineke/indent-blankline.nvim",

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  },

  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  "andymass/vim-matchup",

  "windwp/nvim-autopairs",
  {
    "nyngwang/NeoZoom.lua",
    -- config = function()
    --   require('neo-zoom').setup {
    --     exclude_buftypes = { 'terminal' },
    --     exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf', 'ClangdTypeHierarchy' },
    --   }
    --   vim.keymap.set('n', '<leader>z', function() vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
    -- end
  },

  "wakatime/vim-wakatime",

  "rhysd/vim-grammarous",

  "tweekmonster/helpful.vim",

  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<C-s>", mark.add_file)
      vim.keymap.set("n", "<leader>i", ui.toggle_quick_menu)
      -- vim.keymap.set("n", "<C-]>", function() ui.nav_next() end)
      -- vim.keymap.set("n", "<C-[>", function() ui.nav_prev() end)

      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    end,
  },
  {
    -- https://github.com/rmagatti/auto-session
    "rmagatti/auto-session",
    config = function()
      local filetype_to_close = { "fzf", "qf", "help", "terminal", "DiffviewFiles" };
      function close_all_floating_wins()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
          end

          -- If filetype is in the list, close it.
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, 'filetype')

          for _, ft_to_close in ipairs(filetype_to_close) do
            if ft == ft_to_close then
              vim.api.nvim_win_close(win, false)
            end
          end
        end
      end

      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup {
        log_level = "error",
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
        pre_save_cmds = { close_all_floating_wins },
      }
    end
  },
  {
    'RaafatTurki/hex.nvim',
    config = function()
      require 'hex'.setup()
    end
  },
  {
    "m4xshen/hardtime.nvim",
    config = function()
      require "hardtime".setup {
        max_count = 5,
      }
    end,
    opts = {}
  },
  {
    "chrisgrieser/nvim-spider",
    -- lazy = true,
    config = function()
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    end
  },
}
