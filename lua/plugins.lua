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
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or , branch = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- {
    --     'codota/tabnine-nvim', build = "./dl_binaries.sh", config = function() require('tabnine').setup({}) end
    -- },
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
    { 'vimwiki/vimwiki' },
    {
        'Mofiqul/vscode.nvim',
        config = function()
            require('vscode').setup({ italic_comments = true })
            require('vscode').load()
            vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#808080' })
            vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FFFFFF' })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#808080' })
        end
    }, {
    "jay-babu/mason-nvim-dap.nvim",
    requires = { 'mfussenegger/nvim-dap', 'williamboman/mason.nvim', },
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = { "javadbg", "javatest" },
            handlers = {
                function(config)
                    -- all sources with no handler get passed here
                    -- Keep original functionality
                    require('mason-nvim-dap').default_setup(config)
                end,
                javadbg = function(config)
                    config.adapters = {
                            -- You need to extend the classPath to list your dependencies.
                            -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
                            classPaths = {},
                            -- If using multi-module projects, remove otherwise.
                            -- projectName = "yourProjectName",
                            javaExec = "/bin/java",
                            mainClass = "${file}",

                            -- If using the JDK9+ module system, this needs to be extended
                            -- `nvim-jdtls` would automatically populate this property
                            modulePaths = {},
                            name = "Launch YourClassName",
                            request = "launch",
                            type = "java"
                        },
                        require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,
            }
        })
    end
},

    { 'lewis6991/gitsigns.nvim', opts = {} },
    {
        'mfussenegger/nvim-dap',
        "lukas-reineke/indent-blankline.nvim",
        "akinsho/toggleterm.nvim",
        'numToStr/Comment.nvim',
        'tpope/vim-fugitive',
    },
})
