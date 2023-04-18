return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"

      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "latex" },
          additional_vim_regex_highlighting = { "latex" },
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/316
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ia"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<localleader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<localleader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end
  },
  {
    "romgrk/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        refactor = {
          highlight_definitions = { enable = true },
          -- highlight_current_scope = { enable = true },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<a-*>",
              goto_previous_usage = "<a-#>",
            },
          },
        },
      })
    end
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "VimEnter",
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          -- Which query to use for finding delimiters
          query = 'rainbow-parens',
          -- Highlight the entire buffer all at once
          strategy = require('ts-rainbow').strategy.global,
        },
      }
    end
  },
}
