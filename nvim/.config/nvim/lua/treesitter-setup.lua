-- Treesitter setup from kickstart, see if everything needed is here
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'lua', 'python', 'rust', 'javascript', 'typescript', 'vimdoc', 'vim', 'markdown'},

    auto_install = true,
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    
  }
end, 0)

-- vim: ts=2 sts=2 sw=2 et
