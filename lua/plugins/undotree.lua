return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = 'Toggle [U]ndo[T]ree' },
  },
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 3
  end,
}
