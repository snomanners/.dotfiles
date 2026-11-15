-- Here we define all the plugins we will need
local function fzf(cmd, opts)
    return function() require('fzf-lua')[cmd](opts) end
end

require("lazy").setup({
    -- ### Git ###
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            {
                "esmuellert/codediff.nvim",
                cmd = "CodeDiff",
                keys = {
                    { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Review diff" },
                },
            },
            "m00qek/baleia.nvim",
            "ibhagwan/fzf-lua",
        },
        cmd = "Neogit",
        opts = {
            graph_style = "unicode",
            integrations = { fzf_lua = true, codediff = true },
        },
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function() require('gitsigns-setup') end,
    },

    -- ### Colorschemes ###
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
    },
    { "wnkz/monoglow.nvim", lazy = true, opts = {} },
    { "Aejkatappaja/cendre", lazy = true },

    -- ### UI / utilities ###
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = require('dashboard-setup').opts,
            indent = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            { "]]", function() Snacks.words.jump(vim.v.count1) end, mode = { "n", "t" }, desc = "Next reference" },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, mode = { "n", "t" }, desc = "Previous reference" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer (keep window)" },
            { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file (updates imports)" },
            { "<leader>go", function() Snacks.gitbrowse() end, mode = { "n", "x" }, desc = "Open in browser" },
            { "<c-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
            { "<c-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "which_key_ignore" },
        },
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
                ["gR"] = "actions.refresh",
            },
        },
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        event = "VeryLazy",
        init = function()
            -- Let the LSP update imports when files are moved/renamed in oil
            vim.api.nvim_create_autocmd("User", {
                pattern = "OilActionsPost",
                callback = function(event)
                    for _, action in ipairs(event.data.actions or {}) do
                        if action.type == "move" then
                            Snacks.rename.on_rename_file(action.src_url, action.dest_url)
                        end
                    end
                end,
            })
        end,
        keys = {
            { "<leader>o", function() require('oil').toggle_float() end, desc = "Oil file manager" },
            { "-", function() require('oil').open() end, desc = "Open parent directory" },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('lualine-setup') end,
    },
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        opts = {
            spec = {
                { "<leader>b", group = "buffers" },
                { "<leader>c", group = "code" },
                { "<leader>d", group = "diagnostics" },
                { "<leader>f", group = "files and help" },
                { "<leader>g", group = "git" },
                { "<leader>h", group = "harpoon" },
                { "<leader>q", group = "session" },
                { "<leader>s", group = "search" },
                { "<leader>w", group = "windows" },
                { "<leader>x", group = "lists" },
            },
        },
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore session (cwd)" },
            { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save this session" },
        },
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {},
        keys = {
            { "<leader>xq", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
            { "<leader>xl", function() require("quicker").toggle({ loclist = true }) end, desc = "Toggle loclist" },
        },
    },

    -- ### Navigation / search ###
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        cmd = "FzfLua",
        keys = {
            { "<leader>ff", fzf('files'), desc = "Find files" },
            { "<leader>fl", function() require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Files beside current file" },
            { "<leader>fg", fzf('git_files'), desc = "Git files" },
            { "<leader>fr", fzf('oldfiles'), desc = "Recent files" },
            { "<leader><space>", fzf('buffers'), desc = "Buffers" },
            { "<leader>bb", fzf('buffers'), desc = "Buffers" },
            { "<leader>sg", fzf('live_grep'), desc = "Grep project" },
            { "<leader>sw", fzf('grep_cword'), desc = "Search word" },
            { "<leader>sw", fzf('grep_visual'), mode = "x", desc = "Search selection" },
            { "<leader>sb", fzf('blines'), desc = "Search buffer" },
            { "<leader>sr", fzf('resume'), desc = "Resume picker" },
            { "<leader>fh", fzf('helptags'), desc = "Help tags" },
            { "<leader>fk", fzf('keymaps'), desc = "Keymaps" },
            { "<leader>dd", fzf('diagnostics_document'), desc = "Buffer diagnostics" },
            { "<leader>dD", fzf('diagnostics_workspace'), desc = "Workspace diagnostics" },
            -- git pickers
            { "<leader>gf", fzf('git_status'), desc = "Changed files" },
            { "<leader>gl", fzf('git_bcommits'), desc = "File history" },
            { "<leader>gL", fzf('git_commits'), desc = "Repo log" },
            { "<leader>gk", fzf('git_branches'), desc = "Branches" },
            { "<leader>gz", fzf('git_stash'), desc = "Stashes" },
        },
    },
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = "VeryLazy",
        config = function()
            require('harpoon'):setup()
        end,
        keys = function()
            local keys = {
                { "<leader>hp", function() require('harpoon'):list():add() end, desc = "Add file to Harpoon" },
                { "<leader>hh", function()
                    local harpoon = require('harpoon')
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end, desc = "Harpoon menu" },
                { "<leader>hr", function() require('harpoon'):list():remove() end, desc = "Remove file from Harpoon" },
                { "[h", function() require('harpoon'):list():prev() end, desc = "Previous Harpoon file" },
                { "]h", function() require('harpoon'):list():next() end, desc = "Next Harpoon file" },
            }
            for i, key in ipairs({ 'a', 's', 'd', 'f', 'g' }) do
                local slot = i
                keys[#keys + 1] = {
                    "<leader>h" .. key,
                    function() require('harpoon'):list():select(slot) end,
                    desc = "Harpoon file " .. slot,
                }
            end
            return keys
        end,
    },

    -- ### Code ###
    "neovim/nvim-lspconfig",
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
        keys = {
            { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Search TODO comments" },
        },
    },
    {
        'stevearc/conform.nvim',
        event = "BufWritePre",
        cmd = "ConformInfo",
        ---@module 'conform'
        ---@type conform.setupOpts
        opts = {
            -- Formatters that aren't installed are skipped; LSP formatting is the fallback.
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_organize_imports", "ruff_format" },
                go = { "goimports", "gofmt" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
                svelte = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
        },
        keys = {
            {
                "<leader>=",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "x" },
                desc = "Format buffer or selection",
            },
            {
                "<leader>cF",
                function()
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                    vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
                end,
                desc = "Toggle format on save",
            },
        },
    },
    'tpope/vim-sleuth',
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        lazy = false,
        priority = 1000,
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        lazy = false,
        build = ':TSUpdate',
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = "main",
        event = "VeryLazy",
        config = function() require('textobjects-setup') end,
    },
    {
        'nvim-mini/mini.surround',
        version = false,
        opts = {
            mappings = {
                add = 'ys',
                delete = 'ds',
                replace = 'cs',
                find = '',
                find_left = '',
                highlight = '',
                suffix_last = '',
                suffix_next = '',
            },
        },
    },
    { 'nvim-mini/mini.pairs', version = false, event = "InsertEnter", opts = {} },
}, {})
