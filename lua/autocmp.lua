local cmp = require('cmp')
cmp.setup({
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert { ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }
})
-- Autopairs when completing function
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
