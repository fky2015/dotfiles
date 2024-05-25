return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = nil,
      direction = "horizontal",
      shader_terminals = false,
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      opts.menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
      }
    end,
  },
}
