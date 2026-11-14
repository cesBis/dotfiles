local M = {}

function M.setup()
  vim.g.slime_target = 'tmux'
  vim.g.slime_no_mappings = 1
  vim.g.slime_dont_ask_default = 1
  vim.g.slime_bracketed_paste = 1
end

local function configure_target()
  local socket = vim.env.TMUX and vim.env.TMUX:match('^(.*),%d+,%d+$')
  if not socket or not vim.env.TMUX_PANE then
    vim.notify('Terminal sending requires Neovim inside tmux.', vim.log.levels.WARN)
    return false
  end

  local function tmux(args)
    local command = { 'tmux', '-S', socket }
    vim.list_extend(command, args)
    local result = vim.system(command, { text = true }):wait()
    if result.code == 0 then
      return vim.trim(result.stdout)
    end
  end

  local session = tmux({ 'display-message', '-p', '-t', vim.env.TMUX_PANE, '#{session_id}' })
  local terminal = session and tmux({ 'show-options', '-qv', '-t', session, '@workspace_terminal' })
  local state = terminal and terminal ~= '' and
    tmux({ 'display-message', '-p', '-t', terminal, '#{session_id}:#{pane_dead}' })
  if not session or state ~= session .. ':0' then
    vim.notify('No project terminal. Show/start it with C-Space r first.', vim.log.levels.WARN)
    return false
  end

  -- Resolve on every send: parked panes and explicitly restarted terminals
  -- must work without retaining a stale per-buffer target.
  vim.b.slime_config = { socket_name = socket, target_pane = terminal }
  return true
end

function M.send_line()
  if not configure_target() then return end
  local cursor = vim.api.nvim_win_get_cursor(0)
  local total = vim.api.nvim_buf_line_count(0)
  local last = math.min(cursor[1] + vim.v.count1 - 1, total)
  vim.fn['slime#send_range'](cursor[1], last)
  vim.api.nvim_win_set_cursor(0, { math.min(last + 1, total), cursor[2] })
end

function M.send_selection()
  if not configure_target() then return end
  vim.fn['slime#send_op'](vim.fn.visualmode(), 1)
end

return M
