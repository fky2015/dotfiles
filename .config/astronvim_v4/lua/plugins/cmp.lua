return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind.nvim",
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    local lspkind = require "lspkind"
    -- modify the sources part of the options table
    opts.formatting = {
      format = function(entry, vim_item)
        vim_item.menu = entry.source.name
        return lspkind.cmp_format {
          menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
          },
        }(entry, vim_item)
      end,
    } -- formatting
    opts.sources = cmp.config.sources {
      -- { name = "codeverse", priority = 500 },
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "neorg", priority = 250 },
    }
  end,
}
