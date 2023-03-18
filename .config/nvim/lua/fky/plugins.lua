-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- local github_format_url = vim.env.DC_CN and "https://hub.fastgit.xyz/%s" or "https://github.com/%s"
local github_format_url = vim.env.DC_CN and "https://github.com/%s" or "https://github.com/%s"
-- local github_format_url = vim.env.DC_CN and "https://ghproxy.com/https://github.com/%s" or "https://github.com/%s"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.sqlite_clib_path = fn.stdpath("data") .. "\\sqlite3.dll"
end

local packer_github_url = string.format(github_format_url, "wbthomason/packer.nvim")
if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({ "git", "clone", "--depth", "1", packer_github_url, install_path })
end

return require("packer").startup({
        function(use)
          -- Packer
          use("wbthomason/packer.nvim")

          -- cppman
          use {
              'madskjeldgaard/cppman.nvim',
              requires = {
                  { 'MunifTanjim/nui.nvim' }
              },
              config = function()
                local cppman = require "cppman"
                cppman.setup()

                -- Make a keymap to open the word under cursor in CPPman
                vim.keymap.set("n", "<leader>cm", function()
                  cppman.open_cppman_for(vim.fn.expand("<cword>"))
                end)

                -- Open search box
                vim.keymap.set("n", "<leader>cc", function()
                  cppman.input()
                end)
              end
          }


          use "mattn/emmet-vim"

          use "vim-test/vim-test"

          -- https://github.com/samjwill/nvim-unception
          -- Prevent vim-in-vim
          use({
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
          })

          use({
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
                        bottom_search = true, -- use a classic bottom cmdline for search
                        -- command_palette = true, -- position the cmdline and popupmenu together
                        long_message_to_split = true, -- long messages will be sent to a split
                        inc_rename = false, -- enables an input dialog for inc-rename.nvim
                        lsp_doc_border = false, -- add a border to hover docs and signature help
                    },
                })
              end,
              requires = {
                  -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                  "MunifTanjim/nui.nvim",
                  -- OPTIONAL:
                  --   `nvim-notify` is only needed, if you want to use the notification view.
                  --   If not available, we use `mini` as the fallback
                  "rcarriga/nvim-notify",
              }
          })

          use({
              "junegunn/vim-easy-align",
              config = function()
                vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false })
                vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false })
              end
          })

          use "elkowar/yuck.vim"

          -- https://github.com/petertriho/cmp-git
          use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })

          use { 'lewis6991/impatient.nvim',
              config = function()
                require('impatient')
              end
          }

          use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

          use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

          use({
              "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
              as = "lsp_lines.nvim",
              config = function()
                require("lsp_lines").setup()
              end,
          })

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

          use({
              "max397574/better-escape.nvim",
              event = "InsertEnter",
              config = function()
                require("better_escape").setup({
                    mapping = { "jk" },
                })
              end,
          })
          use({
              "ggandor/leap.nvim",
          })

          use("lukas-reineke/indent-blankline.nvim")

          use("lilydjwg/fcitx.vim")

          use({
              "kylechui/nvim-surround",
              config = function()
                require("nvim-surround").setup()
              end
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
          use { "catppuccin/nvim", as = "catppuccin" }
          use("projekt0n/github-nvim-theme")
          use("EdenEast/nightfox.nvim")

          -- Rust
          use("simrat39/rust-tools.nvim")
          use({ "stevearc/dressing.nvim" })

          -- https://github.com/Saecki/crates.nvim
          use {
              'saecki/crates.nvim',
              event = { "BufRead Cargo.toml" },
              requires = { { 'nvim-lua/plenary.nvim' } },
              config = function()
                require('crates').setup({
                    null_ls = {
                        enabled = true,
                        name = "crates.nvim",
                    },
                })
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
              -- "williamboman/nvim-lsp-installer",
              -- pictograms to lsp, VSCode-like.
              "onsails/lspkind-nvim",
              "dmitmel/cmp-cmdline-history",
              -- https://github.com/hrsh7th/cmp-emoji
              "hrsh7th/cmp-emoji",
              -- https://github.com/kdheepak/cmp-latex-symbols
              "kdheepak/cmp-latex-symbols",
          })

          use {
              "williamboman/mason.nvim",
              "williamboman/mason-lspconfig.nvim",
          }

          use({
              "j-hui/fidget.nvim",
              config = function()
                require("fidget").setup()
              end,
          })

          -- Copilot
          use(
              {
                  "github/copilot.vim",
                  config = function()
                    vim.keymap.set("i", "<C-J>", "copilot#Accept('<CR>')",
                        { expr = true, silent = true, replace_keycodes = false })
                    vim.g.copilot_no_tab_map = true
                  end
              }
          )
          -- use { "zbirenbaum/copilot.lua",
          --   event = "VimEnter",
          --   config = function()
          --     require("copilot").setup({
          --       suggestion = {
          --         auto_trigger = true,
          --         keymap = {
          --           accept = "<M-j>",
          --         },
          --       }
          --     })
          --   end,
          -- }

          -- For LuaSnip
          use({
              "rafamadriz/friendly-snippets",
              event = "InsertEnter",
              config = function()
                require("luasnip/loaders/from_vscode").lazy_load()
              end
          })

          use("kosayoda/nvim-lightbulb")

          use({
              "nvim-lua/plenary.nvim",
              requires = { "nvim-telescope/telescope.nvim" },
          })

          -- telescope
          use({
              "nvim-telescope/telescope.nvim",
              cmd = "Telescope",
              after = { "telescope-emoji.nvim", "trouble.nvim", "telescope-fzf-native.nvim" },
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

                require("telescope").load_extension("emoji")

                require("telescope").load_extension("fzf")
              end
          })
          use("xiyaowong/telescope-emoji.nvim")
          use({
              "nvim-telescope/telescope-frecency.nvim",
              after = "telescope.nvim",
              config = function()
                require("telescope").load_extension("frecency")
              end,
              requires = { "tami5/sqlite.lua", "nvim-telescope/telescope.nvim" },
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
          use({
              "p00f/nvim-ts-rainbow",
              event = "VimEnter",
              config = function()
                require("nvim-treesitter.configs").setup {
                    rainbow = {
                        enable = true,
                        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
                    },
                }
              end
          })
          use("romgrk/nvim-treesitter-context")
          use({
              "SmiteshP/nvim-gps",
              requires = "nvim-treesitter/nvim-treesitter",
          })

          use({ "simrat39/symbols-outline.nvim" })

          use({
              "kyazdani42/nvim-tree.lua",
              requires = {
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

                -- -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
                -- local function tab_win_closed(winnr)
                --   local api = require "nvim-tree.api"
                --   local tabnr = vim.api.nvim_win_get_tabpage(winnr)
                --   local bufnr = vim.api.nvim_win_get_buf(winnr)
                --   local buf_info = vim.fn.getbufinfo(bufnr)[1]
                --   local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
                --   local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
                --   if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
                --     -- Close all nvim tree on :q
                --     if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
                --       api.tree.close()
                --     end
                --   else -- else closed buffer was normal buffer
                --     if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
                --       local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
                --       if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
                --         vim.schedule(function()
                --           if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
                --             vim.cmd "quit" -- then close all of vim
                --           else -- else there are more tabs open
                --             vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
                --           end
                --         end)
                --       end
                --     end
                --   end
                -- end
                --
                -- vim.api.nvim_create_autocmd("WinClosed", {
                --   callback = function()
                --     local winnr = tonumber(vim.fn.expand("<amatch>"))
                --     vim.schedule_wrap(tab_win_closed(winnr))
                --   end,
                --   nested = true
                -- })
                --
                -- -- auto close

                require("nvim-tree").setup({
                    actions = {
                        open_file = {
                            resize_window = true,
                        },
                    },
                })
              end
          })

          use({
              "nyngwang/NeoZoom.lua",
              config = function()
                require('neo-zoom').setup {}
                local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
                vim.keymap.set('n', '<leader>z', require("neo-zoom").neo_zoom, NOREF_NOERR_TRUNC)
              end
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
              cmd = { "TroubleToggle", "Telescope" },
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

          use({ "petertriho/nvim-scrollbar" })
          use({
              "kevinhwang91/nvim-hlslens",
              config = function()
                require("hlslens").setup()
                require("scrollbar.handlers.search").setup()
              end,
          })

          -- Debug
          use({
              "mfussenegger/nvim-dap",
              requires = {
                  "nvim-lua/plenary.nvim",
              }
          })
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
              cmd = { "Octo" },
              after = "telescope.nvim",
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
          if PackerBootstrap then
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
