vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "css", "javascript", "typescript", "svelte"},
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
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

require 'lualine-setup'

require 'lackluster-setup'

vim.cmd("colorscheme oldworld")
