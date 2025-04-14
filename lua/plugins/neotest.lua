return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            runner = 'pytest',
            args = { '-vv', '--maxfail=5', '--tb=short' },
            python = function()
              return os.getenv 'VIRTUAL_ENV' and os.getenv 'VIRTUAL_ENV' .. '/bin/python' or 'python'
            end,
            dap = { justMyCode = false },
          },
        },
        output = {
          open_on_run = true,
        },
      }
    end,
  },
}
