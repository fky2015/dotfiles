return {
  {
    "p00f/clangd_extensions.nvim",
    keys = {
      {
        "<localleader><localleader>",
        "<cmd>ClangdSwitchSourceHeader<CR>",
        desc = "Switch between source and header file",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      table.insert(opts.codelens, { enabled = true })
    end,
  },
}
