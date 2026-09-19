-- ===========    Imports     =========== --
require("core.options")
require("core.keymaps")
-- =========== Plugin Manager =========== --
do
	-- [[ Intro to `vim.pack` ]]
	-- `vim.pack` is a new plugin manager built into Neovim,
	--  which provides a Lua interface for installing and managing plugins.
	--
	--  See `:help vim.pack`, `:help vim.pack-examples` or the
	--  excellent blog post from the creator of vim.pack and mini.nvim:
	--  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
	--
	--  To inspect plugin state and pending updates, run
	--    :lua vim.pack.update(nil, { offline = true })
	--
	--  To update plugins, run
	--    :lua vim.pack.update()
	--
	--
	--  Throughout the rest of the config there will be examples
	--  of how to install and configure plugins using `vim.pack`.
	--
	--  In this section we set up some autocommands to run build
	--  steps for certain plugins after they are installed or updated.

	local function run_build(name, cmd, cwd)
		local result = vim.system(cmd, { cwd = cwd }):wait()
		if result.code ~= 0 then
			local stderr = result.stderr or ""
			local stdout = result.stdout or ""
			local output = stderr ~= "" and stderr or stdout
			if output == "" then
				output = "No output from build command."
			end
			vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
		end
	end

	-- This autocommand runs after a plugin is installed or updated and
	-- runs the appropriate build command for that plugin if necessary.
	--
	-- See `:help vim.pack-events`
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name = ev.data.spec.name
			local kind = ev.data.kind
			if kind ~= "install" and kind ~= "update" then
				return
			end

			if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
				run_build(name, { "make" }, ev.data.path)
				return
			end

			if name == "LuaSnip" then
				if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
					run_build(name, { "make", "install_jsregexp" }, ev.data.path)
				end
				return
			end

			if name == "nvim-treesitter" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
				return
			end
		end,
	})
end

vim.pack.add({
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	-- optional, but recommended
	"https://github.com/nvim-tree/nvim-web-devicons",
})
require("plugins.neotree")
-- =========== Color Theme =========== --
vim.pack.add({
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
})
require("plugins.colortheme")
-- =========== Buffer Line =========== --
require("plugins.bufferline")
-- =========== Lua Line    =========== --
require("plugins.lualine")
-- =========== Tree Sitter =========== --
require("plugins.treesitter")
-- =========== Telescope   =========== --
require("plugins.telescope")
-- =========== Auto Completion ======= --
require("plugins.autocompletion")
-- ===========    LSP      =========== --
require("plugins.lsp")
-- ===========  Formatter  =========== --
require("plugins.none-ls")
-- =========== Git Sings   =========== --
require("plugins.gitsigns")
-- ===========   Alpha    ============ --
require("plugins.alpha")
-- ===========  Indent   ============= --
require("plugins.indent-blankline")
-- ===========   Misc    ============= --
require("plugins.misc")
