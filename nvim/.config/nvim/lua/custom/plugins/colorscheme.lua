return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    local bg = '#0D101B'

    require('tokyonight').setup {
      style = 'night',
      on_colors = function(colors)
        colors.bg = bg
      end,
    }

    vim.cmd 'colorscheme tokyonight'
  end,
}
