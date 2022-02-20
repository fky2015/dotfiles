local M = {}

local toBool = {
  ["1"] = true,
  ["0"] = false,
}

--- Reload user costum lua configs.
function M.ReloadConfig()
	print("Reloading config...")
	for name, _ in pairs(package.loaded) do
		if name:match("^fky") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	print("Done!")
end

function M.FoldColumnToggle()
  if toBool[vim.api.nvim_win_get_option(0, "foldcolumn")] then
    vim.opt.foldcolumn = "0"
  else
    vim.opt.foldcolumn = "4"
  end
end

function M.QuickfixToggle()
  if toBool[vim.api.nvim_win_get_option(0, "quickfix")] then
    vim.api.nvim_win_set_option(0, "quickfix", "0")
  else
    vim.api.nvim_win_set_option(0, "quickfix", "1")
  end
end

return M
