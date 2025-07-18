return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
          },
        }
      end,
    },
  },
  event = 'BufReadPost', -- Lazy-load on buffer read
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      if filetype == 'neo-tree' or buftype == 'nofile' then
        return ''
      end
      return { 'lsp', 'indent' } -- Use LSP with indent as fallback
    end,
  },
  config = function(_, opts)
    -- Basic fold settings
    vim.o.foldcolumn = '1' -- Show fold column
    vim.o.foldlevel = 99 -- Start with all folds open
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    -- Keymappings for folding
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    require('ufo').setup(opts)
  end,
}
