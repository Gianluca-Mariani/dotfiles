return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      on_highlights = function(hl, c)
        -- Custom high-contrast selection highlight
        hl.Visual = {
          bg = "#3b4261", -- High contrast slate background
          fg = "#ffffff", -- Bright white text selection
          bold = true,
        }
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
