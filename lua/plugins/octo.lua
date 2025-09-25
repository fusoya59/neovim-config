return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup()
  end,
  keys = {
    { '<leader>ghp', '<cmd>Octo pr list<CR>', desc = 'Github PRs (Octo)' },
  },
}
