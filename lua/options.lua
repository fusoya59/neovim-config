vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 1000

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.confirm = true

-- Tabs: 4 spaces
vim.o.tabstop = 4 -- Number of spaces a <Tab> counts for
vim.o.shiftwidth = 4 -- Size of indent
vim.o.softtabstop = 4 -- Use 4 spaces when pressing <Tab>
vim.o.expandtab = true -- Convert tabs to spaces

-- Line endings: Unix (LF / \n)
vim.o.fileformat = 'unix'

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    vim.bo.fileformat = 'unix'
  end,
})

vim.diagnostic.config {
  virtual_text = false, -- disable inline text (optional, less clutter)
  float = {
    border = 'rounded',
    source = 'always', -- show the diagnostic source (like 'pyright' or 'lua_ls')
  },
  severity_sort = true,
}

-- Show diagnostics in a floating window on cursor hold
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
vim.o.sessionoptions = vim.o.sessionoptions .. ',localoptions'
