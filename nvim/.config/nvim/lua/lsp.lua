local on_attach = function(_, bufnr)
    opt = {
        buffer = bufnr
    }

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opt)
    vim.keymap.set('n','<leader>ca', function()
        vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
    end, opt)

    vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions, opt)
    vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, opt)
    vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations, opt)
    vim.keymap.set('n', '<leader>D', require('fzf-lua').lsp_typedefs, opt)
    vim.keymap.set('n', '<leader>ds', require('fzf-lua').lsp_document_symbols, opt)
    vim.keymap.set('n', '<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, opt)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opt)
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()
local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()


capabilities = require('blink.cmp').get_lsp_capabilities()
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

-- replacement for mason_lspconfig.setuphandlers
vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = handlers,
})
