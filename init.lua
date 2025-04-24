require 'options'
require 'keymaps'
require 'config.lazy'

vim.opt.clipboard = 'unnamedplus'

-- Set PYTHONPATH to include the current working directory
vim.env.PYTHONPATH = vim.fn.getcwd() .. (vim.env.PYTHONPATH and (':' .. vim.env.PYTHONPATH) or '')

-- Load DAP config for Python and JavaScript/TypeScript files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'javascript', 'typescript' },
  callback = function()
    require 'config.dap'
  end,
})
