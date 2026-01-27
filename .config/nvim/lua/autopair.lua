local M = {}

local pair_result = {
  ['('] = '()<Left>', ['['] = '[]<Left>', ['{'] = '{}<Left>',
  ['"'] = '""<Left>', ["'"] = "''<Left>", ['`'] = '``<Left>',
}
local closing = { ['('] = ')', ['['] = ']', ['{'] = '}', ['"'] = '"', ["'"] = "'", ['`'] = '`' }
local skip = { [')'] = true, [']'] = true, ['}'] = true, ['"'] = true, ["'"] = true, ['`'] = true, [' '] = true, ['\t'] = true }

function M.setup_autopairs()
  local get_cursor = vim.api.nvim_win_get_cursor
  local get_line = vim.api.nvim_get_current_line

  for open, _ in pairs(closing) do
    vim.keymap.set('i', open, function()
      local col = get_cursor(0)[2]
      local next_char = get_line():sub(col + 1, col + 1)
      return (next_char == '' or skip[next_char]) and pair_result[open] or open
    end, { expr = true, noremap = true })
  end

  vim.keymap.set('i', '<BS>', function()
    local col = get_cursor(0)[2]
    if col == 0 then return '<BS>' end
    local line = get_line()
    return closing[line:sub(col, col)] == line:sub(col + 1, col + 1) and '<BS><Del>' or '<BS>'
  end, { expr = true, noremap = true })
end

return M
