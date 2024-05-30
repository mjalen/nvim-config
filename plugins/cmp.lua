return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	},
	config = function()
		local luasnip = require 'luasnip'
		local cmp = require 'cmp'
		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-f>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end),
				['<C-b>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end),
				-- ['<C-Space>'] = cmp.mapping.complete(),
				-- ['<C-e>'] = cmp.mapping.abort(),
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({ select = true, })
						end
					else
						fallback()
					end
				end),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp', },
				{ name = 'luasnip', },
			}, {
				{ name = 'buffer', },
			}),
		}
	end,
}
