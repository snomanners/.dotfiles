-- snacks.nvim dashboard: an icy header and the shortcuts I actually use.
local M = {}

-- Nerd Font icon by codepoint (keeps the glyphs from getting mangled in the file).
local function nf(code)
    return vim.fn.nr2char(code) .. " "
end

local function fzf(cmd, opts)
    return function() require('fzf-lua')[cmd](opts) end
end

local header = {
    [[███████╗███╗   ██╗ ██████╗ ]],
    [[██╔════╝████╗  ██║██╔═══██╗]],
    [[███████╗██╔██╗ ██║██║   ██║]],
    [[╚════██║██║╚██╗██║██║   ██║]],
    [[███████║██║ ╚████║╚██████╔╝]],
    [[╚══════╝╚═╝  ╚═══╝ ╚═════╝ ]],
    [[███╗   ███╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██████╗ ███████╗]],
    [[████╗ ████║██╔══██╗████╗  ██║████╗  ██║██╔════╝██╔══██╗██╔════╝]],
    [[██╔████╔██║███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝███████╗]],
    [[██║╚██╔╝██║██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗╚════██║]],
    [[██║ ╚═╝ ██║██║  ██║██║ ╚████║██║ ╚████║███████╗██║  ██║███████║]],
    [[╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚══════╝]],
}

-- Fresh snow at the top, fading down into deep glacier blue.
local gradient = {
    "#f4fbff", "#e2f4fd", "#cdeafb", "#b6e0f8", "#9fd4f5", "#88c8f1",
    "#73bbec", "#60aee6", "#509fdf", "#4390d6", "#3982cc", "#3175c1",
}

local function set_highlights()
    for i, color in ipairs(gradient) do
        vim.api.nvim_set_hl(0, "IceHeader" .. i, { fg = color, bold = true })
    end
    vim.api.nvim_set_hl(0, "IceSnow", { fg = "#cdeafb" })
    vim.api.nvim_set_hl(0, "IceSnowDim", { fg = "#6b8fa8" })
    vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#88c8f1" })
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#f4fbff", bold = true })
    vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#b6e0f8" })
    vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = "#6b8fa8", italic = true })
end

set_highlights()
-- Re-apply after a colorscheme switch, since that clears custom highlights.
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

local function line(text, hl)
    return { text = { { text, hl = hl } }, align = "center" }
end

local function header_section()
    local items = { line("❄       ·       ❅       ·       ❆       ·       ❄", "IceSnowDim"), line("", nil) }
    for i, text in ipairs(header) do
        items[#items + 1] = line(text, "IceHeader" .. i)
        if i == 6 then items[#items + 1] = line("", nil) end
    end
    items[#items + 1] = line("", nil)
    items[#items + 1] = line("·  ❅  ·   In the darkest times, hope is something you give yourself. That is the meaning of inner strength.   ·  ❅  ·", "IceSnow")
    items[#items + 1] = line("", nil)
    return items
end

M.opts = {
    enabled = true,
    width = 64,
    preset = {
        pick = function(cmd, opts)
            return require('fzf-lua')[cmd](opts)
        end,
        keys = {
            { icon = nf(0xf002), key = "f", desc = "Find file", action = fzf('files') },
            { icon = nf(0xf15b), key = "n", desc = "New file", action = ":ene | startinsert" },
            { icon = nf(0xf0b0), key = "s", desc = "Grep project", action = fzf('live_grep') },
            { icon = nf(0xf1da), key = "r", desc = "Recent files", action = fzf('oldfiles') },
            { icon = nf(0xf013), key = "c", desc = "Config", action = fzf('files', { cwd = vim.fn.stdpath('config') }) },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = nf(0xf2f5), key = "q", desc = "Quit", action = ":qa" },
        },
    },
    sections = {
        header_section,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", icon = "❄ " },
    },
}

return M
