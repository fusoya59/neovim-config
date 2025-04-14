return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Open terminal with Control + \
      open_mapping = [[<C-\>]],
      -- Show as floating window, but you can use 'horizontal' or 'vertical' too
      direction = 'horizontal',
      float_opts = {
        border = 'curved', -- nice rounded border
        winblend = 0, -- transparency (0 is opaque)
      },
      start_in_insert = true, -- so you're ready to type in terminal
      insert_mappings = true, -- use <C-\> to close/toggle even in insert mode
    }
  end,
}
