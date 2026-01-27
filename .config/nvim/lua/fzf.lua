local M = {}

local api = vim.api
local fn = vim.fn

local function create_fzf_window()
  local width = vim.o.columns
  local height = vim.o.lines
  local win_height = math.ceil(height * 0.8)
  local win_width = math.ceil(width * 0.8)

  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, true, {
    style = 'minimal',
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = math.ceil((height - win_height) / 2),
    col = math.ceil((width - win_width) / 2),
    border = 'rounded',
  })
  return buf, win
end

function M.grep_project()
  local buf, win = create_fzf_window()

  local command = [[
    true | fzf --ansi --disabled --height 100% \
      --bind 'start:reload(echo "Type to search...")' \
      --bind 'change:reload:rg --column --line-number --no-heading --color=always --smart-case --hidden --max-columns=150 --max-columns-preview --glob "!.git" --glob "!node_modules" --glob "!*.min.js" --glob "!*.min.css" {q} 2>/dev/null | head -n 5000 || true'
  ]]

  fn.termopen(command, {
    on_exit = function(_, code, _)
      local lines = api.nvim_buf_get_lines(buf, 0, 1, false)

      vim.schedule(function()
        if api.nvim_win_is_valid(win) then
          api.nvim_win_close(win, true)
        end

        if code == 0 and lines[1] and lines[1] ~= "" then
          local file, lnum, col = lines[1]:match('^(.+):(%d+):(%d+):')
          if file and fn.filereadable(file) == 1 then
            vim.cmd.edit(fn.fnameescape(file))
            pcall(api.nvim_win_set_cursor, 0, { tonumber(lnum), tonumber(col) - 1 })
            vim.cmd.normal({ 'zz', bang = true })
          end
        end
      end)
    end,
  })
  vim.cmd('startinsert')
end

function M.find_files()
  local buf, win = create_fzf_window()

  local command = 'fd --hidden --type f --strip-cwd-prefix --exclude .git --exclude node_modules --exclude target | fzf --height 100%'

  fn.termopen(command, {
    on_exit = function(_, code, _)
      local lines = api.nvim_buf_get_lines(buf, 0, 1, false)

      vim.schedule(function()
        if api.nvim_win_is_valid(win) then
          api.nvim_win_close(win, true)
        end

        if code == 0 and lines[1] and lines[1] ~= "" then
          local selection = lines[1]
          if fn.filereadable(selection) == 1 then
            vim.cmd.edit(fn.fnameescape(selection))
          end
        end
      end)
    end,
  })
  vim.cmd('startinsert')
end

return M
