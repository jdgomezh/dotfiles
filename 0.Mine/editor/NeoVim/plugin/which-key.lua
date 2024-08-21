-- which-key.lua - Configuration for which-key.nvim plugin with floating win.
-- This file sets up which-key to display key bindings in a visually appealing floating win.
-- The win is configured to appear centered both vertically and horizontally over the buffer content.

-- Define the main configuration table for the plugin
-- @plugin: Table - The main table that holds the plugin configuration.
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'folke/which-key.nvim': A plugin that displays key bindings in a floating win with various visual enhancements.
plugin[1] = 'folke/which-key.nvim'

-- Function to configure the plugin
-- This function sets up default options for which-key, including the appearance and behavior of the floating win.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring which-key.
plugin.opts = function(_, opts)
	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts.win = opts.win or {}
	opts.layout = opts.layout or {}
	opts.layout.width = opts.layout.width or {}
	opts.layout.height = opts.layout.height or {}

	-- Override default configurations for the which-key win appearance
	-- The 'win' table contains settings related to the visual appearance of the floating win.

	-- Set the title of the which-key win
	-- @title: String or nil - The title displayed at the top of the which-key floating win.
	-- Set to an empty string to remove the title.
	opts.win.title = ''

	-- Set the border style for the floating win
	-- @border: String - Defines the border type of the floating win.
	-- Possible values:
	--   'none'      : No border around the win.
	--   'single'    : Single line border.
	--   'double'    : Double line border.
	--   'rounded'   : Rounded corners for a smooth, modern look.
	--   'shadow'    : Adds a shadow effect to the win.
	opts.win.border = 'rounded'

	-- Configure the padding inside the which-key win
	-- @padding: Table - Defines the internal padding inside the win, creating space between the content and the border.
	-- Format: { top, right, bottom, left }
	opts.win.padding = { 1, 1, 1, 1 }

	-- Configure the layout of the which-key content within the win
	-- The 'layout' table contains settings related to the arrangement of content within the which-key win.

	-- Show help message at the bottom of the which-key win
	-- @show_help: Boolean - Determines whether a help message is displayed at the bottom of the which-key win.
	-- true: Show the help message.
	-- false: Hide the help message.
	opts.show_help = true

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Function to define key mappings
-- This function sets up key bindings for the plugin using the lazy.nvim keys field.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param keys: Table - A table containing the existing key mappings.
plugin.keys = function(_, keys)
	-- Load the which-key module to manage key mappings
	local wk = require("which-key")

	-- Add key bindings for the plugin
	-- @group: String - The name of the group under which the key binding will be categorized.
	wk.add({
		-- Define a group named 'tool' under the leader key '<leader>T'
		-- This can be used to group related key mappings for tools.
		{ "<leader>T", group = "tool" },

		-- Define a group named 'terminal' under the leader key '<leader>Tt'
		-- This can be used to group related key mappings for terminal commands.
		{ "<leader>Tt", group = "terminal" },
	})
	
	-- Return the modified keys table
	-- @return: Table - The updated keys table with new key mappings.
	return keys
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
