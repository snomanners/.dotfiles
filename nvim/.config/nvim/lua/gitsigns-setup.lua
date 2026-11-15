require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map('n', '<leader>gb', gs.blame_line, 'Blame line')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
        map('x', '<leader>gs', function()
            gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage selected lines')
        map('x', '<leader>gr', function()
            gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset selected lines')

        for key, direction in pairs({ ['[c'] = 'prev', [']c'] = 'next' }) do
            map('n', key, function()
                if vim.wo.diff then
                    vim.cmd.normal({ key, bang = true })
                else
                    gs.nav_hunk(direction)
                end
            end, direction == 'prev' and 'Previous change' or 'Next change')
        end
    end,
})
