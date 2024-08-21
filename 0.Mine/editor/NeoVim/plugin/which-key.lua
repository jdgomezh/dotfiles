-- which-key.lua - Configuration for which-key.nvim plugin with floating win.
-- This file sets up which-key to display key bindings in a visually appealing floating win.
-- The win is configured to appear centered both vertically and horizontally over the buffer content.

-- Define the main configuration table for the plugin
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
	-- @title: String or nil - Removes the title if any
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

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
