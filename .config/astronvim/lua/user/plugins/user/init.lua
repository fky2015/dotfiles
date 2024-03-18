local ret = {
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local opts = require("alpha.themes.startify").opts
      -- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-1924014
      opts.layout[2].val = {
        "            :h-                                  Nhy`               ",
        "           -mh.                           h.    `Ndho               ",
        "           hmh+                          oNm.   oNdhh               ",
        "          `Nmhd`                        /NNmd  /NNhhd               ",
        "          -NNhhy                      `hMNmmm`+NNdhhh               ",
        "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
        "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
        "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
        "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
        " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
        " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
        " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
        " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
        "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
        "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
        "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
        "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
        "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
        "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
        "       //+++//++++++////+++///::--                 .::::-------::   ",
        "       :/++++///////////++++//////.                -:/:----::../-   ",
        "       -/++++//++///+//////////////               .::::---:::-.+`   ",
        "       `////////////////////////////:.            --::-----...-/    ",
        "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
        "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
        "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
        "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
        "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
        "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
        "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
        "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
        "                        .-:mNdhh:.......--::::-`                    ",
        "                           yNh/..------..`                          ",
        "                                                                    ",
      }
      require("alpha").setup(opts)
    end,
  },
  {
    "stevearc/qf_helper.nvim",
    cmd = { "QFToggle", "LLToggle" },
    config = function() require("qf_helper").setup() end,
  },
  {
    "numToStr/FTerm.nvim",
    opts = {
      dimensions = {
        height = 0.9, -- Height of the terminal window
        width = 0.9, -- Width of the terminal window
      },
    },
  },
  {
    "kosayoda/nvim-lightbulb",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      autocmd = { enabled = true },
      number = {
        enabled = true,
      },
      sign = {
        enabled = false,
      },
    },
    config = function(opts)
      require("nvim-lightbulb").setup(opts)
      vim.cmd [[highlight LightBulbNumber guifg=#FFce0e]]
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
        config = function()
          require("telescope").load_extension "live_grep_args"

          local telescope = require "telescope"
          local lga_actions = require "telescope-live-grep-args.actions"

          telescope.setup {
            extensions = {
              live_grep_args = {
                auto_quoting = true, -- enable/disable auto-quoting
                -- define mappings, e.g.
                -- ... also accepts theme settings, for example:
                -- theme = "dropdown", -- use dropdown theme
                -- theme = { }, -- use own theme spec
                -- layout_config = { mirror=true }, -- mirror preview pane
              },
            },
          }
        end,
      },
    },
    keys = {
      {
        "<leader>fg",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Live grep args",
      },
    },
  },
  {
    "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle",
    config = function() vim.g.table_mode_corner = "|" end,
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require "ccc"

      ccc.setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        disable_default_mappings = true,
      }
    end,
  },
  { "tpope/vim-fugitive", lazy = false },

  -- this plugin will be loaded when using `:ZenMode`
  { "folke/zen-mode.nvim" },
  { "tpope/vim-unimpaired", lazy = false },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "prochri/telescope-all-recent.nvim",
      dependencies = { "kkharji/sqlite.lua" },
      config = function() require("telescope-all-recent").setup {} end,
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>m", "<CMD>TSJToggle<CR>", desc = "Toggle Treesitter Join" },
      { "<leader>j", "<CMD>TSJSplit<CR>", desc = "Treesitter Split" },
      { "<leader>J", "<CMD>TSJJoin<CR>", desc = "Treesitter Join" },
    },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Neorg" },
    -- event = "VeryLazy",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {}, -- Adds default keybindings
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                works = "~/works",
              },
              default_workspace = "notes",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "[Neorg]",
            },
          }, -- Enables support for completion plugins
          ["core.journal"] = { config = {
            strategy = "flat",
            workspace = "notes",
          } }, -- Enables support for the journal module
          ["core.highlights"] = {},
          ["core.export"] = {},
          ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
          ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
          ["core.summary"] = {},
          -- ["core.ui.calendar"] = {},
        },
      }
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
  {
    "willothy/flatten.nvim",
    config = function()
      require("flatten").setup {
        window = {
          open = "alternate",
        },
      }
    end,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    "mattn/emmet-vim",
    keys = {
      {
        "<C-y>,",
        mode = { "n", "i" },
        desc = "Unfold via emmet.",
      },
    },
  },
}

table.insert(ret, require "user.plugins.user.lang")

return ret
