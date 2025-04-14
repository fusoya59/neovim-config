local dap = require 'dap'
local dapui = require 'dapui'

-- Define signs and highlights
vim.fn.sign_define('DapStopped', {
  text = '▶',
  texthl = 'DiagnosticInfo',
  linehl = 'DapStoppedLine',
  numhl = 'DiagnosticInfo',
})
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#49451e', bold = true })
vim.fn.sign_define('DapBreakpoint', {
  text = '●',
  texthl = 'DiagnosticError',
  linehl = '',
  numhl = '',
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
vim.keymap.set('n', '<S-F5>', function()
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

local function load_debug_config()
  local path = vim.fn.getcwd() .. '/.dap/debug.json'
  local f = io.open(path, 'r')
  if not f then
    return {}
  end
  local content = f:read '*a'
  f:close()
  local ok, config = pcall(vim.fn.json_decode, content)
  if ok then
    return config
  else
    return {}
  end
end

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
    name = 'Python: External Config',
    program = function()
      local cfg = load_debug_config()
      return cfg.program or '${file}'
    end,
    args = function()
      local cfg = load_debug_config()
      return cfg.args or {}
    end,
    cwd = function()
      local cfg = load_debug_config()
      return cfg.cwd or vim.fn.getcwd()
    end,
    console = 'integratedTerminal',
  },
}
