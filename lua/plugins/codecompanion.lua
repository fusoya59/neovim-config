return {
  'olimorris/codecompanion.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('config.codecompanion').setup()
  end,
}
