vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
	"https://github.com/jayp0521/mason-null-ls.nvim",
})

-- =========================================================
-- Mason Null-LS
-- =========================================================

require("mason-null-ls").setup({
	ensure_installed = {
		"prettier",
		"eslint_d",
		"shfmt",
		"checkmake",
	},

	automatic_installation = true,
})

-- =========================================================
-- None-LS
-- =========================================================

local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {

	-- =======================================================
	-- JavaScript / TypeScript / React / Vue / Web
	-- =======================================================

	formatting.prettier.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"html",
			"css",
			"scss",
			"json",
			"jsonc",
			"yaml",
			"markdown",
		},
	}),

	require("none-ls.diagnostics.eslint_d"),

	-- =======================================================
	-- Python
	-- =======================================================

	require("none-ls.formatting.ruff_format"),

	require("none-ls.formatting.ruff").with({
		extra_args = {
			"--extend-select",
			"I",
		},
	}),

	-- =======================================================
	-- Lua
	-- =======================================================

	formatting.stylua,

	-- =======================================================
	-- Shell
	-- =======================================================

	formatting.shfmt.with({
		args = {
			"-i",
			"4",
		},
	}),

	-- =======================================================
	-- Terraform
	-- =======================================================

	formatting.terraform_fmt,

	-- =======================================================
	-- Makefile
	-- =======================================================

	diagnostics.checkmake,
}

-- =========================================================
-- Format on save
-- =========================================================

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
	sources = sources,

	on_attach = function(client, bufnr)
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,

				callback = function()
					vim.lsp.buf.format({
						async = false,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
