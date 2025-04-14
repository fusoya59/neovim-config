return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup {
      editor = {
        mappings = {
          { key = '<leader>qx', mode = 'n', action = 'run_file', opts = { desc = 'Run file', noremap = true, silent = true } },
          { key = '<leader>qx', mode = 'v', action = 'run_selection', opts = { desc = 'Execute selection', noremap = true, silent = true } },
        },
      },
    }
    vim.keymap.set('n', '<leader>db', "<cmd>lua require('dbee').toggle()<cr>", { desc = 'Toggle dbee', noremap = true, silent = true })
  end,
}
