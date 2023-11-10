return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = function()
      -- vim.o.foldmethod = "expr"
      -- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

      require("nvim-treesitter.configs").setup({
        -- "windwp/nvim-ts-autotag",
        autotag = { enable = true },
        -- 'JoosepAlviste/nvim-ts-context-commentstring',
        context_commentstring = {
          enable = true,
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "latex" },
          -- TODO: need large_buf
          -- disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
          additional_vim_regex_highlighting = { "latex" },
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
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup {
        highlight = true,
      }
    end
  },
  -- -- Disable this plugin because of performance issues.
  -- {
  --   "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     local rainbow_delimiters = require 'rainbow-delimiters'
  --
  --     vim.g.rainbow_delimiters = {
  --       strategy = {
  --         [''] = rainbow_delimiters.strategy['global'],
  --         vim = rainbow_delimiters.strategy['local'],
  --       },
  --       query = {
  --         [''] = 'rainbow-delimiters',
  --         lua = 'rainbow-blocks',
  --       },
  --       highlight = {
  --         'RainbowDelimiterRed',
  --         'RainbowDelimiterYellow',
  --         'RainbowDelimiterBlue',
  --         'RainbowDelimiterOrange',
  --         'RainbowDelimiterGreen',
  --         'RainbowDelimiterViolet',
  --         'RainbowDelimiterCyan',
  --       },
  --     }
  --   end
  -- },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>J' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false
      })
      vim.keymap.set('n', '<leader>m', require('treesj').toggle)
      vim.keymap.set('n', '<leader>j', require('treesj').join)
      vim.keymap.set('n', '<leader>J', require('treesj').split)
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        backends = { "lsp", "treesitter", "markdown", "man" },
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<F3>', '<cmd>AerialToggle!<CR>')
    end
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        -- Large file will be slow.
        large_file_cutoff = 3000,
      })
    end
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        -- relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa"
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            click = "v:lua.ScSa"
          },
        }
      })
    end,
  },
}
