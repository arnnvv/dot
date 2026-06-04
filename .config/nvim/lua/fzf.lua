local M = {}
local api = vim.api
local fn = vim.fn

local state = {
  buf = nil,
  win = nil,
  job = nil,
}

local function get_window_config()
  local width = vim.o.columns
  local height = vim.o.lines
  local win_height = math.ceil(height * 0.8)
  local win_width = math.ceil(width * 0.8)
  return {
    style = 'minimal',
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = math.ceil((height - win_height) / 2),
    col = math.ceil((width - win_width) / 2),
    border = 'rounded',
  }
end

local function create_fzf_window()
  local buf = api.nvim_create_buf(false, true)
  api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
  local win = api.nvim_open_win(buf, true, get_window_config())
  state.buf = buf
  state.win = win
  return buf, win
end

local function teardown_fzf_window(buf, win)
  if win and api.nvim_win_is_valid(win) then
    api.nvim_win_close(win, true)
  end
  if buf and api.nvim_buf_is_valid(buf) then
    pcall(api.nvim_buf_delete, buf, { force = true })
  end
  if state.buf == buf then
    state.buf = nil
  end
  if state.win == win then
    state.win = nil
  end
end

-- "command" is a full shell pipeline ending in fzf ...`.
-- append a redirect to a tempfile and read the selection back from it,
-- which is far more reliable than scraping the rendered terminal buffer.
local function run_fzf(command, on_select)
  if state.job then
    pcall(fn.jobstop, state.job)
    state.job = nil
  end

  local tmpfile = fn.tempname()
  local buf, win = create_fzf_window()

  -- wrap in a brace group so the redirect applies to fzf's stdout
  -- so it can actually open, else it would be an empty temp file
  local full_cmd = ('{ %s\n} > %s'):format(command, fn.shellescape(tmpfile))

  local job
  job = fn.jobstart(full_cmd, {
    term = true,
    on_exit = function(_, code, _)
      vim.schedule(function()
        teardown_fzf_window(buf, win)
        if state.job == job then
          state.job = nil
        end

        local lines = {}
        if fn.filereadable(tmpfile) == 1 then
          lines = fn.readfile(tmpfile)
        end
        pcall(fn.delete, tmpfile)

        if code == 0 and lines[1] and lines[1] ~= '' then
          on_select(lines[1])
        end
      end)
    end,
  })

  if job <= 0 then
    teardown_fzf_window(buf, win)
    pcall(fn.delete, tmpfile)
    vim.notify('fzf.lua: failed to start job', vim.log.levels.ERROR)
    return
  end

  state.job = job
  vim.cmd('startinsert')
end

function M.grep_project()
  -- --disabled turns fzf into a pure selector; ripgrep does the filtering
  -- and is re-run on every keystroke via `change:reload`.
  -- The `[ -n {q} ]` guard avoids running `rg ''` (match-everything) when the
  -- query is empty, and the `{ ...; }` group keeps a `head` SIGPIPE from
  -- clearing the result list. `-- {q}` stops queries starting with `-` from
  -- being parsed as ripgrep flags.
  local command = [[
    true | fzf --ansi --disabled \
      --bind 'start:reload(echo "Type to search...")' \
      --bind 'change:reload([ -n {q} ] && { rg --column --line-number --no-heading --color=always --smart-case --hidden --max-columns=150 --max-columns-preview --glob "!.git" -- {q} 2>/dev/null | head -n 5000; } || echo)'
  ]]
  run_fzf(command, function(selection)
    -- lazy (.-) matches the first file:line:col, so a colon inside the
    -- matched text can't throw off the capture.
    local file, lnum, col = selection:match('^(.-):(%d+):(%d+):')
    if file and fn.filereadable(file) == 1 then
      vim.cmd.edit(fn.fnameescape(file))
      pcall(api.nvim_win_set_cursor, 0, { tonumber(lnum), tonumber(col) - 1 })
      vim.cmd.normal({ 'zz', bang = true })
    end
  end)
end

function M.find_files()
  local command = 'fd --hidden --type f --exclude .git | fzf'
  run_fzf(command, function(selection)
    if fn.filereadable(selection) == 1 then
      vim.cmd.edit(fn.fnameescape(selection))
    end
  end)
end

return M
