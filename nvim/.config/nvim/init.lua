vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "css", "javascript", "typescript", "svelte"},
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'options'

require 'keymaps'

require 'treesitter-setup'

require 'blink-setup'

require 'lsp'

require('vim._core.ui2').enable({})

vim.cmd("colorscheme oldworld")
