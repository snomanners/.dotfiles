-- Here we define all the plugins we will need
require("lazy").setup({
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
    "m00qek/baleia.nvim",            -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
},
    {
        "dgox16/oldworld.nvim",
        lazy = false,
        priority = 1000,
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = {
          enabled = true,
          preset = {
            pick = function(cmd, opts)
              return require('fzf-lua')[cmd](opts)
            end,
          },
        },
        indent = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
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
        keys = {
            { "<leader>o", function() require('oil').toggle_float() end, desc = "Oil file manager" },
            { "-", function() require('oil').open() end, desc = "Open parent directory" },
        },
    },
    "neovim/nvim-lspconfig",
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
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
            { "<leader>ff", function() require('fzf-lua').files() end, desc = "Find files" },
            { "<leader>fl", function() require('fzf-lua').files({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Files beside current file" },
            { "<leader>fg", function() require('fzf-lua').git_files() end, desc = "Git files" },
            { "<leader>fr", function() require('fzf-lua').oldfiles() end, desc = "Recent files" },
            { "<leader><space>", function() require('fzf-lua').buffers() end, desc = "Buffers" },
            { "<leader>bb", function() require('fzf-lua').buffers() end, desc = "Buffers" },
            { "<leader>sg", function() require('fzf-lua').live_grep() end, desc = "Grep project" },
            { "<leader>sw", function() require('fzf-lua').grep_cword() end, desc = "Search word" },
            { "<leader>sw", function() require('fzf-lua').grep_visual() end, mode = "x", desc = "Search selection" },
            { "<leader>sb", function() require('fzf-lua').blines() end, desc = "Search buffer" },
            { "<leader>sr", function() require('fzf-lua').resume() end, desc = "Resume picker" },
            { "<leader>fh", function() require('fzf-lua').helptags() end, desc = "Help tags" },
            { "<leader>fk", function() require('fzf-lua').keymaps() end, desc = "Keymaps" },
            { "<leader>dd", function() require('fzf-lua').diagnostics_document() end, desc = "Buffer diagnostics" },
            { "<leader>dD", function() require('fzf-lua').diagnostics_workspace() end, desc = "Workspace diagnostics" },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns-setup') end,
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
                { "<leader>s", group = "search" },
                { "<leader>w", group = "windows" },
            },
        },
    },
    {
        "wnkz/monoglow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { "Aejkatappaja/cendre" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Search TODO comments" },
        },
    },
    {
        'stevearc/conform.nvim',
        opts = {},
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "x" },
                desc = "Format buffer or selection",
            }
        },
    },
    'tpope/vim-sleuth',
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
    { 'nvim-mini/mini.pairs', version = false },
}, {})

-- ### Default plugins setups ###
require('mini.pairs').setup()
