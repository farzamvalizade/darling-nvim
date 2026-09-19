vim.pack.add({
	-- Tmux & split window navigation
	"https://github.com/christoomey/vim-tmux-navigator",

	-- Detect tabstop and shiftwidth automatically
	"https://github.com/tpope/vim-sleuth",

	-- Powerful Git integration
	"https://github.com/tpope/vim-fugitive",

	-- GitHub integration for vim-fugitive
	"https://github.com/tpope/vim-rhubarb",

	-- Hints keybinds
	"https://github.com/folke/which-key.nvim",

	-- Autoclose parentheses, brackets, quotes, etc.
	"https://github.com/windwp/nvim-autopairs",

	-- Highlight TODO, NOTE, etc. in comments
	"https://github.com/folke/todo-comments.nvim",

	-- Color highlighter
	"https://github.com/norcalli/nvim-colorizer.lua",

	-- Required by todo-comments
	"https://github.com/nvim-lua/plenary.nvim",
})

-- =========================================================
-- Which-key
-- =========================================================

require("which-key").setup({})

-- =========================================================
-- nvim-autopairs
-- =========================================================

require("nvim-autopairs").setup({})

-- =========================================================
-- Todo comments
-- =========================================================

require("todo-comments").setup({
	signs = false,
})

-- =========================================================
-- Colorizer
-- =========================================================

require("colorizer").setup({})
