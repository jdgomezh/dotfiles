-- editorconfig.lua - Configuration for gpanders/editorconfig.nvim plugin.
-- This file sets up EditorConfig, a plugin that enforces coding style defined in .editorconfig files.
-- EditorConfig helps developers define and maintain consistent coding styles between different editors and IDEs.

-- Main configuration table
-- This table contains all the configuration options for EditorConfig.
local plugin = {}

-- Define the EditorConfig plugin for lazy.nvim
-- @plugin: gpanders/editorconfig.nvim - A plugin to enforce coding styles defined in .editorconfig files.
plugin[1] = 'gpanders/editorconfig.nvim'

-- Configuration function for the EditorConfig plugin.
-- This function sets up EditorConfig with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
plugin.config = function(_, opts)
	-- Load the editorconfig module.
	local editorconfig = require('editorconfig')

	-- Create an autocommand to enforce EditorConfig settings on buffer read and file type detection.
	-- Ensures consistent coding styles as per .editorconfig across different files.
	vim.api.nvim_create_autocmd({"BufReadPost", "FileType"}, {
		pattern = "*",
		callback = function()
			-- Trigger editorconfig function to enforce coding style.
			editorconfig.config()
		end,
	})
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
