vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<leader>x', ':close<CR>')
vim.keymap.set('n', '<leader>ss', ':vsplit<CR>')
vim.keymap.set('n', '<leader>sh', ':split<CR>')

local fzflua = require('fzf-lua')

vim.keymap.set('n', '<leader>f', fzflua.files)
vim.keymap.set('n', '<leader>l', function()require'fzf-lua'.files({ cwd=vim.fn.expand('%:p:h') })end)
vim.keymap.set('n', '<leader>s', fzflua.live_grep)
vim.keymap.set('n', '<leader>pg', fzflua.git_files)
vim.keymap.set('n', '<leader><space>', fzflua.buffers)
vim.keymap.set('n', '<leader>vh', fzflua.helptags)
vim.keymap.set('n', '<leader>t', ':TodoFzfLua<CR>')
vim.keymap.set('n', '<leader>ds', fzflua.lsp_document_symbols)
vim.keymap.set('n', '<leader>ws', fzflua.lsp_workspace_symbols)

vim.keymap.set("n", "<leader>e", fzflua.lsp_document_diagnostics)
vim.keymap.set("n", "<leader>E", fzflua.lsp_workspace_diagnostics)
-- Harpoon keymaps

vim.keymap.set('n', '<leader>hp', function() require("harpoon"):list():add() end)
vim.keymap.set('n', '<leader>hl', function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<leader>ha', function() require("harpoon"):list():select(1) end)
vim.keymap.set('n', '<leader>hs', function() require("harpoon"):list():select(2) end)
vim.keymap.set('n', '<leader>hd', function() require("harpoon"):list():select(3) end)
vim.keymap.set('n', '<leader>hf', function() require("harpoon"):list():select(4) end)
vim.keymap.set('n', '<leader>hg', function() require("harpoon"):list():select(5) end)

-- Oil keymaps

vim.keymap.set('n', '<leader>o', require('oil').toggle_float)
