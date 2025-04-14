require 'options'
require 'keymaps'
require 'config.lazy'

-- Load DAP config for Python and JavaScript/TypeScript files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'javascript', 'typescript' },
  callback = function()
    require 'config.dap'
  end,
})
