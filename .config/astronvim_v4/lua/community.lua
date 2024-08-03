-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- recipes
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.vscode-icons" },

  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    -- further customize the options set by the community
    "catppuccin",
    opts = {
      -- latte, frappe, macchiato, mocha
      flavour = "frappe",
      color_overrides = {
        frappe = {
          -- default: #babbf1
          lavender = "#babbfc",
        },
      },
    },
  },
  -- pack
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.lua" },

  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.debugging.nvim-bqf" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  -- { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.color.headlines-nvim" },
  -- { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.motion.harpoon" },

  -- Database plugins.
  { import = "astrocommunity/pack/full-dadbod" },
}
