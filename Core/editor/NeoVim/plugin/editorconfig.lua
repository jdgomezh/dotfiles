-- editorconfig.lua - Configuration for gpanders/editorconfig.nvim plugin.
-- This file sets up EditorConfig, a plugin that enforces coding style defined in .editorconfig files.
-- EditorConfig helps developers define and maintain consistent coding styles between different editors and IDEs.

-- Main configuration table
-- This table contains all the configuration options for EditorConfig.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: gpanders/editorconfig.nvim - A plugin to enforce coding styles defined in .editorconfig files.
-- This plugin helps in maintaining consistent coding styles across different editors by adhering to the rules specified in .editorconfig files.
plugin[1] = 'gpanders/editorconfig.nvim'

-- Configuration function for the EditorConfig plugin.
-- This function sets up EditorConfig with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for EditorConfig.
plugin.config = function(PluginSpec, opts)
	-- Load the editorconfig module.
	-- @require: Require the editorconfig module for configuration.
	local editorconfig = require('editorconfig')

	-- Apply the configuration options to the editorconfig setup.
	-- @note: editorconfig.nvim does not require explicit setup, so we ensure it's loaded and operational.

	-- Create an autocommand to enforce EditorConfig settings on buffer read and file type detection.
	-- Ensures consistent coding styles as per .editorconfig across different files.
	-- @autocmd: Define autocommands to trigger editorconfig functions.
	-- @events: Events like BufReadPost and FileType that trigger the plugin.
	-- @callback: Callback function to execute editorconfig functions.
	vim.api.nvim_create_autocmd({"BufReadPost", "FileType"}, {
		pattern = "*",
		callback = function()
			-- Trigger editorconfig function to enforce coding style.
			-- @cmd: Command to run editorconfig's detect function.
			editorconfig.config()
		end,
	})
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
