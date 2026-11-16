return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "EdenEast/nightfox.nvim",
  },

  -- Configure LazyVim to load catppuccin as the colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- Some of my favorites:
      -- catppuccin
      -- catppuccin-frappe
      -- nightfox
      colorscheme = "nightfox",
    },
  },
}
