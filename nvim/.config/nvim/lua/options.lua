vim.o.termguicolors = true
vim.o.hlsearch = false

vim.o.scrolloff = 8
-- disable mouse
vim.opt.mouse = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.wo.number = true
vim.wo.relativenumber = true

-- share neovim and OS clipboard
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.signcolumn = 'yes'

vim.o.updatetime = 750
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Remove tilde symbols
vim.opt.fillchars:append({ eob = " " })
