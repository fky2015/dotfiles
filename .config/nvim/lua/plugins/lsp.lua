return {
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "f3fora/cmp-spell",
  "hrsh7th/nvim-cmp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- pictograms to lsp, VSCode-like.
  "onsails/lspkind-nvim",
  "dmitmel/cmp-cmdline-history",
  -- https://github.com/hrsh7th/cmp-emoji
  "hrsh7th/cmp-emoji",
  -- https://github.com/kdheepak/cmp-latex-symbols
  "kdheepak/cmp-latex-symbols",

  -- https://github.com/petertriho/cmp-git
  { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },

  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  "williamboman/mason-lspconfig.nvim",

  {
    "~whynothugo/lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    name = "lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  -- For LuaSnip
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end
  },
  "jose-elias-alvarez/null-ls.nvim",
}
