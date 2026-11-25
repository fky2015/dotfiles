local M = {}
local unpack = table.unpack or unpack
local source = debug.getinfo(1, "S").source:gsub("^@", "")
local scope = { REX_SESSION = false, REX_BLOCK = false, REX_CLIENT = false }
local launcher = [[
  PATH="${REX_BIN_DIR:+$REX_BIN_DIR:}$PATH${XDG_BIN_HOME:+:$XDG_BIN_HOME}${HOME:+:$HOME/.local/bin}"
  export PATH
  wait_local=$1
  shift
  if [ "$wait_local" = yes ]; then
    # init.lua can run before the server opens its socket.
    attempts=20
    until rex --autostart=false --timeout 1s whoami >/dev/null 2>&1; do
      attempts=$((attempts - 1))
      [ "$attempts" -gt 0 ] || exit 1
      sleep 0.25
    done
  fi
  exec rex "$@"
]]

local function command(wait_local, ...)
  return { "sh", "-c", launcher, "rex", wait_local and "yes" or "no", "--autostart=false", ... }
end

function M.command(...)
  return command(false, ...)
end

M.env = scope

function M.cache_path()
  local dir, home = os.getenv("XDG_CACHE_HOME"), os.getenv("HOME")
  if not dir or dir == "" then dir = home and home .. "/Library/Caches" end
  return dir and dir .. "/rex-next-attention.json"
end

