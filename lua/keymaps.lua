-- switch buffers
-- vim.keymap.set('n', '<leader>bn', ":bn<cr>", { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>bp', ":bp<cr>", { noremap = true, silent = true })

-- open file explorer
vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle)

-- comment out lines
require('Comment').setup({ toggler = { line = '<C-_>' }, opleader = { line = '<C-_>' } })

-- toggle term
require("toggleterm").setup({ open_mapping = "<c-h>" })
