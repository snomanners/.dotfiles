-- Treesitter setup from kickstart, see if everything needed is here
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'lua', 'python', 'rust', 'javascript', 'typescript', 'vimdoc', 'vim'},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    
    -- TODO: check if we want to enable more options for treesitter or not
    -- like what is the textobjects stuff?
  }
end, 0)

-- vim: ts=2 sts=2 sw=2 et
