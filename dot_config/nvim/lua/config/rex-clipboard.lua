-- Rex OSC 52 copy-only clipboard provider (no clipboard reads).
local M = {}
local previous, active, last

local function reload()
  -- Documented reload: only needed when the provider is already loaded.
  if vim.g.loaded_clipboard_provider ~= nil then
    vim.g.loaded_clipboard_provider = nil
    vim.cmd("runtime autoload/provider/clipboard.vim")
  end
end

local function copy(lines, regtype)
  last = { lines, regtype }
  -- Neovim passes a final empty item for linewise (V): no newline is appended.
  local seq = "\27]52;c;" .. vim.base64.encode(table.concat(lines, "\n")) .. "\27\\"
  if vim.env.TMUX and vim.env.TMUX ~= "" then
    seq = "\27Ptmux;" .. seq:gsub("\27", "\27\27") .. "\27\\"
  end
  vim.api.nvim_ui_send(seq)
end

local function paste()
  if last then
    return last
  end
  -- Explicit register 0 read avoids provider recursion before the first copy.
  return { vim.fn.getreg("0", 1, true), vim.fn.getregtype("0") }
end

function M.stop()
  if active then
    vim.g.clipboard = previous
    active = false
    last = nil
    reload()
  end
end

function M.setup(opts)
  M.stop()
  opts = opts or {}
  local in_rex = vim.env.REX_SESSION and vim.env.REX_SESSION ~= ""
  if opts.enabled == false or (opts.enabled == nil and not in_rex) or not vim.api.nvim_ui_send then
    return false
  end
  previous = vim.g.clipboard
  vim.g.clipboard = {
    name = "Rex OSC 52 (copy)",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
    cache_enabled = 0,
  }
  active = true
  reload()
  return true
end

return M
