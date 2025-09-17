return {
  {
    'laytan/cloak.nvim',
    config = function()
      require('cloak').setup {
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        patterns = {
          {
            file_pattern = { '.env*', 'wrangler.toml', '.dev.vars' },
            cloak_pattern = '=.+',
          },
        },
      }
      vim.keymap.set('n', '<leader>cp', '<cmd>CloakPreviewLine<CR>', { desc = '[C]loak [P]review line' })
      vim.keymap.set('n', '<leader>ct', '<cmd>CloakToggle<CR>', { desc = '[C]loak [T]oggle' })
    end,
  },
}
