return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      settings = {
        save_on_toggle = true, -- Save marks when toggling the menu
        save_on_change = true, -- Save marks on every change
      },
    }

    -- Keybindings
    local keymap = vim.keymap.set
    -- Add file to Harpoon list
    keymap('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add file' })
    -- Toggle Harpoon quick menu
    keymap('n', '<leader>hq', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle quick menu' })
    -- Navigate to specific files (1-5)
    for i = 1, 5 do
      keymap('n', '<leader>h' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon: Go to file ' .. i })
    end
  end,
}
