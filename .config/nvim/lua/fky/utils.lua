local M = {}

-- Reload user costum lua configs.
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

return M
