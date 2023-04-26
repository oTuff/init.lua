--options
vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamedplus'
--find ting
vim.opt.path.append(vim.opt.path, '**')
--nocase sensitive
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true

--plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
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
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    },
    {
        'codota/tabnine-nvim',
        build = "./dl_binaries.sh",
        config = function()
            require('tabnine').setup({
            })
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup { auto_install = true, highlight = { enable = true }, }
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({ toggler = { line = '<C-_>' }, opleader = { line = '<C-_>' } })
        end
    },
    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    },
    {
        'tpope/vim-fugitive'
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    component_separators = '',
                    section_separators = '',
                    disabled_filetypes = {
                        'NvimTree',
                    },
                    ignore_focus = { 'NvimTree', 'toggleterm' },
                },
            })
        end
    },
    {
        -- tabs
        'akinsho/bufferline.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    disabled_filetypes = { 'NvimTree', 'none' },
                    offset = {
                        filetype = "NvimTree",
                        text = 'File Explorer'
                    }
                }
            })
        end
    },
    {
        -- toggle terminal
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({ open_mapping = "<c-h>" })
        end
    },
    {
        -- file explorer
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        -- debugger
        'mfussenegger/nvim-dap',
    },
    {
        --theme
        'Mofiqul/vscode.nvim'
    },
    {
        -- eye candy
        'lewis6991/gitsigns.nvim',
        "lukas-reineke/indent-blankline.nvim",
        'j-hui/fidget.nvim',
    },
})
require("indent_blankline").setup()
require('gitsigns').setup()
--file explorer
local api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>e', api.tree.toggle)
vim.keymap.set('n', '<leader>o', api.tree.open)
--lsp
local lsp = require('lsp-zero').preset({})
local on_attach = lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat() -- autoformat on save
    -- keymaps
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<a-cr>', vim.lsp.buf.code_action, 'Code Action(alt+enter - like Intellij)')
end)
local servers = {
    pylsp = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), }
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
-- auto completion
local cmp = require('cmp')
cmp.setup({
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert { ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        --        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})
-- add autopairs when completing function
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
require('fidget').setup()
--theme
require('vscode').setup({ italic_comments = true, })
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#808080' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FFFFFF' })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#808080' })
end

require('vscode').load()
LineNumberColors()
