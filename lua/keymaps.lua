-- switch buffers
-- vim.keymap.set('n', '<leader>bn', ":bn<cr>", { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>bp', ":bp<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<s-k>', ":bn<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<s-j>', ":bp<cr>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, {})
-- open file explorer
vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle)

-- comment out lines
require('Comment').setup({ toggler = { line = '<C-_>' }, opleader = { line = '<C-_>' } })
--require('Comment').setup({ toggler = { line = '<C-_>' }, opleader = { line = 'gc' } })

-- toggle term
require("toggleterm").setup({ open_mapping = "<c-h>" })

-- debug
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>d', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>o', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>i', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>u', function() require('dap').step_out() end)
