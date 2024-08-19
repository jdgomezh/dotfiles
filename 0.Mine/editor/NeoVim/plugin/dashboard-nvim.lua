-- dashboard-nvim.lua - Configuration for nvimdev/dashboard-nvim plugin.
-- This file sets up Dashboard, a highly customizable start screen for Neovim.
-- Dashboard provides a flexible interface for displaying custom headers, footers, and shortcuts for frequently used commands.

-- Main configuration table
-- This table contains all the configuration options for Dashboard.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: nvimdev/dashboard-nvim - A customizable start screen for Neovim.
-- This plugin allows users to create a personalized start screen with various widgets and shortcuts.
plugin[1] = 'nvimdev/dashboard-nvim'

-- ASCII art header for the Dashboard
-- This header will be displayed at the top of the Dashboard when Neovim starts.
-- The header is defined as a string and split into lines for display purposes.
local header = [[
┌──────────────────────────────────────────────────────────────────┐
│         ██████\  ██\   ██\                 ██\                   │
│        ██  __██\ ██ | ██  |                ██ |                  │
│        ██ /  \__|██ |██  /  ██████\   ███████ | ██████\          │
│        ██ |████\ █████  /  ██  __██\ ██  __██ |██  __██\         │
│        ██ |\_██ |██  ██<   ██ /  ██ |██ /  ██ |██ /  ██ |        │
│        ██ |  ██ |██ |\██\  ██ |  ██ |██ |  ██ |██ |  ██ |        │
│        \██████  |██ | \██\ \██████  |\███████ |\██████  |        │
│         \______/ \__|  \__| \______/  \_______| \______/         │
└──────────────────────────────────────────────────────────────────┘


]]

-- Function to format text by removing leading and trailing whitespace,
-- collapsing multiple spaces into one, and padding the text to a fixed length.
-- @param text: The text to be formatted.
-- @return: The formatted text with padding.
-- This function ensures that descriptions are uniformly formatted and aligned.
local function pad(text)
	text = text:match('^%s*(.-)%s*$') -- Remove leading and trailing whitespace from the text.
	text = text:gsub('%s+', ' ') -- Replace multiple consecutive spaces with a single space.

	-- Define the fixed length for padding.
	local length = 55
	-- The text will be padded to this length.
	local padding = length - #text

	-- Truncate text if it exceeds the fixed length.
	if #text > length then
		return text:sub(1, length)
	end

	-- Pad the text with spaces and periods to the fixed length.
	-- Ensures uniform appearance of descriptions in the Dashboard.
	return text .. ' ' .. string.rep('.', padding)
end

-- Configuration function for the Dashboard plugin.
-- This function sets up the Dashboard with custom options, including formatting
-- existing items and adding new items to the center section.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include custom header and center section items.
plugin.config = function(PluginSpec, opts)
	-- Load the dashboard module.
	local dashboard = require('dashboard')

	-- Set the theme for the dashboard.
	opts.theme = 'doom'

	-- Set default options if not already provided by the user.
	opts.config = opts.config or {}

	-- Split the ASCII header into lines and assign it to the dashboard header.
	opts.config.header = vim.split(header, '\n')

	-- Ensure the center section is initialized if not already present.
	opts.config.center = opts.config.center or {}

	-- Format descriptions of existing items in the center section.
	-- Ensures that all descriptions have uniform padding.
	for _, item in ipairs(opts.config.center) do
		if item.desc then
			item.desc = pad(item.desc)
		end
	end

	-- Insert a new item for the file browser into the center section.
	-- The item includes a key binding, icon, description, and action.
	table.insert(opts.config.center, 1, {
		key = 'b',
		icon = ' ',
		desc = pad('File Browser'),
		action = 'Telescope file_browser',
	})

	-- Apply the configuration options to the dashboard setup.
	dashboard.setup(opts)

	-- Create an autocommand to set local buffer options for the dashboard filetype.
	-- Ensures consistent tab and indentation settings specific to the dashboard.
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'dashboard',
		callback = function()
			-- @tabstop: Number of spaces for a tab.
			vim.opt_local.tabstop = 4
			-- @shiftwidth: Number of spaces for autoindent.
			vim.opt_local.shiftwidth = 4
			-- @softtabstop: Number of spaces for tab and backspace.
			vim.opt_local.softtabstop = 4
			-- @expandtab: Set to false to use tabs instead of spaces.
			vim.opt_local.expandtab = false
		end,
	})
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
