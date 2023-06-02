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
  "numToStr/FTerm.nvim",
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
      local function open_nvim_tree(data)
        -- buffer is a [No Name]
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        -- buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if not no_name and not directory then
          return
        end

        -- change to the directory
        if directory then
          vim.cmd.cd(data.file)
        end

        -- open the tree
        require("nvim-tree.api").tree.open()
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

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
    config = function()
      require('neo-zoom').setup {}
      local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
      vim.keymap.set('n', '<leader>z', require("neo-zoom").neo_zoom, NOREF_NOERR_TRUNC)
    end
  },

  "camspiers/animate.vim",

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

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
      require("gitsigns").setup()
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
}