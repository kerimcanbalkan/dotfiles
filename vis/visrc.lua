require('vis')

-- config --

-- global
vis.events.subscribe(vis.events.INIT, function()
	vis:command("set theme caelus")
end)
-- per-window
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command("set tabwidth 1")
	vis:command("set relativenumbers true")
	vis:command("set autoindent true")
	vis:command("set showspaces false")
	vis:command("set showtabs false")
	vis:command("set expandtab off")
	vis:command("set shell /usr/bin/env sh")
 vis:command('set wrapcolumn 120')
 vis:command('set breakat " .,;"')
	vis:map(vis.modes.VISUAL," y", '"+y"')
	vis:map(vis.modes.NORMAL," p", '"+p"')
	vis:map(vis.modes.NORMAL, " q", function()
		vis:command("q!")
	end, "")
	vis:map(vis.modes.NORMAL, " w", function()
		vis:command("w!")
	end, "")
end)

-- plugins --
-- fzf
local plugin_vis_open = require('plugins/vis-fzf-open')
plugin_vis_open.fzf_path = "fzf"
plugin_vis_open.fzf_args = "--height=40%"
vis.events.subscribe(vis.events.INIT, function()
    vis:command('map! normal ;f :fzf<Enter>')
    end)

-- vis-commentary
require("plugins/vis-commentary")()
-- vis-autoclose
local autoclose = require('plugins/vis-autoclose')
-- colorizer
local colorizer = require('plugins/vis-colorizer')
colorizer.three = false
colorizer.six   = true
-- vis-modal
local modal = require('plugins/vis-modal')
-- complete-filename
local completefilename = require('plugins/complete-filename')
-- vis-lspc
local lsp = require('plugins/vis-lspc')
lsp.menu_cmd = "fzf"
lsp.ls_map.clangd = {
	formatting_options = {tabSize = 4, insertSpaces = false}
}
lsp.ls_map.lua = {
	name = 'lua-language-server',
	cmd = 'lua-language-server',
	settings = {
		Lua = {diagnostics = { globals = {'vis'}}, telemetry = {enable = false}},
	},
	formatting_options = {tabSize = 4, insertSpaces = true},
}
-- vis-gpg
local gpg = require('plugins/vis-gpg')
gpg.key = "F85AAD4AA4841840"
