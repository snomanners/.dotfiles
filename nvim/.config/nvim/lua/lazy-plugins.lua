-- Here we define all the plugins we will need
require("lazy").setup({
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        event = "VeryLazy",
    },
    'lewis6991/gitsigns.nvim',
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        priority = 1000,
    },
    'mbbill/undotree',
    'tpope/vim-sleuth',
    {
        'aktersnurra/no-clown-fiesta.nvim',
        lazy = false,
        priority = 1000,
    },
    -- 'slugbyte/lackluster.nvim',
    -- 'Yazeed1s/oh-lucy.nvim',
    -- 'ramojus/mellifluous.nvim',
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim'},
        event = "VeryLazy",
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
    },
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
            -- Mason is just too beautiful not to incude
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Notifications and LSP progress messages, again, we'll see if it is actually useful
            { 'j-hui/fidget.nvim',       opts = {} },

            -- Configures lua language server for nvim config, guess it is useful, we'll see
            'folke/neodev.nvim',
        },
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
        build = ':TSUpdate',
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
}, {})

-- ### Default plugins setups ###
require('gitsigns').setup()
