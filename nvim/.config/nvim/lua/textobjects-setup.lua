-- Treesitter text objects: daf / cif / vac / yia ... and ]f [f motions.
require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

local objects = {
    f = { '@function', 'function' },
    c = { '@class', 'class' },
    a = { '@parameter', 'argument' },
    o = { '@loop', 'loop' },
    i = { '@conditional', 'conditional' },
}

for key, obj in pairs(objects) do
    local query, name = obj[1], obj[2]
    vim.keymap.set({ 'x', 'o' }, 'a' .. key, function()
        select.select_textobject(query .. '.outer', 'textobjects')
    end, { desc = 'Around ' .. name })
    vim.keymap.set({ 'x', 'o' }, 'i' .. key, function()
        select.select_textobject(query .. '.inner', 'textobjects')
    end, { desc = 'Inside ' .. name })
end

-- ]c / [c stay with gitsigns hunks, so classes use ]k / [k
local moves = {
    f = { '@function.outer', 'function' },
    k = { '@class.outer', 'class' },
    a = { '@parameter.inner', 'argument' },
}

for key, obj in pairs(moves) do
    local query, name = obj[1], obj[2]
    vim.keymap.set({ 'n', 'x', 'o' }, ']' .. key, function()
        move.goto_next_start(query, 'textobjects')
    end, { desc = 'Next ' .. name .. ' start' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[' .. key, function()
        move.goto_previous_start(query, 'textobjects')
    end, { desc = 'Previous ' .. name .. ' start' })
    vim.keymap.set({ 'n', 'x', 'o' }, ']' .. key:upper(), function()
        move.goto_next_end(query, 'textobjects')
    end, { desc = 'Next ' .. name .. ' end' })
    vim.keymap.set({ 'n', 'x', 'o' }, '[' .. key:upper(), function()
        move.goto_previous_end(query, 'textobjects')
    end, { desc = 'Previous ' .. name .. ' end' })
end
