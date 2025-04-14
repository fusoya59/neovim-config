return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && npm install',
  ft = { 'markdown' },
  cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle', 'MarkdownPreviewStop' },
  init = function()
    vim.g.mkdp_auto_start = 0 -- Set to 1 to auto-start preview on open
    vim.g.mkdp_auto_close = 1 -- Close preview when switching buffer
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_command_for_global = 0
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_open_ip = ''
    vim.g.mkdp_browser = '' -- Set to 'firefox', 'chrome', etc., or leave blank for default
    vim.g.mkdp_echo_preview_url = 1 -- Show URL in command line
    vim.g.mkdp_browserfunc = ''
    vim.g.mkdp_markdown_css = '' -- Custom CSS path if needed
    vim.g.mkdp_highlight_css = ''
    vim.g.mkdp_port = ''
    vim.g.mkdp_page_title = '${name}'
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
}
