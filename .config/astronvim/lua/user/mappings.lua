-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
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
    -- Disable force quit
    ["<C-q>"] = {
      function() end,
      desc = "Do nothing",
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
}
