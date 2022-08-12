-- vim.g.tokyonight_style = "storm"

local M = {}

-- Change this one: "github", "fox", "catppuccin"
local colorscheme = "catppuccin"

if colorscheme == "nightfox" then
  M.nightfox_theme_style = "nordfox"

  local palette = require("nightfox.palette").load(M.nightfox_theme_style)

  M.colors = {
    orange = palette.orange.base,
    error = palette.red.base,
    warning = palette.yellow.base,
    info = palette.blue.base,
    hint = palette.green.base,
    cyan = palette.cyan.base,
    bg_highlight = palette.bg1,
  }
  -- setup must be called before loading
  vim.cmd("colorscheme " .. M.nightfox_theme_style)
elseif colorscheme == "github" then
  -- Change this
  M.github_theme_style = "light_colorblind"
  M.lualine_theme_style = "github_" .. M.github_theme_style
  M.colors = require("github-theme").setup({
    theme_style = M.github_theme_style,
  })

  M.colors = require("github-theme.colors").setup({
    theme_style = M.github_theme_style,
  })
elseif colorscheme == "catppuccin" then
  local flavor = "frappe" -- latte, frappe, macchiato, mocha
  vim.g.catppuccin_flavour = flavor

  local palette = require("catppuccin.palettes").get_palette(flavor)

  require("catppuccin").setup({
    integrations = {
      lsp_trouble = true,
      dap = {
        enabled = true,
        enable_ui = false,
      },
      which_key = true,
      lightspeed = true,
    }
  })

  M.lualine_theme_style = "catppuccin"
  M.colors = {
    orange = palette.flamingo,
    error = palette.red,
    warning = palette.yellow,
    info = palette.blue,
    hint = palette.lavender,
    cyan = palette.sky,
    bg_highlight = palette.overlay0,
  }

  vim.cmd [[colorscheme catppuccin]]
end

M.colorscheme = colorscheme

return M
