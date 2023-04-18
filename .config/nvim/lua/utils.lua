local M = {}

local toBool = {
	["1"] = true,
	["0"] = false,
}

function M.FoldColumnToggle()
	if toBool[vim.api.nvim_win_get_option(0, "foldcolumn")] then
		vim.opt.foldcolumn = "0"
	else
		vim.opt.foldcolumn = "4"
	end
end

return M
