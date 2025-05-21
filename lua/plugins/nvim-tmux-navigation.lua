return {
  'alexghergh/nvim-tmux-navigation',
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'
    nvim_tmux_nav.setup {
      disable_when_zoomed = true, -- Prevent navigation when tmux pane is zoomed
      keybindings = {
        left = '<C-Left>',
        down = '<C-Down>',
        up = '<C-Up>',
        right = '<C-Right>',
        last_active = '<C-\\>',
        next = '<C-Space>',
      },
    }
  end,
}
