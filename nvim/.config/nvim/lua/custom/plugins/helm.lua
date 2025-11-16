return {
  'towolf/vim-helm',
  ft = 'helm',
  config = function()
    -- Auto-detect helm template files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*/templates/_*.yaml", "*/templates/_*.tpl" },
      callback = function()
        vim.bo.filetype = "helm"
      end,
    })
  end,
}
