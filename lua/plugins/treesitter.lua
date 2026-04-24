local parsers = {
  'lua',
  'python',
  'javascript',
  'typescript',
  'vimdoc',
  'vim',
  'rust',
  'regex',
  'terraform',
  'sql',
  'dockerfile',
  'toml',
  'json',
  'java',
  'groovy',
  'go',
  'gitignore',
  'graphql',
  'yaml',
  'make',
  'cmake',
  'markdown',
  'markdown_inline',
  'bash',
  'tsx',
  'css',
  'html',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local nvim_treesitter = require 'nvim-treesitter'

    nvim_treesitter.setup {}
    nvim_treesitter.install(parsers)

    local ts_augroup = vim.api.nvim_create_augroup('mark-treesitter', { clear = true })
    local skip_filetypes = {
      DiffviewFiles = true,
      DiffviewFileHistory = true,
      gitcommit = true,
    }

    vim.api.nvim_create_autocmd('FileType', {
      group = ts_augroup,
      callback = function(args)
        local bufnr = args.buf
        local filetype = vim.bo[bufnr].filetype
        local buftype = vim.bo[bufnr].buftype

        if buftype ~= '' or skip_filetypes[filetype] then
          return
        end

        local ok = pcall(vim.treesitter.start, bufnr)
        if not ok then
          return
        end

        if filetype ~= 'ruby' then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
