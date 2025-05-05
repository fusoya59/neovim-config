local dap = require 'dap'
local dapui = require 'dapui'

-- VSCode-like highlights for DAP
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#ff0000' })
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#ff8800' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#5c5cff' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#00ff00' })

-- VSCode's debug highlight has a light yellow background
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2d2e2f', fg = '#ffffff', bold = true })

-- Define signs with VSCode-like appearance
vim.fn.sign_define('DapBreakpoint', {
  text = '●',
  texthl = 'DapBreakpoint',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define('DapBreakpointCondition', {
  text = '◆',
  texthl = 'DapBreakpointCondition',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define('DapLogPoint', {
  text = '◆',
  texthl = 'DapLogPoint',
  linehl = '',
  numhl = '',
})

vim.fn.sign_define('DapStopped', {
  text = '▶',
  texthl = 'DapStopped',
  linehl = 'DapStoppedLine',
  numhl = 'DapStopped',
})

-- Setup DAP UI auto-open/close events (define once)
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Keybindings (define once)
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Continue' })
vim.keymap.set('n', '<F6>', function()
  require('dap').terminate()
end, { desc = 'Debug: Stop' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Conditional Breakpoint' })
vim.keymap.set('n', '<leader>V', function()
  dapui.eval()
end, { desc = 'Debug: Show Variable Value' })

-- Node.js DAP configurations
dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch Node.js file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
}
dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch TypeScript file',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
}

-- Python DAP adapter and configuration
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch current file',
    program = '${file}',
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch with debug.json',
    program = function()
      local file = io.open('.dap/debug.json', 'r')
      if not file then
        vim.notify('Debug config file not found: .dap/debug.json', vim.log.levels.ERROR)
        return '${file}'
      end

      local content = file:read '*all'
      file:close()

      local status, config = pcall(vim.fn.json_decode, content)
      if not status then
        vim.notify('Failed to parse debug config: ' .. config, vim.log.levels.ERROR)
        return '${file}'
      end

      -- Apply all settings from the JSON file
      for k, v in pairs(config) do
        if k ~= 'type' and k ~= 'request' and k ~= 'name' then
          dap.configurations.python[2][k] = v
        end
      end

      return config.program or '${file}'
    end,
  },
}
