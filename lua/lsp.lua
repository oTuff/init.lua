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
    nmap('<leader>h', vim.lsp.buf.hover, '')               -- remap hover to space+k because i use shift+j/k to cycle buffers
    nmap('<a-cr>', vim.lsp.buf.code_action, 'Code Action') -- alt+enter like intellij maybe <leader>ca instead?
end)
lsp.ensure_installed({
    --'ansiblels',
    --'angularls',
    'bashls',
    'cssls',
    'clangd',
    'csharp_ls',
    'docker_compose_language_service',
    'dockerls',
    -- 'elixirls',
    -- 'gopls',
    -- 'grammarly',
    -- 'hls',
    'html',
    -- 'java-debug-adapter',
    -- 'java-test',
    'jdtls',
    -- 'js-debug-adapter',
    'jsonls',
    -- 'kotlin_debug-adapter',
    -- 'kotlin_language_server',
    -- 'ktlint',
    'lemminx',
    'lua_ls',
    'marksman',
    -- 'omnisharp',
    -- 'omnisharp_mono',
    --'pylsp',
    'pyright',
    -- 'ruby_lsp',
    -- 'rust_analyzer',
    -- 'svelte',
    -- 'sqlls',
    -- 'tailwindcss',
    -- 'texlab',
    'ltex',
    'tsserver',
    'yamlls',
})
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
