vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local fzflua = require('fzf-lua')

vim.keymap.set('n', '<leader>pf', fzflua.files)
vim.keymap.set('n', '<leader>ps', fzflua.live_grep)
vim.keymap.set('n', '<leader>pg', fzflua.git_files)
vim.keymap.set('n', '<leader><space>', fzflua.buffers)
vim.keymap.set('n', '<leader>vh', fzflua.helptags)
vim.keymap.set('n', '<leader>t', ':TodoFzfLua<CR>')
vim.keymap.set('n', '<leader>ds', fzflua.lsp_document_symbols)
vim.keymap.set('n', '<leader>ws', fzflua.lsp_workspace_symbols)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

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
