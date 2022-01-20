-- vim.g.tokyonight_style = "storm"

local github_theme_style = "light"
require("github-theme").setup({
	theme_style = github_theme_style,
})

local colors = require("github-theme.colors").setup({
	theme_style = github_theme_style,
})

require("scrollbar").setup({
	handle = {
		color = colors.bg_highlight,
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
		"qf",
    "alpha"
	},
})
