vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
        end
        local function picker(name)
            return function() require('fzf-lua')[name]() end
        end

        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename symbol')
        map({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('n', 'gd', picker('lsp_definitions'), 'Definitions')
        map('n', 'grr', picker('lsp_references'), 'References')
        map('n', 'gri', picker('lsp_implementations'), 'Implementations')
        map('n', 'grt', picker('lsp_typedefs'), 'Type definitions')
        map('n', '<leader>cs', picker('lsp_document_symbols'), 'Document symbols')
        map('n', '<leader>cS', picker('lsp_live_workspace_symbols'), 'Workspace symbols')
        map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
        map('n', '<leader>ck', vim.lsp.buf.signature_help, 'Signature help')

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

capabilities = require('blink.cmp').get_lsp_capabilities()
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

vim.lsp.config('kotlin_lsp', {
    cmd = {'kotlin-lsp', '--stdio'}
})

vim.lsp.enable 'lua_ls'
vim.lsp.enable 'ols'
vim.lsp.enable 'ty'
vim.lsp.enable 'ruff'
vim.lsp.enable 'ts_ls'
vim.lsp.enable 'angularls'
vim.lsp.enable 'gopls'
vim.lsp.enable 'kotlin_lsp'
