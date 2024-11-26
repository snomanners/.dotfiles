vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'options'

require 'keymaps'

require 'telescope-setup'

require 'treesitter-setup'

require 'lsp'

require 'cmp-setup'

require 'lualine-setup'

vim.cmd("colorscheme oxocarbon")
