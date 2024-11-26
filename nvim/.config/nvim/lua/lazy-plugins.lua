-- Here we define all the plugins we will need
require("lazy").setup({
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
    'numToStr/Comment.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-lualine/lualine.nvim',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'stevearc/dressing.nvim',
    'tpope/vim-sleuth',
    'nyoom-engineering/oxocarbon.nvim',
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim'}
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
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
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    -- This step is not supported in many windows environments
                    -- Remove the below condition to re-enable on windows
                    if vim.fn.has 'win32' == 1 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
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
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
}, {})

-- ### Default plugins setups ###
require('Comment').setup()
require('gitsigns').setup()
