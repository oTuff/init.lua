vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.vimwiki_list = { { path = '~/Documents/Wiki', syntax = 'markdown', ext = '.md' } }
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

--vim.opt.spell = true
vim.opt.spellsuggest = 'best,5'

--TODO: remove?
vim.opt.clipboard = 'unnamedplus'
vim.opt.path.append(vim.opt.path, '**')
