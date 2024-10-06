-- [protected call] require("cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify('cmp_status_ok: false [.../nvim/lua/user/add-ons/cmp.lua]')
	return
end

-- [protected call] require("luasnip")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify('snip_status_ok: false [.../nvim/lua/user/add-ons/cmp.lua]')
	return
end

-- idk what this does but it should make sure lausnip work
require("luasnip/loaders/from_vscode").lazy_load()

-- cmp completely menu kind info
local kind_info = {
	Text 			= "{Text}",
	Method 			= "{Method}",
	Function 		= "{Function}",
	Constructor 	= "{Constructor}",
	Field 			= "{Field}",
	Variable 		= "{Variable}",
	Class 			= "{Class}",
	Interface 		= "{Interface}",
	Module 			= "{Module}",
	Property 		= "{Property}",
	Unit 			= "{Unit}",
	Value 			= "{Value}",
	Enum 			= "{Enum}",
	Keyword 		= "{Keyword}",
	Snippet 		= "{Snippet}",
	Color 			= "{Color}",
	File 			= "{File}",
	Reference 		= "{Reference}",
	Folder 			= "{Folder}",
	EnumMember		= "{EnumMember}",
	Constant		= "{Constant}",
	Struct			= "{Struct}",
	Event			= "{Event}",
	Operator		= "{Operator}",
	TypeParameter 	= "{TypeParameter}",
}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		-- ["<CR>"] = cmp.mapping.confirm { select = true },
		["<CR>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			else
				fallback()
			end
		end, {"i", "s", "c"}),

		["<A-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {"i", "s", "c"}),

		["<A-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {"i", "s", "c"}),
  },
  formatting = {
	  fields = {"abbr", "kind", "menu"},
	  format = function(entry, vim_item)
		  vim_item.kind = string.format("%s", kind_info[vim_item.kind])
		  vim_item.menu = ({
			  luasnip = "[Snippet]",
			  nvim_lsp = "[LSP]",
			  buffer = "[Buffer]",
			  path = "[Path]",
		  })[entry.source.name]
		  return vim_item
	  end,
  },
  sources = {
	  {name = "nvim_lsp"},
	  {name = "luasnip"},
	  {name = "buffer"},
	  {name = "path"},
  },
  documentation = {
	  border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
  },
  experimental = {
	  ghost_text = false,
	  native_menu = false,
  },
}

cmp.setup.cmdline('/', {
	sources = {
		{name = 'buffer'}
	}
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{name = 'path'}
	}, {
		{name = 'cmdline'}
	})
})
