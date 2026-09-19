vim.pack.add({
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

require("ibl").setup({
	indent = {
		char = "▏",
	},

	scope = {
		show_start = false,
		show_end = false,
		show_exact_scope = false,
	},

	exclude = {
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"neo-tree",
		},
	},
})
