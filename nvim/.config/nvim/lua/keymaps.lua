vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>z', ":ZenMode<CR>", {})

vim.keymap.set("n", "<leader>q", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>e", function() require("trouble").toggle() end)

vim.api.nvim_set_keymap(
    "n",
    "<C-n>",
    ":Telescope file_browser<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap("n", "<Leader>af", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
