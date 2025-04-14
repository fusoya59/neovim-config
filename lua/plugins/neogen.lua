return {
  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  cmd = 'Neogen',
  keys = {
    {
      "<leader>d'",
      function()
        require('neogen').generate()
      end,
      desc = 'Generate docstring',
    },
  },
  config = function()
    require('neogen').setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'google_docstrings', -- or "numpy", "reST"
          },
        },
      },
    }
  end,
}
