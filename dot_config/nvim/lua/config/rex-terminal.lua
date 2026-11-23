local M = {}

local OSC, ST = "\27]7501;", "\27\\"
local states = { idle = true, working = true, done = true, blocked = true, error = true, clear = true }
local group, namespace
local buffers = {}

local function root(buf)
  return namespace .. "/" .. buf
end

local function send(sequence)
  if vim.env.TMUX and vim.env.TMUX ~= "" then
    sequence = "\27Ptmux;" .. sequence:gsub("\27", "\27\27") .. ST
  end
  vim.api.nvim_ui_send(sequence)
end

local function clear(buf)
  if buffers[buf] then
    send(OSC .. "state=clear:id=" .. root(buf) .. ST)
    buffers[buf] = nil
  end
end

local function status(ev, body, terminator)
  if body == "?" then
    local channel = vim.bo[ev.buf].channel
    if channel > 0 then
      pcall(vim.api.nvim_chan_send, channel, OSC .. "?" .. ST)
    end
    return
  end

  local fields, state, id, has_id = {}, nil, root(ev.buf), false
  for field in body:gmatch("[^:]+") do
    local key, value = field:match("^%s*([a-z]+)%s*=%s*(.-)%s*$")
    if key then
      if key == "id" then
        if
          value == ""
          or value:find("[^%w_./+-]")
          or value:find("^/")
          or value:find("/$")
          or value:find("//", 1, true)
        then
          return
        end
        id, has_id = root(ev.buf) .. "/" .. value, true
        value = id
      elseif key == "state" then
        state = value
      end
      fields[#fields + 1] = key .. "=" .. value
    end
  end
  if not states[state] then
    return
  end
  if not has_id then
    fields[#fields + 1] = "id=" .. id
  end
  local sequence = OSC .. table.concat(fields, ":") .. terminator
  if #sequence > 4096 then
    return
  end
  send(sequence)

  -- Keep only active records; completed records live in Rex until the buffer is removed.
  buffers[ev.buf] = buffers[ev.buf] or {}
  local active = buffers[ev.buf]
  if state == "clear" then
    for child in pairs(active) do
      if child == id or child:sub(1, #id + 1) == id .. "/" then
        active[child] = nil
      end
    end
  else
    active[id] = (state == "working" or state == "blocked") and true or nil
  end
end

local function request(ev)
  local data = ev.data or {}
  local sequence = data.sequence
  if type(sequence) ~= "string" or #sequence > 4096 then
    return
  end
  local terminator = data.terminator == "\7" and "\7" or ST
  if sequence:sub(1, #OSC) == OSC then
    status(ev, sequence:sub(#OSC + 1), terminator)
  elseif
    (sequence:sub(1, 4) == "\27]9;" and sequence:sub(5, 6) ~= "4;") or sequence:sub(1, 13) == "\27]777;notify;"
  then
    send(sequence .. terminator)
  end
end

function M.stop()
  if group then
    vim.api.nvim_del_augroup_by_id(group)
    group = nil
  end
  for buf in pairs(buffers) do
    clear(buf)
  end
end

function M.setup(opts)
  M.stop()
  opts = opts or {}
  local in_rex = vim.env.REX_SESSION and vim.env.REX_SESSION ~= ""
  if opts.enabled == false or (opts.enabled == nil and not in_rex) or not vim.api.nvim_ui_send then
    return false
  end

  namespace = "nvim/" .. vim.fn.getpid()
  group = vim.api.nvim_create_augroup("RexTerminal", { clear = true })
  vim.api.nvim_create_autocmd("TermRequest", { group = group, callback = request })
  vim.api.nvim_create_autocmd("TermClose", {
    group = group,
    callback = function(ev)
      local current_group, channel = group, vim.bo[ev.buf].channel
      -- TermClose can precede the last queued TermRequest; drain it before settling active records.
      vim.schedule(function()
        if group ~= current_group or not vim.api.nvim_buf_is_valid(ev.buf) or vim.bo[ev.buf].channel ~= channel then
          return
        end
        -- Replacing a parent preserves completed descendants, whereas clearing it would remove them.
        for id in pairs(buffers[ev.buf] or {}) do
          send(OSC .. "state=idle:id=" .. id .. ST)
        end
        if buffers[ev.buf] then
          buffers[ev.buf] = {}
        end
      end)
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(ev)
      clear(ev.buf)
    end,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", { group = group, callback = M.stop })
  return true
end

return M
