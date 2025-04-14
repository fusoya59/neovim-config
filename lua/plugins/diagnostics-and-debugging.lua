return {
  -- Debugging: DAP core and UI
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
  },

  -- Python debugging
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    config = function()
      require('dap-python').setup 'python' -- Assumes debugpy is installed
    end,
  },

  -- Node.js debugging
  {
    'mxsdev/nvim-dap-vscode-js',
    ft = { 'javascript', 'typescript' },
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome' },
      }
    end,
  },

  -- DAP UI
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end,
  },
}
