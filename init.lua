require('options')
require('plugins')
require('lsp')
require('autocmp')
require('keymaps')

--red dot for breakpoint
vim.cmd("highlight DapBreakpoint guifg=#993939")
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = 'DapBreakpoint' })

--highlight yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

--debugconfig
-- local dap_ok, dap = pcall(require, "dap")
-- if not (dap_ok) then
--     print("nvim-dap not installed!")
--     return
-- end
--
-- require('dap').set_log_level('INFO') -- Helps when configuring DAP, see logs with :DapShowLog
--
-- dap.configurations.java = {
--     {
--         type = "java",       -- Which adapter to use
--         name = "Debug",      -- Human readable name
--         request = "launch",  -- Whether to "launch" or "attach" to program
--         program = "${file}", -- The buffer you are focused on when running nvim-dap
--     },
-- }
-- dap.adapters.java = function(callback, config)
--     -- Trigger the `vscode.java.startDebugSession` LSP command
--     vim.lsp.buf_request(0, 'workspace/executeCommand', {
--         command = 'vscode.java.startDebugSession',
--     }, function(_, _, result)
--         local port = result.port
--         callback({
--             type = 'server',
--             host = '127.0.0.1',
--             port = port,
--             enrich_config = function(_config)
--                 config.request = 'attach'
--                 return config
--             end,
--         })
--     end)
-- end
