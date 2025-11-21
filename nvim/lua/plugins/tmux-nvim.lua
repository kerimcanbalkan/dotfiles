return {
	"aserowy/tmux.nvim",
	config = function()
		return require("tmux").setup({
			background = {
				transparent = true, -- set the background to be opaque
			},
		})
	end,
}