function M.index(cache)
  local windows, records = {}, {}
  local revision, instance = 0, nil
  local function forget(key)
    local window = records[key]
    if not window then return false end
    records[key], window.keys[key] = nil, nil
    if not next(window.keys) then windows[window.window] = nil end
    return true
  end
  local function notice(event)
    forget(event.key)
    revision = revision + 1
    local window = windows[event.window] or {
      host = event.host, session = event.session, window = event.window, keys = {},
    }
    window.keys[event.key] = { event = event, revision = revision }
    windows[event.window], records[event.key] = window, window
    return true
  end
  local function remove(id, through)
    local window, changed = windows[id], false
    if window then
      for key, record in pairs(window.keys) do
        if not through or record.revision <= through then changed = forget(key) or changed end
      end
    end
    return changed
  end
  local function save()
    if not cache or not instance then return end
    local notices = {}
    for key, window in pairs(records) do notices[#notices + 1] = window.keys[key].event end
    local data = rex.json.encode({ instance = instance, notices = notices })
    if not data then return end
    local temp = cache .. "." .. instance .. ".tmp"
    local file = io.open(temp, "w")
    if not file then return end
    local written = file:write(data)
    local closed = file:close()
    if not (written and closed and os.rename(temp, cache)) then os.remove(temp) end
  end
  local function restore()
    local file = cache and io.open(cache, "r")
    if not file then return end
    local data = file:read("*a")
    file:close()
    local snapshot = data and rex.json.decode(data)
    if type(snapshot) ~= "table" or snapshot.instance ~= instance or type(snapshot.notices) ~= "table" then return end
    for _, event in ipairs(snapshot.notices) do
      if type(event) == "table" and event.kind == "notice" and type(event.host) == "string"
          and type(event.session) == "string" and type(event.window) == "string"
          and type(event.block) == "string" and type(event.key) == "string" then
        notice(event)
      end
    end
  end
  local function clear(id, through)
    if remove(id, through) then save() end
  end
  local function apply(event)
    local changed = false
    if event.kind == "notice" then
      changed = notice(event)
    elseif event.kind == "visit" or event.kind == "window_closed" then
      changed = remove(event.window)
    elseif event.kind == "drop" then
      changed = forget(event.key)
    elseif event.kind == "block_closed" then
      for key, window in pairs(records) do
        if window.keys[key].event.block == event.block then changed = forget(key) or changed end
      end
    elseif event.kind == "session_destroyed" then
      for id, window in pairs(windows) do
        if window.session == event.session then changed = remove(id) or changed end
      end
    elseif event.kind == "attached" then
      if event.host == "" and not instance then
        instance = event.instance
        restore()
      end
      -- A reconnect isn't a visit. Keep unread tabs in live sessions.
      for id, window in pairs(windows) do
        if window.host == event.host and not event.sessions[window.session] then
          changed = remove(id) or changed
        end
      end
    end
    if changed then save() end
  end
  return { windows = windows, clear = clear, apply = apply, revision = function() return revision end }
end

-- exec callbacks may split a line at any byte. Only the small routing records
-- printed below are decoded here, not terminal text or notification bodies.
local function lines(consume)
  local trailing = ""
  return function(chunk)
    local input = trailing .. chunk
    local start = 1
    for line, ending in input:gmatch("([^\n]*)\n()") do
      if line ~= "" then consume(line) end
      start = ending
    end
    trailing = input:sub(start)
  end
end

local function publish(event)
  io.stdout:write(assert(rex.json.encode(event)) .. "\n")
  io.stdout:flush()
end

local function observe(host)
  local snapshot = assert(rex.call("session.attach_all", { event_scope = "all" }))
  local status = host == "" and assert(rex.call("server.status")) or nil
  local sessions = {}
  for _, session in ipairs(snapshot.sessions or {}) do sessions[session.session_id] = true end
  publish({ kind = "attached", host = host, sessions = sessions, instance = status and status.instance_id })
  local function key(ctx, id)
    return ctx.block_id .. ":status:" .. (id or "")
  end
  local function notice(ctx, id)
    local block = rex.session.describe_block({ session_id = ctx.session_id, block_id = ctx.block_id })
    local info = block and block.block
    if info and info.placement == "placed" and info.window_id then
      publish({ kind = "notice", host = host, session = ctx.session_id,
        window = info.window_id, block = ctx.block_id, key = id })
    end
  end
  rex.on("terminal.desktop_notification", function(ctx)
    notice(ctx, ctx.block_id .. ":desktop")
  end)
  rex.on("terminal.program_status_changed", function(ctx, ev)
    local record = ev.record or {}
    local id = key(ctx, record.id or ev.id)
    if record.state == "blocked" or record.state == "error" or record.state == "done" then
      notice(ctx, id)
    else
      publish({ kind = "drop", key = id })
    end
  end)
  rex.on("terminal.program_status_removed", function(ctx, ev)
    for _, id in ipairs(ev.ids or {}) do publish({ kind = "drop", key = key(ctx, id) }) end
  end)
  rex.on("active_window_changed", function(ctx, ev)
    publish({ kind = "visit", session = ctx.session_id, window = ev.window_id })
  end)
  rex.on("window_closed", function(_, ev) publish({ kind = "window_closed", window = ev.window_id }) end)
  rex.on("block_closed", function(_, ev) publish({ kind = "block_closed", block = ev.block_id }) end)
  rex.on("session_destroyed", function(_, ev) publish({ kind = "session_destroyed", session = ev.session_id }) end)
  return status
end

local function observer_command(host)
  local args = {}
  if host then args = { "-S", host } end
  local function push(...)
    for _, value in ipairs({ ... }) do args[#args + 1] = value end
  end
  push("--timeout", "3s", "do", "-e", "dofile(rex.args.module).observe(rex.args)", "--all", "--args",
    assert(rex.json.encode({ module = source, host = host })))
  return command(not host, unpack(args))
end

function M.observe(args)
  if args.host then return observe(args.host) end
  local status = observe("")
  local generation = (status.config or {}).generation or 0
  local children = {}
  local function refresh()
    for _, host in ipairs(rex.servers()) do
      if not children[host] or not children[host]:running() then
        children[host] = rex.exec.start(observer_command(host), {
          detach = true, env = scope, stderr = false,
          stdout = lines(function(line) io.stdout:write(line .. "\n"); io.stdout:flush() end),
        })
      end
    end
  end
  rex.on("keymap_changed", function(_, ev)
    if ev.generation and ev.generation <= generation then return end
    for _, child in pairs(children) do if child:running() then child:kill() end end
    rex.stop(0)
  end)
  -- Reconnect an event stream after a remote restart; never poll tabs.
  rex.every(15, refresh)
  refresh()
end

function M.start(index)
  return rex.exec.start(observer_command(), {
    detach = true, env = scope, stderr = false,
    stdout = lines(function(line)
      local event = rex.json.decode(line)
      if type(event) == "table" then index.apply(event) end
    end),
  })
end

return M
