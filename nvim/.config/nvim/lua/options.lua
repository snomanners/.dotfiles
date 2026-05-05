vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.hlsearch = false

vim.o.scrolloff = 8
-- disable mouse
vim.opt.mouse = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 0

vim.opt.smartindent = true

vim.wo.number = true
vim.wo.relativenumber = true

-- sync clipboard between OS and Neovim
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.undofile = true

vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- We want files to open with no folds closed
vim.o.foldlevelstart = 99

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.confirm = true

vim.diagnostic.config({
  virtual_text = {
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
})
