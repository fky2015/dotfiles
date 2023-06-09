local lualine_theme_style = require('theme').lualine_theme_style

local ops = {
  theme = "auto"
}
if lualine_theme_style then
  ops.theme = lualine_theme_style
end

vim.opt.laststatus = 3

local navic = require("nvim-navic")
require("lualine").setup({
  extensions = { "nvim-tree", "fugitive", "quickfix", "lazy", "symbols-outline", "trouble", "toggleterm" },
  winbar = {
    lualine_a = {},
    lualine_b = {
      {
        "filename",
        path = 1,
      }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'diff' },
    lualine_z = {
    }
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {
      { "filename", path = 1, }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'diff' },
    lualine_z = {}
  },
  sections = {
    lualine_b = {
      "branch",
      'diff',
      'diagnostics'
    },
    lualine_c = {
      {
        function() return navic.get_location() end,
        cond = function() return navic.is_available() end,
      },
    },
    lualine_x = {
      -- {
      --   require("noice").api.statusline.mode.get,
      --   cond = require("noice").api.statusline.mode.has,
      --   color = { fg = "#ff9e64" },
      -- },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "%3p%%/%L" },
  },
  options = ops,
})
