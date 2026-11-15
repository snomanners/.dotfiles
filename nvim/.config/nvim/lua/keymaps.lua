vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.hl.on_yank()
    end,
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
})

vim.keymap.set('n', 'H', '^', { desc = 'First nonblank character' })
vim.keymap.set('n', 'L', '$', { desc = 'End of line' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wo', '<cmd>only<CR>', { desc = 'Keep only this window' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize windows' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Diagnostic details' })
