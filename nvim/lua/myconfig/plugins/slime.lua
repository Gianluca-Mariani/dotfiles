return {
  "jpalardy/vim-slime",
  init = function()
    -- Set global variables BEFORE the plugin loads
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {
      socket_name = "default",
      target_pane = "{right-of}",
    }
    vim.g.slime_dont_ask_default = 1
  end,
}
