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

    local conf = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end
    local function get_current_file()
      return vim.fn.expand '%:p'
    end
    local keymap = vim.keymap.set

    keymap('n', '<leader>ha', function()
      harpoon:list():add()
      print('Harpoon: Added file ' .. get_current_file())
    end, { desc = '[H]arpoon: [A]dd file' })

    keymap('n', '<leader>hr', function()
      harpoon:list():remove()
      print('Harpoon: Removed file ' .. get_current_file())
    end, { desc = '[H]arpoon: [R]emove file' })

    -- Toggle Harpoon quick menu
    keymap('n', '<leader>hh', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon: Toggle quick menu' })

    -- Navigate to specific files (1-5)
    for i = 1, 5 do
      keymap('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon: Go to file ' .. i })
    end
  end,
}
