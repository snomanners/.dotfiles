vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        opt = {
            buffer = event.buf
        }

        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opt)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opt)

        vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions, opt)
        vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, opt)
        vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations, opt)
        vim.keymap.set('n', '<leader>D', require('fzf-lua').lsp_typedefs, opt)
        vim.keymap.set('n', '<leader>ds', require('fzf-lua').lsp_document_symbols, opt)
        vim.keymap.set('n', '<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, opt)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opt)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opt)

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end
})

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

capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
}

vim.lsp.config("*", {
    capabilities = capabilities,
})

-- reccomdede lua config in docs
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
                checkThirdParty = false,
                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
vim.lsp.enable 'lua_ls'
