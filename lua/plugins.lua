local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                build = function() pcall(vim.cmd, 'MasonUpdate') end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    {
        'codota/tabnine-nvim', build = "./dl_binaries.sh", config = function() require('tabnine').setup({}) end
    },
    {
        'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup({}) end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        -- indent = {enable = true},
        -- incremental_selection = {enable = true}
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = {
                    enable = true,
                    -- additional_vim_regex_highlighting = true
                },
                -- indent = { enable = true },
                -- incremental_selection = { enable = true }
            }
        end
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup({}) end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    component_separators = '',
                    section_separators = '',
                    disabled_filetypes = { 'NvimTree', },
                    ignore_focus = { 'NvimTree', 'toggleterm' },
                },
            })
        end
    },
    {
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    offsets = {
                        { filetype = 'NvimTree', text = 'Explorer' }
                    }
                }
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons", },
        opts = {}
    },
    {
        'Mofiqul/vscode.nvim',
        config = function()
            require('vscode').setup({ italic_comments = true })
            require('vscode').load()
            vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#808080' })
            vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FFFFFF' })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#808080' })
        end
    },

    { 'lewis6991/gitsigns.nvim', opts = {} },
    { 'j-hui/fidget.nvim',       opts = {} },
    {
        "lukas-reineke/indent-blankline.nvim",
        "akinsho/toggleterm.nvim",
        'numToStr/Comment.nvim',
        'tpope/vim-fugitive',
        'mfussenegger/nvim-dap',
    },
})
