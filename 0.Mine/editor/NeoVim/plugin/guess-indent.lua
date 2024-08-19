-- guess-indent.lua - Configuration for nmac427/guess-indent.nvim plugin.
-- This file sets up Guess Indent, a plugin that automatically detects and sets the indentation style for files.
-- Guess Indent provides a seamless experience by determining whether a file uses spaces or tabs, and adjusts Neovim's settings accordingly.

-- Main configuration table
-- This table contains all the configuration options for Guess Indent.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: nmac427/guess-indent.nvim - A plugin to automatically detect and set indentation style for files.
-- This plugin helps in maintaining consistent indentation style across different projects by auto-detecting and setting the indentation preferences.
plugin[1] = 'nmac427/guess-indent.nvim'

-- Configuration function for the Guess Indent plugin.
-- This function sets up Guess Indent with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for Guess Indent.
plugin.config = function(PluginSpec, opts)
	-- Load the guess-indent module.
	-- @require: Require the guess-indent module for configuration.
	local guess_indent = require('guess-indent')

	-- Set default options if not already provided by the user.
	-- These options ensure the plugin behaves as expected with sensible defaults.

	-- Auto command setting
	-- @option: auto_cmd
	-- @type: boolean
	-- @default: true
	-- @description: Automatically sets up autocommands to detect indentation when buffers are read or file types are detected.
	opts.auto_cmd = true

	-- Override EditorConfig setting
	-- @option: override_editorconfig
	-- @type: boolean
	-- @default: false
	-- @description: If set to true, the plugin's detected indentation settings will override any settings specified in an .editorconfig file.
	opts.override_editorconfig = false

	-- Filetype Exclusion List
	-- @option: filetype_exclude
	-- @type: table of strings
	-- @default: { 'dashboard' }
	-- @description: List of file types to exclude from automatic indentation detection.
	opts.filetype_exclude = { 'dashboard' }

	-- Buftype Exclusion List
	-- @option: buftype_exclude
	-- @type: table of strings
	-- @default: { 'terminal', 'nofile' }
	-- @description: List of buffer types to exclude from automatic indentation detection.
	opts.buftype_exclude = { 'terminal', 'nofile' }

	-- Apply the configuration options to the guess-indent setup.
	-- @setup: Call the setup function with the provided options.
	guess_indent.setup(opts)
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
