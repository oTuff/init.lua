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
    'jdtls',
    'jsonls',
    -- 'kotlin_language_server',
    'lemminx',
    'lua_ls',
    'marksman',
    -- 'omnisharp',
    -- 'omnisharp_mono',
    -- 'pylsp', --better than pyright??
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
