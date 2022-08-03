-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local github_format_url = vim.env.DC_CN and "https://hub.fastgit.xyz/%s" or "https://github.com/%s"
-- local github_format_url = vim.env.DC_CN and "https://ghproxy.com/https://github.com/%s" or "https://github.com/%s"

local packer_github_url = string.format(github_format_url, "wbthomason/packer.nvim")
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", packer_github_url, install_path })
end

return require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")

    use({
      "mizlan/iswap.nvim",
      config = function()
        require("iswap").setup({})
      end,
    })

    use("stevearc/qf_helper.nvim")

    use({
      "christoomey/vim-tmux-navigator",
      config = function()
        vim.g.tmux_navigator_no_mappings = 1
      end,
    })
    -- use({ "protex/better-digraphs.nvim", require = {
    -- 	"nvim-telescope/telescope.nvim",
    -- } })

    use({
      "nyngwang/NeoRoot.lua",
    })

    use({
      "zegervdv/nrpattern.nvim",
      config = function()
        -- Basic setup
        -- See below for more options
        require("nrpattern").setup()
      end,
    })

    use({
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      requires = {
        {
          "junegunn/fzf",
          run = function()
            vim.fn["fzf#install"]()
          end,
          config = function()
            vim.g.fzf_preview_window = { "right:40%:hidden", "ctrl-/" }
          end,
        },
        { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
      },
    })

    use({ "akinsho/toggleterm.nvim" })
    use("numToStr/FTerm.nvim")

    -- A Vim / Neovim plugin to copy text to the system clipboard from anywhere using the ANSI OSC52 sequence.
    use("ojroques/vim-oscyank")

    use("mg979/vim-visual-multi")

    use({
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    })

    use({ "jdhao/better-escape.vim", event = "InsertEnter" })
    use("karb94/neoscroll.nvim")
    use("ggandor/lightspeed.nvim")

    use("lukas-reineke/indent-blankline.nvim")

    use("lilydjwg/fcitx.vim")

    -- TODO: considering replace it due to lacking of maintain.
    use({
      "ur4ltz/surround.nvim",
      config = function()
        -- In order to avoid the conflict to `lightspeed.nvim`,
        -- use surround mode.
        require("surround").setup({ mappings_style = "surround" })
      end,
    })

    use({
      "danymat/neogen",
      config = function()
        require("neogen").setup({
          enabled = true,
        })
      end,
      requires = "nvim-treesitter/nvim-treesitter",
      -- Uncomment next line if you want to follow only stable versions
      -- tag = "*"
    })

    -- Tabbar
    use({
      "romgrk/barbar.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })

    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    use("andymass/vim-matchup")

    -- Colorscheme
    use("projekt0n/github-nvim-theme")
    use("EdenEast/nightfox.nvim")

    -- Rust
    use("simrat39/rust-tools.nvim")
    use({ "stevearc/dressing.nvim" })
    use {
      'saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('crates').setup()
      end,
    }

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      -- Automatically Install LSP for built-in LSP.
      "williamboman/nvim-lsp-installer",
      -- pictograms to lsp, VSCode-like.
      "onsails/lspkind-nvim",
    })

    use({ "j-hui/fidget.nvim", branch = "no-fold" })
    -- Copilot
    use("github/copilot.vim")

    -- For LuaSnip
    use({
      "rafamadriz/friendly-snippets",
    })

    use("kosayoda/nvim-lightbulb")

    use({

      "nvim-lua/plenary.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
    })

    -- telescope

    use("nvim-telescope/telescope.nvim")
    -- use("nvim-telescope/telescope-fzy-native.nvim")
    use("xiyaowong/telescope-emoji.nvim")
    use({
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
      requires = { "tami5/sqlite.lua" },
    })

    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    --
    -- Lua
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    use("windwp/nvim-autopairs")

    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-refactor")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("p00f/nvim-ts-rainbow")
    use("romgrk/nvim-treesitter-context")
    use({
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
    })

    use("simrat39/symbols-outline.nvim")

    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 30,
          },
          actions = {
            open_file = {
              resize_window = true,
            },
          },
        })
      end,
    })

    use({
      "nyngwang/NeoZoom.lua",
    })

    use("camspiers/animate.vim")

    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })

    use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

    use("wakatime/vim-wakatime")
    use({
      "Pocco81/true-zen.nvim",
      config = function()
         require("true-zen").setup {
          -- your config goes here
          -- or just leave it empty :)
         }
      end,
    })

    use("lervag/vimtex")

    use("rhysd/vim-grammarous")

    use("tweekmonster/helpful.vim")

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    use("jose-elias-alvarez/null-ls.nvim")

    use({
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("alpha").setup(require("alpha.themes.startify").opts)
      end,
    })

    use("tpope/vim-unimpaired")
    use("tpope/vim-repeat")
    use("tpope/vim-fugitive")
    use({
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      -- tag = 'release' -- To use the latest release
    })

    use("RRethy/vim-illuminate")

    use("petertriho/nvim-scrollbar")
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("hlslens").setup()
        require("scrollbar.handlers.search").setup()
      end,
    })

    -- Debug
    use({ "mfussenegger/nvim-dap", requires = {
      "nvim-lua/plenary.nvim",
    } })
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dapui").setup()
      end,
    })
    use({
      "theHamsta/nvim-dap-virtual-text",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    })

    -- ATTENTION: require github-cli.
    use({
      "pwntester/octo.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("octo").setup()
      end,
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        })
      end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    git = { default_url_format = github_format_url },
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
