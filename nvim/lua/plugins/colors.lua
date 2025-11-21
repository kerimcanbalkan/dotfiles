return {
	"f4z3r/gruvbox-material.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("gruvbox-material").setup({
			background = {
				transparent = true,
			},
		})
		vim.cmd("colorscheme gruvbox-material")
	end,
}
