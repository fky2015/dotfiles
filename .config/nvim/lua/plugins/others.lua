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

  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'kevinhwang91/nvim-ufo',  dependencies = 'kevinhwang91/promise-async' },
  {
    "mizlan/iswap.nvim",
    config = function()
      require("iswap").setup({})
    end,
  },
  "stevearc/qf_helper.nvim",
  {
    "christoomey/vim-tmux-navigator",
    enabled = false,
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "nyngwang/NeoRoot.lua",
  },
  {
    "zegervdv/nrpattern.nvim",
    config = function()
      -- Basic setup
      -- See below for more options
      require("nrpattern").setup()
    end,
  },

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
  -- A Vim / Neovim plugin to copy text to the system clipboard from anywhere using the ANSI OSC52 sequence.
  "ojroques/vim-oscyank",

  "mg979/vim-visual-multi",

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
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

  "lilydjwg/fcitx.vim",

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
  -- Tabbar
  {
    "romgrk/barbar.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  "andymass/vim-matchup",

  -- Rust
  "stevearc/dressing.nvim",


  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
  },

  -- Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-J>", "copilot#Accept('<CR>')",
        { expr = true, silent = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end
  },

  "kosayoda/nvim-lightbulb",
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

  "windwp/nvim-autopairs",
  -- TODO: https://github.com/nvimdev/lspsaga.nvim#using-lspsaga
  "simrat39/symbols-outline.nvim",

  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
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
    "nyngwang/NeoZoom.lua",
    -- config = function()
    --   require('neo-zoom').setup {
    --     exclude_buftypes = { 'terminal' },
    --     exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf', 'ClangdTypeHierarchy' },
    --   }
    --   vim.keymap.set('n', '<leader>z', function() vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
    -- end
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
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  "wakatime/vim-wakatime",
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },

  "lervag/vimtex",

  "rhysd/vim-grammarous",

  "tweekmonster/helpful.vim",
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end,
  },

  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    tag = "release",
    config = function()
      require("gitsigns").setup({
        yadm = { enable = true },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },

  "RRethy/vim-illuminate",

  { "petertriho/nvim-scrollbar" },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },

  -- Debug
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- ATTENTION: require github-cli.
  {
    "pwntester/octo.nvim",
    cmd = { "Octo" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
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
      function close_all_floating_wins()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
          end
        end
      end

      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup {
        log_level = "error",
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
  }
}
