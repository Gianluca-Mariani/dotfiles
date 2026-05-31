local M = {}

-- find Julia pane
local function find_julia_pane()
  local panes = vim.fn.systemlist(
    "tmux list-panes -F '#{pane_id} #{pane_current_command}'"
  )

  for _, line in ipairs(panes) do
    local pane, cmd = line:match("^(%%%d+)%s+(.*)$")
    if cmd and cmd:match("julia") then
      return pane
    end
  end

  return nil
end

-- exposed function
function M.send_to_julia(cmd)
  local pane = find_julia_pane()

  if not pane then
    print("No Julia pane found!")
    return
  end

  vim.fn.system({
    "tmux",
    "send-keys",
    "-t",
    pane,
    cmd,
    "Enter"
  })
end

return M
