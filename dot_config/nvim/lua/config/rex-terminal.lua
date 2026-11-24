local M = {}

local OSC, ST = "\27]7501;", "\27\\"
local states = { idle = true, working = true, done = true, blocked = true, error = true, clear = true }
local priority = { idle = 0, working = 1, done = 2, error = 3, blocked = 4 }
local group, namespace
local buffers = {}
local zellij = {}
local closed_channels = {}
local program_root

local function is_active(state)
  return state == "working" or state == "blocked"
end

local function root(buf)
  return namespace .. "/" .. buf
end

local function send(sequence)
  if vim.env.TMUX and vim.env.TMUX ~= "" then
    sequence = "\27Ptmux;" .. sequence:gsub("\27", "\27\27") .. ST
  end
  vim.api.nvim_ui_send(sequence)
end

local function sync_root()
  if not group then
    return
  end
  local selected
  for _, records in pairs(buffers) do
    for _, record in pairs(records) do
      if
        not selected
        or priority[record.state] > priority[selected.state]
        or (priority[record.state] == priority[selected.state] and record.updated > selected.updated)
      then
        selected = record
      end
    end
  end
  -- Rex plays activity sounds for the root record, while child records provide details.
  if selected ~= program_root then
    send(OSC .. (selected and selected.body or "state=idle") .. ST)
  end
  program_root = selected
end

local function clear(buf)
  zellij[buf] = nil
  closed_channels[buf] = nil
  if buffers[buf] then
    send(OSC .. "state=clear:id=" .. root(buf) .. ST)
    buffers[buf] = nil
  end
  sync_root()
end

