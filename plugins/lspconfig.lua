return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"jose-elias-alvarez/typescript.nvim",
			dependencies = {
				"davidosomething/format-ts-errors.nvim",
			},
		},
	},
	opts = {
		inlay_hints = {
			enabled = true,
		},
		format = {
			timeout_ms = 10000,
		},
	},
	config = function()
		local lsp = require('lspconfig')
		lsp.lua_ls.setup {}
		lsp.gopls.setup {}
		lsp.rust_analyzer.setup {}
		lsp.tsserver.setup {
			root_dir = function(fname)
				return require('lspconfig.util').root_pattern("package.json")(fname)
			end,
			on_attach = function(client)
				client.resolved_capabilities.document_formatting = false
			end,
			handlers = {
				["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
					if result.diagnostics == nil then
						return
					end

					local idx = 1

					while idx <= #result.diagnostics do
						local entry = result.diagnostics[idx]
						local formatter = require("format-ts-errors")[entry.code]
						entry.message = formatter and formatter(entry.message) or entry.message
						if entry.code == 80001 then
							table.remove(result.diagnostics, idx)
						else
							idx = idx + 1
						end
					end
					vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
				end,
			},
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayVariableTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		}

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
	end,
}
