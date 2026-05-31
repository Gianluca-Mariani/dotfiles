-- lua/mappings.lua
local map = vim.keymap.set
local tmux = require("custom.tmux")

local move_mode = false

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>r", function()
  local file = vim.fn.expand("%:p")
  tmux.send_to_julia('include("' .. file .. '")')
end, { desc = "Run Julia file" })


map("n", "<leader>m", function()
  move_mode = not move_mode

  if move_mode then
    vim.notify("MOVE MODE ON")
  else
    vim.notify("MOVE MODE OFF")
  end
end, { desc = "Toggle move mode" })

map("n", "j", function()
  if move_mode then
    vim.cmd("m .+1")
    vim.cmd("normal! ==")
  else
    vim.cmd("normal! j")
  end
end)

map("n", "k", function()
  if move_mode then
    vim.cmd("m .-2")
    vim.cmd("normal! ==")
  else
    vim.cmd("normal! k")
  end
end)
