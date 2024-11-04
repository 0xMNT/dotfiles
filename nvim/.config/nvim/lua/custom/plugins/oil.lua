return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-h>'] = false, -- disable Ctrl-h keybinding
        ['<C-l>'] = false, -- disable Ctrl-l keybinding
        ['<C-j>'] = false, -- disable Ctrl-l keybinding
      },
    }
  end,

  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
}
