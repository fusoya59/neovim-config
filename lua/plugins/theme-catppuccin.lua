return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      -- transparent_background = true, -- Enable transparency
      flavour = 'mocha', -- Set the flavour (optional, since you're using mocha)
    }
    vim.cmd.colorscheme 'catppuccin-mocha' -- latte, frappe, macchiato, mocha
  end,
}
