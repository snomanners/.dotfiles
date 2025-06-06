vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files)
vim.keymap.set('n', '<leader>ps', builtin.live_grep)
vim.keymap.set('n', '<leader>pg', builtin.git_files)
vim.keymap.set('n', '<leader><space>', builtin.buffers)
vim.keymap.set('n', '<leader>vh', builtin.help_tags)
vim.keymap.set('n', '<leader>t', ':TodoTelescope<CR>')
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>ws', builtin.lsp_workspace_symbols)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>e", builtin.diagnostics)
-- Harpoon keymaps

vim.keymap.set('n', '<leader>hp', function() require("harpoon"):list():add() end)
vim.keymap.set('n', '<leader>hl', function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<leader>ha', function() require("harpoon"):list():select(1) end)
vim.keymap.set('n', '<leader>hs', function() require("harpoon"):list():select(2) end)
vim.keymap.set('n', '<leader>hd', function() require("harpoon"):list():select(3) end)
vim.keymap.set('n', '<leader>hf', function() require("harpoon"):list():select(4) end)
vim.keymap.set('n', '<leader>hg', function() require("harpoon"):list():select(5) end)

-- Oil keymaps

vim.keymap.set('n', '<leader>o', ':Oil --float<CR>')
