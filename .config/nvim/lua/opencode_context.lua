local M = {}
local pending = false

function M.send()
  if pending then return end
  local socket = vim.env.TMUX and vim.env.TMUX:match('^(.*),%d+,%d+$')
  local source = vim.env.TMUX_PANE
  if not socket or not source then
    vim.notify('OpenCode handoff requires Neovim inside tmux.', vim.log.levels.WARN)
    return
  end
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' or vim.bo.buftype ~= '' or path:find('[\r\n]') then
    vim.notify('OpenCode handoff needs a named file buffer.', vim.log.levels.WARN)
    return
  end
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local hint = ' [file: ' .. path .. ':' .. line .. '] '

  local function tmux(args)
    local command = { 'tmux', '-S', socket }
    vim.list_extend(command, args)
    local result = vim.system(command, { text = true }):wait()
    if result.code == 0 then return vim.trim(result.stdout) end
  end
  local session = tmux({ 'display-message', '-p', '-t', source, '#{session_id}' })
  if not session then return end

  local function fail(message)
    pending = false
    vim.notify(message, vim.log.levels.WARN)
  end

  local attempts = 0
  local function wait_for_prompt()
    attempts = attempts + 1
    local pane = tmux({ 'show-options', '-qv', '-t', session, '@workspace_opencode' })
    local state = pane and pane ~= '' and tmux({ 'display-message', '-p', '-t', pane,
      '#{session_id}:#{pane_dead}:#{pane_in_mode}:#{alternate_on}:#{bracket_paste_flag}:#{cursor_flag}' })
    -- These terminal flags establish a live TUI with an active input cursor,
    -- not which input owns focus. Keep OpenCode on its main prompt, not a dialog.
    if state ~= session .. ':0:0:1:1:1' then
      if attempts < 100 then
        vim.defer_fn(wait_for_prompt, 100)
      else
        fail('OpenCode input is not ready. Return to its main prompt and retry Space b.')
      end
      return
    end

    -- Dedicated bindings in cli.json: return from an internal side pane and
    -- move to the end of the entire draft, not merely its current line.
    if not tmux({ 'send-keys', '-t', pane, 'F12', 'C-End' }) then
      fail('Could not focus the OpenCode prompt.')
      return
    end
    vim.defer_fn(function()
      local current = tmux({ 'display-message', '-p', '-t', pane,
        '#{session_id}:#{pane_dead}:#{pane_in_mode}:#{alternate_on}:#{bracket_paste_flag}:#{cursor_flag}' })
      if current ~= session .. ':0:0:1:1:1' then
        fail('OpenCode input changed before the paste. Retry from its main prompt.')
        return
      end
      -- Bypass slime's interpreter transformations. The hint ends in a space,
      -- so its bracketed-paste backend never turns a trailing newline into Enter.
      local previous = vim.b.slime_bracketed_paste
      vim.b.slime_bracketed_paste = 1
      local ok, err = pcall(vim.fn['slime#targets#tmux#send'],
        { socket_name = socket, target_pane = pane }, hint)
      vim.b.slime_bracketed_paste = previous
      pending = false
      if not ok or vim.v.shell_error ~= 0 then
        vim.notify('OpenCode paste failed: ' .. tostring(err or 'tmux command failed'), vim.log.levels.ERROR)
      else
        tmux({ 'select-window', '-t', pane })
        tmux({ 'select-pane', '-t', pane })
      end
    end, 100)
  end

  pending = true
  local ok, err = pcall(vim.system, { 'tmux-workspace', 'opencode', source }, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        fail('Could not show OpenCode: ' .. vim.trim(result.stderr or ''))
        return
      end
      wait_for_prompt()
    end)
  end)
  if not ok then fail('Could not run tmux-workspace: ' .. tostring(err)) end
end

return M
