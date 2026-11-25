local M = {}
local module = debug.getinfo(1, "S").source:gsub("^@", "")
local directory = module:match("^(.*)/[^/]+$") or "."
local events = dofile(directory .. "/rex-attention-events.lua")

local function app_on(api, info)
  local list = api.call("client.list", { kinds = { "app" } })
  local found
  for _, client in ipairs(list and list.clients or {}) do
    local other = client.info or {}
    if client.connection_state == "connected" and (not info or (info.label and info.label ~= ""
        and other.label == info.label and other.name == info.name and other.platform == info.platform)) then
      if found then return end -- Never pick an arbitrary app.
      found = client
    end
  end
  return found
end

local function caller(client_id, interactive)
  local result = client_id and rex.call("client.inspect", { client_id = client_id })
  local app = result and result.client
  if app and app.info and app.info.kind == "app" then return app end
  if not interactive then return app_on(rex) end
end

local function select_on(api, client, target)
  local result, err = api.call("client.perform", {
    client_id = client, action = "session.select", args = target, timeout_ms = 1000,
  })
  if not result then error(err or "Rex did not confirm session.select", 0) end
end

local function view(api, session)
  return api.call("session.view", { session_id = session }) or {}
end

-- Unqualified calls follow ctx.server, which has no route back to the home
-- server. This bridge only talks to the local server, never to an SSH host.
local function home(request)
  request.module = module
  local result, err = rex.exec(events.command("--timeout", "1s", "do", "-e",
    "return dofile(rex.args.module).bridge(rex.args)", "--args", assert(rex.json.encode(request)), "--json"), {
    timeout = 2, env = events.env,
  })
  if not result or not result.ok then
    error(err or (result and result.stderr:match("%S.*")) or "Rex home bridge failed", 0)
  end
  return assert(rex.json.decode(result.stdout))
end

function M.bridge(args)
  if args.target then
    select_on(rex, args.client_id, args.target)
    return { selected = true }
  end
  local snapshot = { app = caller(args.client_id, true), sessions = {} }
  if snapshot.app and args.wanted and next(args.wanted) then
    local list = rex.call("session.attach_all", { event_scope = "session" })
    for _, session in ipairs(list and list.sessions or {}) do
      local id = session.session_id
      if args.wanted[id] then
        snapshot.sessions[#snapshot.sessions + 1] = { session_id = id, windows = view(rex, id).windows }
      end
    end
  end
  return snapshot
end

function M.jump(ctx, index, dry_run)
  if not next(index.windows) then return { skipped = true } end
  local source = ctx.server or ""
  local interactive = ctx.origin == "key" or ctx.origin == "palette"
  local current = ctx.session_id and view(rex, ctx.session_id) or {}
  local active = current.active_window_id
  -- A key or palette action confirms the tab the app is showing. This also
  -- handles session.select when its target was already active in that session.
  if active and interactive and not dry_run then index.clear(active) end

  local wanted = {}
  for id, window in pairs(index.windows) do
    if id ~= active then
      wanted[window.host] = wanted[window.host] or {}
      wanted[window.host][window.session] = true
    end
  end
  if not next(wanted) then return { skipped = true } end

  local snapshot = source ~= "" and home({ client_id = ctx.client_id, wanted = wanted[""] }) or nil
  local app = snapshot and snapshot.app or (source == "" and caller(ctx.client_id, interactive))
  if not app then return { skipped = true } end

  local routes = { { api = rex, host = "", snapshot = snapshot } }
  local hosts, origin = rex.servers(), 1
  table.sort(hosts)
  for _, host in ipairs(hosts) do
    routes[#routes + 1] = { api = rex.server(host), host = host }
    if host == source then origin = #routes end
  end
  if routes[origin].host ~= source then return { skipped = true } end

  local function visit(route, windows, session, first, last)
    for i = first, last do
      local window = windows[i].window_id
      if window ~= active and index.windows[window] then
        local peer = app
        if route.host ~= "" then peer = app_on(route.api, app.info) end
        if not peer then return end
        local target = { session_id = session, window_id = window }
        if not dry_run then
          if route.host == "" and interactive and not route.snapshot then
            -- Queued actions execute after run returns and have no reply here.
            rex.client.queue("session.select", target)
          else
            local through = index.revision()
            if route.snapshot then
              local reply = home({ client_id = app.client_id, target = target })
              if not reply.selected then error("Rex did not confirm session.select", 0) end
            else
              select_on(route.api, peer.client_id, target)
            end
            -- Keep any notification that arrived while the app was switching.
            index.clear(window, through)
          end
        end
        target.host = route.host
        return target
      end
    end
  end

  local function visit_sessions(route, rows, first, last)
    for i = first, last do
      local row = rows[i]
      if row.session_id ~= ctx.session_id and wanted[route.host][row.session_id] then
        local windows = row.windows or view(route.api, row.session_id).windows or {}
        local target = visit(route, windows, row.session_id, 1, #windows)
        if target then return target end
      end
    end
  end

  local route = routes[origin]
  local windows, position = current.windows or {}, 0
  for i, window in ipairs(windows) do
    if window.window_id == active then position = i; break end
  end
  local target = visit(route, windows, ctx.session_id, position + 1, #windows)
  local rows, session_position = {}, 0
  if not target and wanted[source] then
    rows = (route.api.call("session.list") or {}).sessions or {}
    for i, row in ipairs(rows) do
      if row.session_id == ctx.session_id then session_position = i; break end
    end
    target = visit_sessions(route, rows, session_position + 1, #rows)
  end
  for offset = 1, #routes - 1 do
    if target then break end
    local next_route = routes[(origin + offset - 1) % #routes + 1]
    if wanted[next_route.host] then
      local list = next_route.snapshot or next_route.api.call("session.list") or {}
      local sessions = list.sessions or {}
      target = visit_sessions(next_route, sessions, 1, #sessions)
    end
  end
  return target or visit_sessions(route, rows, 1, session_position - 1)
    or visit(route, windows, ctx.session_id, 1, position - 1) or { skipped = true }
end

function M.setup()
  local index = events.index(events.cache_path())
  local observer, err = events.start(index)
  if not observer then rex.log("warn", "Could not start Rex attention observer: " .. tostring(err)) end
  rex.action{
    name = "next_attention_session",
    title = "Next Tab with Unread Notifications",
    category = "Tab",
    description = "Go to the next tab with a new program notification.",
    args = { start_only = "boolean?" },
    run = function(ctx, args)
      if not observer or not observer:running() then
        observer = assert(events.start(index))
      end
      if args.start_only then return { observer_pid = observer.pid } end
      return M.jump(ctx, index)
    end,
  }
  rex.bind("cmd+j", "next_attention_session")
end

return M
