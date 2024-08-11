require("paq")({
	"savq/paq-nvim",
	"neovim/nvim-lspconfig",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"junegunn/fzf.vim",

	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"themaxmarchuk/tailwindcss-colors.nvim",
	"j-hui/fidget.nvim",
	"stevearc/conform.nvim",
})
-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.scrolloff = 10
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellsuggest = "best,5"
vim.opt.completeopt = "menuone,noinsert"
vim.opt.shortmess = "OlToFcCT"
vim.o.pumheight = 10
vim.opt.complete = ".,w,b,u,t,f"
vim.o.list = true
vim.opt.listchars = {
	tab = "▏ ",
	leadmultispace = "▏ ",
	trail = "·",
	extends = "»",
	precedes = "«",
}
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.linebreak = true
vim.opt.breakindent = true
function _G.lsp_diagnostics()
	local diagnostics = vim.diagnostic.get(0) or {} -- Get diagnostics for the current buffer or empty table
	-- local counts = { errors = 0, warnings = 0 }
	local counts = { errors = 0, warnings = 0, hints = 0, info = 0 }

	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.severity == vim.diagnostic.severity.ERROR then
			counts.errors = counts.errors + 1
		elseif diagnostic.severity == vim.diagnostic.severity.WARN then
			counts.warnings = counts.warnings + 1
		elseif diagnostic.severity == vim.diagnostic.severity.HINT then
			counts.hints = counts.hints + 1
		elseif diagnostic.severity == vim.diagnostic.severity.INFO then
			counts.info = counts.info + 1
		end
	end

	-- Always display the counts, even if they are 0
	-- return string.format("E:%d W:%d", counts.errors, counts.warnings)
	return string.format("E:%d W:%d I:%d H:%d", counts.errors, counts.warnings, counts.info, counts.hints)
end

vim.opt.statusline = "%{FugitiveStatusline()} %{v:lua.lsp_diagnostics()} %<%f %h%m%r %=%-14.(%l,%c%V%) %P"

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("i", "<C-space>", "<C-x><C-o>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "]q", "<cmd>cn<cr>")
vim.keymap.set("n", "[q", "<cmd>cp<cr>")
vim.keymap.set("n", "]b", "<cmd>bn<cr>")
vim.keymap.set("n", "[b", "<cmd>bp<cr>")
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true })
vim.keymap.set("n", "<leader>ff", "<cmd>Files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Rg<CR>")
vim.keymap.set("i", "<c-x><c-f>", "fzf#vim#complete#path('rg --files')", { expr = true, noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>Buffers<CR>")
vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_option(buf, "wrap", true)
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*/playbooks/*.yml", "*/roles/*/tasks/*.yml", "*/playbooks/*.yaml", "*/roles/*/tasks/*.yaml" },
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})

-- LSP
local lspconfig = require("lspconfig")
local servers = {
	lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
	pyright = {
		settings = { pyright = { disableOrganizeImports = true }, python = { analysis = { ignore = { "*" } } } },
	},
	ruff = {},
	tsserver = {
		-- on_attach = function(client, bufnr)
		on_attach = function(_, bufnr)
			require("tailwindcss-colors").buf_attach(bufnr)
		end,
		filetypes = { "javascript", "javascriptreact", "rescript", "typescript", "typescriptreact" },
	},
	html = {},
	jsonls = {},
	cssls = {},
	tailwindcss = {},
	eslint = {},
	graphql = {},
	elixirls = {},
	sqlls = {},
	dockerls = {},
	yamlls = {},
	ansiblels = {},
	bashls = {},
	marksman = {},
}
for server_name, server_config in pairs(servers) do
	lspconfig[server_name].setup(server_config)
end
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.supports_method("textDocument/completion") then
			-- nvim 0.11 native autocomplete
			-- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

			-- homemade autocomplete
			vim.api.nvim_create_autocmd("InsertCharPre", {
				pattern = "*",
				callback = function()
					if vim.fn.mode() == "i" and vim.bo.omnifunc ~= "" and vim.fn.pumvisible() == 0 then
						vim.api.nvim_feedkeys(
							vim.api.nvim_replace_termcodes("<c-x><c-o>", true, false, true),
							"n",
							true
						)
					end
				end,
			})
		end
	end,
})

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = { enable = true, disable = { "csv" }, additional_vim_regex_highlighting = false },
})

require("fidget").setup()
require("nvim-autopairs").setup()
require("nvim-ts-autotag").setup()

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
	return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
		or get_option(filetype, option)
end

-- require("tailwindcss-colors").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		css = { "prettier" },
		svelte = { "prettier" },
		graphql = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)
	end,
})
