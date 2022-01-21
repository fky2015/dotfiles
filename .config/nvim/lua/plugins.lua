-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- local github_format_url = vim.env.DC_CN and "https://hub.fastgit.org/%s" or "https://github.com/%s"
local github_format_url = vim.env.DC_CN and "https://ghproxy.com/https://github.com/%s" or "https://github.com/%s"

local packer_github_url = string.format(github_format_url, "wbthomason/packer.nvim")
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", packer_github_url, install_path })
end

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use({ "akinsho/toggleterm.nvim" })
		use("numToStr/FTerm.nvim")

		use("mg979/vim-visual-multi")

		use({ "jdhao/better-escape.vim", event = "InsertEnter" })
		use("karb94/neoscroll.nvim")
		use("ggandor/lightspeed.nvim")

		use("lukas-reineke/indent-blankline.nvim")

		use("lilydjwg/fcitx.vim")

		use({
			"blackCauldron7/surround.nvim",
			config = function()
				-- In order to avoid the conflict to `lightspeed.nvim`,
				-- use surround mode.
				require("surround").setup({ mappings_style = "surround" })
			end,
		})

		-- Tabbar
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
		})

		-- lualine
		use("nvim-lua/lsp-status.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use("ckipp01/stylua-nvim")

		use("andymass/vim-matchup")

		-- Colorscheme
		use("folke/tokyonight.nvim")
		use("Iron-E/nvim-highlite")
		use("rmehri01/onenord.nvim")
		use("projekt0n/github-nvim-theme")

		-- Rust
		use("simrat39/rust-tools.nvim")
		use({ "stevearc/dressing.nvim" })

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

		-- For LuaSnip
		use({
			"rafamadriz/friendly-snippets",
		})

		use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})

		use("kosayoda/nvim-lightbulb")

		use({

			"nvim-lua/plenary.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
		})

		-- telescope

		use("nvim-telescope/telescope.nvim")
		use("nvim-telescope/telescope-fzy-native.nvim")
		use("xiyaowong/telescope-emoji.nvim")
		use({
			"nvim-telescope/telescope-frecency.nvim",
			config = function()
				require("telescope").load_extension("frecency")
			end,
			requires = { "tami5/sqlite.lua" },
		})
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
					auto_resize = true,
					auto_close = true,
					open_on_tab = true,
					view = {
						-- width = 30,
						auto_resize = true,
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
		use("Pocco81/TrueZen.nvim")

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
		-- use({
		-- 	"startup-nvim/startup.nvim",
		-- 	requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		-- 	config = function()
		-- 		require("startup").setup()
		-- 	end,
		-- })
		-- use {
		--   "nvim-telescope/telescope-frecency.nvim",
		--   config = function()
		--     require"telescope".load_extension("frecency")
		--   end,
		--   requires = {"tami5/sqlite.lua"}
		-- }

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
		use("Pocco81/DAPInstall.nvim")

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
