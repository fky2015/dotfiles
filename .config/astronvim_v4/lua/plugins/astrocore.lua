return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        [";"] = {
          ":",
        },
        [":"] = {
          ";",
        },
        ["q;"] = {
          "q:",
        },
        ["<C-C>"] = {
          'V"+y',
          desc = "quick copy to system clipboard.",
        },
        ["gl"] = {
          "2g;",
        },
        ["<leader>z"] = {
          function() require("zen-mode").toggle { window = { width = 0.90 } } end,
          desc = "zen mode",
        },
        ["<leader>ca"] = {
          'ggvG"+Y<c-o>',
        },
        ["<leader>T"] = {
          ":tabnew %<CR>",
        },
        ["<ESC>"] = {
          "<nop>",
        },
        ["<Left>"] = {
          ":vertical resize -10<CR>",
        },
        ["<Right>"] = {
          ":vertical resize +10<CR>",
        },
        ["<Up>"] = {
          ":horizontal resize +10<CR>",
        },
        ["<Down>"] = {
          ":horizontal resize -10<CR>",
        },
        ["<LocalLeader>l"] = {
          ":LLToggle!<CR>",
          desc = "Toggle loclist",
        },
        ["<LocalLeader>q"] = {
          ":QFToggle!<CR>",
          desc = "Toggle quickfix",
        },
        ["<c-\\>"] = {
          "<cmd>ToggleTerm<cr>",
          desc = "Toggle terminal",
        },
        ["<F4>"] = {
          '<CMD>lua require("FTerm").toggle()<CR>',
          desc = "Toggle a float terminal",
        },
        ["<leader>n"] = {
          "<cmd>Neotree toggle<cr>",
          desc = "Toggle Explorer",
        },
        ["=="] = {
          "<cmd>lua require('oil').open()<cr>",
          desc = "Open parent directory",
        },
        -- buffer -> gdb
        ["<leader>bg"] = {
          function() vim.fn.setreg("+", vim.fn.expand "%" .. ":" .. vim.fn.line ".") end,
          desc = "Copy current <FILE>:<LINE> for gdb",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["jk"] = {
          "<C-\\><C-n>",
        },
        ["<F4>"] = {
          '<CMD>lua require("FTerm").toggle()<CR>',
          desc = "Toggle a float terminal",
        },
        ["<c-\\>"] = {
          "<cmd>ToggleTerm<cr>",
          desc = "Toggle terminal",
        },
      },
      x = {
        [";"] = {
          ":",
        },
        ["<C-C>"] = {
          '"+y',
          desc = "quick copy to system clipboard.",
        },
      },
    },
  },
}
