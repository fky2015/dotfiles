local M = {}

-- Rex invokes this over Neovim RPC before moving to an adjacent terminal pane.
function M.navigate(direction, pid)
  if pid ~= vim.fn.getpid() or not ({ h = true, j = true, k = true, l = true })[direction] then
    return "pass"
  end
  local mode = vim.api.nvim_get_mode()
  if mode.blocking or not (mode.mode:match("^n") or mode.mode == "t") then
    return "pass"
  end
  -- Floating dialogs keep their usual control keys instead of changing panes.
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    return "pass"
  end

  local target = vim.fn.winnr(direction)
  if target == vim.fn.winnr() then
    return "edge"
  end
  vim.cmd("wincmd " .. direction)
  return "moved"
end

function M.setup(opts)
  opts = opts or {}
  if not (opts.block_id or vim.env.REX_BLOCK) or not (opts.session_id or vim.env.REX_SESSION) then
    return
  end
  local runtime = "/tmp/rex-nvim-" .. vim.uv.getuid()
  vim.fn.mkdir(runtime, "p", 448) -- 0700
  local socket = vim.v.servername
  if socket == "" then
    socket = vim.fn.serverstart(runtime .. "/" .. vim.fn.getpid() .. ".sock")
  end
  if not socket or socket == "" then
    return
  end

  local pid = vim.fn.getpid()
  local paths = { runtime .. "/" .. pid }
  -- Neovim 0.12 can run its TUI as the foreground process and its RPC core
  -- as a child. Rex sees the TUI PID, while getpid() returns the core PID.
  local parent = vim.uv.os_getppid()
  local command = vim.fn.system({ "ps", "-p", tostring(parent), "-o", "comm=" }):gsub("%s+$", "")
  local name = command:match("([^/]+)$") or command
  if name == "nvim" or name == "nvimdiff" then
    paths[#paths + 1] = runtime .. "/" .. parent
  end
  for _, path in ipairs(paths) do
    vim.fn.writefile({ socket, tostring(pid) }, path)
    vim.uv.fs_chmod(path, 384) -- 0600
  end
  _G.rex_navigate_window = M.navigate
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("RexNavigation", { clear = true }),
    callback = function()
      for _, path in ipairs(paths) do
        vim.fn.delete(path)
      end
    end,
  })
end

return M
