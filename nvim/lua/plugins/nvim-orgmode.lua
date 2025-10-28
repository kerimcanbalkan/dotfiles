return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/Agenda/**/*",
			org_default_notes_file = "~/Notes/refile.org",
		})
	end,
}
