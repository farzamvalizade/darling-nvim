vim.pack.add({
	"https://github.com/goolord/alpha-nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")

dashboard.section.header.val = {
	[[                                    ]],
	[[        ╭──────────────────╮       ]],
	[[        │   02  /  NEOVIM  │       ]],
	[[        ╰──────────────────╯       ]],
	[[                                    ]],
	[[          「 Darling 」              ]],
	[[                                    ]],
	[[       ✦  ✦  ✦  ✦  ✦  ✦           ]],
	[[                                    ]],
}

alpha.setup(dashboard.opts)
