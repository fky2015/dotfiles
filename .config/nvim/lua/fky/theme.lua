-- vim.g.tokyonight_style = "storm"

local M = {}

-- Change this one: "github", "fox"
local colorscheme = "nightfox"

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
end

M.colorscheme = colorscheme

return M
