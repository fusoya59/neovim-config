return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'ruff', -- Python linter and formatter
        'terraform',
      },
      automatic_installation = true,
    }

    local sources = {
      -- diagnostics.mypy.with {
      --   extra_args = { '--python-executable', vim.fn.exepath 'python3' },
      --   runtime_condition = function()
      --     -- Get the active virtual environment path
      --     local venv = os.getenv 'VIRTUAL_ENV'
      --     if venv then
      --       return true
      --     else
      --       -- Fall back to project-local venv detection
      --       local cwd = vim.fn.getcwd()
      --       local venv_path = cwd .. '/.venv' -- Adjust to your typical venv name
      --       if vim.fn.isdirectory(venv_path) == 1 then
      --         -- Set the PYTHONPATH to include the venv site-packages
      --         local site_packages = venv_path .. '/lib/python3.10/site-packages' -- Adjust Python version
      --         vim.env.PYTHONPATH = site_packages
      --         return true
      --       end
      --     end
      --     return false
      --   end,
      -- },

      formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
