local function setup_whichkey()
  local which_key = require 'which-key'

  which_key.setup {}

  -- Register Markdown-specific bindings on FileType event
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      which_key.add {
        { '<leader>m', buffer = 0, group = '[M]arkdown' },
        { '<leader>mp', '<cmd>MarkdownPreview<cr>', buffer = 0, desc = 'Preview Markdown' },
        { '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', buffer = 0, desc = 'Stop Preview' },
        { '<leader>mt', '<cmd>MarkdownPreviewToggle<cr>', buffer = 0, desc = 'Toggle Preview' },
      }
    end,
  })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
      require('which-key').add {
        { '<leader>tf', '<cmd>Neotest run file<cr>', desc = 'Run test file', buffer = 0 },
        { '<leader>tr', '<cmd>Neotest run<cr>', desc = 'Run Nearest Test', buffer = 0 },
        { '<leader>ts', '<cmd>Neotest summary toggle<cr>', desc = 'Toggle Summary Panel', buffer = 0 },
        { '<leader>to', '<cmd>Neotest output-panel toggle<cr>', desc = 'Toggle Output Panel', buffer = 0 },
        {
          '<leader>td',
          function()
            require('neotest').run.run { strategy = 'dap' }
          end,
          desc = 'Debug Nearest Test',
          buffer = 0,
        },
      }
    end,
  })
end

return {
  setup = setup_whichkey,
}
