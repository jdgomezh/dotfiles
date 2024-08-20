-- guess-indent.lua - Configuration for nmac427/guess-indent.nvim plugin.
-- This file sets up Guess Indent, a plugin that automatically detects and sets the indentation style for files.
-- Guess Indent provides a seamless experience by determining whether a file uses spaces or tabs, and adjusts Neovim's settings accordingly.

-- Main configuration table
-- This table contains all the configuration options for Guess Indent.
local plugin = {}

-- Define the Guess Indent plugin for lazy.nvim
-- @plugin: nmac427/guess-indent.nvim - A plugin to automatically detect and set indentation style for files.
plugin[1] = 'nmac427/guess-indent.nvim'

-- Configuration function for the Guess Indent plugin.
-- This function sets up Guess Indent with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
plugin.config = function(_, opts)
	-- Load the guess-indent module.
	local guess_indent = require('guess-indent')

	-- Set default options if not already provided by the user.
	-- These options ensure the plugin behaves as expected with sensible defaults.
	opts.auto_cmd = true
	opts.override_editorconfig = false
	opts.filetype_exclude = { 'dashboard' }
	opts.buftype_exclude = { 'terminal', 'nofile' }

	-- Apply the configuration options to the guess-indent setup.
	guess_indent.setup(opts)
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