local function apply_status(ev, body, terminator)
  if body == "?" then
    local channel = vim.bo[ev.buf].channel
    if channel > 0 then
      pcall(vim.api.nvim_chan_send, channel, OSC .. "?" .. ST)
    end
    return
  end

  local fields, root_fields, state, id, has_id = {}, {}, nil, root(ev.buf), false
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
      if key ~= "id" then
        root_fields[#root_fields + 1] = key .. "=" .. value
      end
    end
  end
  if not states[state] then
    return
  end
  -- A late report can still record completion, but cannot revive a closed terminal.
  if is_active(state) and closed_channels[ev.buf] == vim.bo[ev.buf].channel then
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

  -- Retain completed records until the buffer is removed, including the root selection.
  buffers[ev.buf] = buffers[ev.buf] or {}
  local active = buffers[ev.buf]
  if state == "clear" then
    for child in pairs(active) do
      if child == id or child:sub(1, #id + 1) == id .. "/" then
        active[child] = nil
      end
    end
  else
    active[id] = { state = state, body = table.concat(root_fields, ":"), updated = vim.uv.hrtime() }
  end
end

local function zellij_status(ev, body, terminator)
  local buf, current_group, channel = ev.buf, group, vim.bo[ev.buf].channel
  local argv = vim.api.nvim_get_chan_info(channel).argv or {}
  if not argv[1] or vim.fs.basename(argv[1]) ~= "zellij" or argv[#argv - 2] ~= "attach" then
    return false
  end
  local session = argv[#argv]
  local pending = zellij[buf] or { records = {} }
  zellij[buf] = pending
  pending.body, pending.terminator = body, terminator
  if pending.running then
    pending.dirty = true
    return true
  end
  pending.running, pending.dirty = true, false

  -- Zellij exports attention after applying its own seen rules. Its raw records
  -- preserve the native program's done/error state even when attention is idle.
  vim.system({ argv[1], "-s", session, "action", "list-panes", "--json" }, { text = true }, function(result)
    vim.schedule(function()
      if
        group ~= current_group
        or zellij[buf] ~= pending
        or not vim.api.nvim_buf_is_valid(buf)
        or vim.bo[buf].channel ~= channel
      then
        return
      end
      pending.running = false
      local ok, panes = pcall(vim.json.decode, result.stdout or "")
      if result.code ~= 0 or not ok or type(panes) ~= "table" then
        if not pending.native then
          apply_status(ev, pending.body, pending.terminator)
          sync_root()
        end
        if pending.dirty then
          zellij_status(ev, pending.body, pending.terminator)
        end
        return
      end
      local records = {}
      for _, pane in ipairs(panes) do
        if not pane.is_plugin then
          if type(pane.program_status) == "table" then
            for _, record in ipairs(pane.program_status) do
              local state = type(record.state) == "string" and record.state:lower() or ""
              if states[state] then
                local id = "zellij/" .. pane.id
                if type(record.id) == "string" and record.id ~= "" then
                  id = id .. "/" .. record.id
                end
                local fields = { "state=" .. state, "id=" .. id }
                for _, key in ipairs({ "app", "kind", "progress", "title", "msg" }) do
                  local value = record[key]
                  if value ~= nil and value ~= vim.NIL then
                    if key == "title" or key == "msg" then
                      value = vim.base64.encode(value)
                    elseif key == "kind" then
                      value = value:lower()
                    end
                    fields[#fields + 1] = key .. "=" .. value
                  end
                end
                records[id] = { body = table.concat(fields, ":"), updated = record.updated_ms }
              end
            end
          end
        end
      end
      for id in pairs(pending.records) do
        if not records[id] then
          apply_status(ev, "state=clear:id=" .. id, ST)
        end
      end
      if next(records) then
        -- Native child records describe the programs; retire the aggregate.
        if not pending.native then
          apply_status(ev, "state=idle:app=zellij", ST)
        end
        for id, report in pairs(records) do
          local previous = pending.records[id]
          if not previous or previous.body ~= report.body or previous.updated ~= report.updated then
            apply_status(ev, report.body, ST)
          end
        end
      else
        apply_status(ev, pending.body, pending.terminator)
      end
      -- Publish the root only after the entire snapshot has been applied.
      sync_root()
      pending.records, pending.native = records, next(records) ~= nil
      if pending.dirty then
        zellij_status(ev, pending.body, pending.terminator)
      end
    end)
  end)
  return true
end

local function request(ev)
  local data = ev.data or {}
  local sequence = data.sequence
  if type(sequence) ~= "string" or #sequence > 4096 then
    return
  end
  local terminator = data.terminator == "\7" and "\7" or ST
  if sequence:sub(1, #OSC) == OSC then
    local body = sequence:sub(#OSC + 1)
    if (":" .. body .. ":"):find(":app=zellij:", 1, true) and zellij_status(ev, body, terminator) then
      return
    end
    if body:match("^state=clear$") then
      zellij[ev.buf] = nil
    end
    apply_status(ev, body, terminator)
    sync_root()
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
  if program_root then
    send(OSC .. "state=idle" .. ST)
    program_root = nil
  end
  zellij = {}
  closed_channels = {}
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
      closed_channels[ev.buf] = channel
      -- TermClose can precede the last queued TermRequest; drain it before settling active records.
      vim.schedule(function()
        if group ~= current_group or not vim.api.nvim_buf_is_valid(ev.buf) or vim.bo[ev.buf].channel ~= channel then
          return
        end
        -- Replacing a parent preserves completed descendants, whereas clearing it would remove them.
        for id, record in pairs(buffers[ev.buf] or {}) do
          if is_active(record.state) then
            send(OSC .. "state=idle:id=" .. id .. ST)
            buffers[ev.buf][id] = {
              state = "idle",
              body = (":" .. record.body):gsub(":state=[^:]+", ":state=idle", 1):sub(2),
              updated = vim.uv.hrtime(),
            }
          end
        end
        sync_root()
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
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" and vim.bo[buf].channel > 0 then
      zellij_status({ buf = buf }, "state=idle:app=zellij", ST)
    end
  end
  return true
end

return M
