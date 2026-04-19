-- NeoVim configuration
local opt = vim.opt
opt.cursorline = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.autoindent = true
opt.number = true
opt.wrap = true
opt.scrolloff = 3
opt.wildmenu = true
opt.autoread = true
opt.hidden = true
opt.cc = "125"
opt.termguicolors = true

vim.g.mapleader = ','

local confpath = os.getenv("HOME") .. "/.config/nvim/"
package.path = confpath .. "?.lua;" .. package.path

vim.opt.background = "dark"

vim.cmd.colorscheme('oxocarbon')

require('nvim-treesitter')

-- lspconfig
local lsp = require('lspconfig')
lsp.lua_ls.setup {}
lsp.nil_ls.setup {}
lsp.gopls.setup {}
lsp.rust_analyzer.setup {}
-- lsp.tsserver.setup {
-- 	root_dir = function(fname)
-- 		return require('lspconfig.util').root_pattern("package.json")(fname)
-- 	end,
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false
-- 	end,
-- 	handlers = {
-- 		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
-- 			if result.diagnostics == nil then
-- 				return
-- 			end
-- 
-- 			local idx = 1
-- 
-- 			while idx <= #result.diagnostics do
-- 				local entry = result.diagnostics[idx]
-- 				local formatter = require("format-ts-errors")[entry.code]
-- 				entry.message = formatter and formatter(entry.message) or entry.message
-- 				if entry.code == 80001 then
-- 					table.remove(result.diagnostics, idx)
-- 				else
-- 					idx = idx + 1
-- 				end
-- 			end
-- 			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
-- 		end,
-- 	},
-- 	settings = {
-- 		typescript = {
-- 			inlayHints = {
-- 				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 				includeInlayFunctionParameterTypeHints = true,
-- 				includeInlayVariableTypeHints = true,
-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
-- 				includeInlayPropertyDeclarationTypeHints = true,
-- 				includeInlayFunctionLikeReturnTypeHints = true,
-- 				includeInlayEnumMemberValueHints = true,
-- 			},
-- 		},
-- 		javascript = {
-- 			inlayHints = {
-- 				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 				includeInlayVariableTypeHints = true,
-- 				includeInlayFunctionParameterTypeHints = true,
-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
-- 				includeInlayPropertyDeclarationTypeHints = true,
-- 				includeInlayFunctionLikeReturnTypeHints = true,
-- 				includeInlayEnumMemberValueHints = true,
-- 			},
-- 		},
-- 	},
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.html.setup {
	capabilities = capabilities,
	filetypes = {
		"html",
		"templ",
	},
	configurationSection = { "html", "css", "javascript" },
	embeddedLanguages = {
		css = true,
		javascript = true
	},
	provideFormatter = true,
}

-- lsp-inlayhints
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})
require("lsp-inlayhints").setup(options)
vim.api.nvim_set_keymap(
	"n",
	"<leader>uI",
	"<cmd>lua require('lsp-inlayhints').toggle()<CR>",
	{ noremap = true, silent = true }
)

-- require 'plugins.lualine'.config()
-- require 'plugins.whichkey'.config()
-- require 'plugins.lspconfig'.config()
-- require 'plugins.inlayhints'.config()
-- require 'plugins.lua-snip'.config()
-- require 'plugins.cmp'.config()
-- require 'plugins.telescope'.config()
-- require 'plugins.dim'.config()
-- require 'plugins.go'.config()

-- require 'indent-blankline.nvim'.setup {}
-- require "ibl".setup {}
-- require 'gitsigns'.setup {}
-- require 'navigator'.setup {}
