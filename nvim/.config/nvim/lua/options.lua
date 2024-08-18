vim.o.termguicolors = true
vim.o.hlsearch = false

-- Nicer scrolling experience
vim.o.scrolloff = 8
-- disable mouse
vim.opt.mouse = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Share neovim and OS clipboard
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Signcolumn to show info on lines, don't know exactly if needed. Check out later
vim.wo.signcolumn = 'yes'

-- Decrease update time, check if this is alright later
vim.o.updatetime = 750
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Netrw options
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28

-- Remove tilde symbols
vim.opt.fillchars:append({ eob = " " })

-- highlight on yank taken from kickstart
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
