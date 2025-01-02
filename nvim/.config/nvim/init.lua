vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'lazy-bootstrap'

require 'lazy-plugins'

require 'options'

require 'keymaps'

require 'telescope-setup'

require 'treesitter-setup'

require 'blink-setup'

require 'lsp'

require 'lualine-setup'

vim.cmd("colorscheme no-clown-fiesta")
