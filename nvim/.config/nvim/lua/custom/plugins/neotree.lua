return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_hidden = true,
          hide_gitignored = true,
        },
      },
      window = {
        width = 35,
      },
    }
  end,
  vim.keymap.set('n', '<Leader>n', '<Cmd>Neotree toggle<CR>'),
}
