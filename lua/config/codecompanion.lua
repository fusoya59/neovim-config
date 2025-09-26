local function setup_codecompanion()
  require('codecompanion').setup {
    adapters = {
      http = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://localhost:11434',
            },
            schema = {
              model = {
                default = 'qwen2.5-coder:3b',
              },
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = 'ollama',
      },
      inline = {
        adapter = 'ollama',
      },
    },
  }
  vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
  vim.keymap.set({ 'n', 'v' }, '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
  vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

  vim.cmd [[cab cc CodeCompanion]]
end

return {
  setup = setup_codecompanion,
}
