-- alpha.lua - Configuration for nvim-alpha plugin with LazyVim integration.
-- This file sets up the dashboard for Neovim, providing shortcuts to common tasks.

-- Define the main configuration table for the plugin
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'goolord/alpha-nvim': A fast and highly customizable start screen plugin for Neovim.
plugin[1] = 'goolord/alpha-nvim'

-- Define plugin dependencies
-- Dependencies are other plugins required for this plugin to work correctly.
-- @dependencies: Table - List of dependencies required by alpha-nvim.
-- 'nvim-tree/nvim-web-devicons': Optional dependency for file icons, enhancing visual appearance.
plugin.dependencies = {
	'nvim-tree/nvim-web-devicons',
}

-- Load header from an external file
-- This function reads the header (ASCII art) from a specified file path.
-- @param file_path: String - The path to the file containing the ASCII art.
-- @return: String - The contents of the file as a single string, suitable for displaying as a header.
local function load_header(file_path)
	local header_lines = {}  -- Table to hold each line of the header
	local file = io.open(file_path, 'r')  -- Open the file in read mode
	if file then
		-- Iterate over each line in the file and add it to the header_lines table
		for line in file:lines() do
			table.insert(header_lines, line)
		end
		-- Close the file after reading
		file:close()
	end
	-- Add an empty line at the end of the header for spacing
	table.insert(header_lines, '')

	-- Concatenate all lines into a single string with newline separators and return it
	return table.concat(header_lines, '\n')
end

-- Function to configure the plugin
-- This function sets up the plugin options, including the header and buttons for the dashboard.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring alpha-nvim.
plugin.opts = function(_, opts)
	-- Load necessary modules to configure the dashboard
	local dashboard = require('alpha.themes.dashboard')  -- Load the dashboard theme module from alpha-nvim
	local telescope = require('telescope')  -- Load Telescope for file navigation functionality

	-- Load the header from the external file using the load_header function
	-- The path is constructed using the global PATHS variable.
	local header = load_header(_G.PATHS.env_root .. '/Conf/0.Mine/common/ascii/banner.txt')

	-- Ensure that pre-existing configurations in opts are preserved if they exist
	-- This prevents overwriting of user-defined configurations.
	opts.section = opts.section or {}
	opts.section.header = opts.section.header or {}
	opts.section.buttons = opts.section.buttons or {}
	opts.section.header.val = opts.section.header.val or {}
	opts.section.buttons.val = opts.section.buttons.val or {}

	-- Add a custom button for the file browser to the dashboard
	-- @button: Adds a button to the first position in the buttons section.
	-- @key: The key to press for this button.
	-- @icon: An icon representing the file browser.
	-- @label: The label shown next to the icon.
	-- @action: The function to execute when the button is pressed.
	table.insert(opts.section.buttons.val, 1, dashboard.button(
		'b',
		' ' .. ' File Browser',
		telescope.extensions.file_browser.file_browser
	))

	-- Iterate over each button in the buttons section and apply highlights
	-- This ensures the buttons are styled according to the theme's appearance settings.
	for _, button in ipairs(opts.section.buttons.val) do
		-- Set the highlight group for button text
		button.opts.hl = 'AlphaButtons'
		-- Set the highlight group for button shortcuts
		button.opts.hl_shortcut = 'AlphaShortcut'
	end

	-- Update the header with the loaded ASCII art
	-- This sets the visual header of the dashboard.
	opts.section.header.val = header

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
