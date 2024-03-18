return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

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
      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  {
    -- further customize the options set by the community
    "copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
        },
      },
    },
  },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.debugging.nvim-bqf" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.media.vim-wakatime" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  -- { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.color.headlines-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.motion.marks-nvim" },
}
