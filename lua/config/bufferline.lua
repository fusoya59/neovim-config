local function setup_bufferline()
  require('bufferline').setup {
    options = {
      mode = 'buffers', -- or "tabs"
      diagnostics = 'nvim_lsp', -- show LSP diagnostics on tabs
      show_close_icon = false,
      show_buffer_close_icons = true,
      separator_style = 'slant', -- "slant" | "thick" | "thin" | { 'left', 'right' }
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File Explorer',
          text_align = 'center',
          separator = true,
        },
      },
    },
  }
  -- Keymaps
  vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { silent = true })
  vim.keymap.set('n', '<C-PageDown>', '<cmd>BufferLineCycleNext<CR>', { silent = true })
  vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { silent = true })
  vim.keymap.set('n', '<C-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { silent = true })
  vim.keymap.set('n', '<leader>tn', '<cmd>enew<CR>', { silent = true, desc = 'New tab' })
  vim.keymap.set('n', '<leader>x', '<cmd>bdelete | bprevious<CR>', { noremap = true, silent = true, desc = '[x] Close buffer' })
  vim.keymap.set('n', '<leader>X', '<cmd>BufferLineCloseOthers<CR>', { noremap = true, silent = true, desc = '[X] Close others' })
end

return {
  setup = setup_bufferline,
}
