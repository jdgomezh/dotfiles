-- dashboard-nvim.lua - Configuration for nvimdev/dashboard-nvim plugin.
-- This file sets up Dashboard, a highly customizable start screen for Neovim.
-- Dashboard provides a flexible interface for displaying custom headers, footers, and shortcuts for frequently used commands.

-- Main configuration table
-- This table contains all the configuration options for Dashboard.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Define the Dashboard plugin for lazy.nvim
-- @plugin: nvimdev/dashboard-nvim - A customizable start screen for Neovim.
plugin[1] = 'nvimdev/dashboard-nvim'

-- Load header from external file
-- The header is loaded from a file to allow easy updates without modifying the Lua configuration.
-- @file_path: String - Path to the file containing the ASCII art.
-- @return: String - The contents of the file.
local function load_header(file_path)
	local header_lines = {}
	local file = io.open(file_path, "r")
	if file then
		for line in file:lines() do
			table.insert(header_lines, line)
		end
		file:close()
	end
	table.insert(header_lines, "")  

	return table.concat(header_lines, '\n')
end

-- ASCII art header for the Dashboard
-- The header will be displayed at the top of the Dashboard when Neovim starts.
local header = load_header(_G.PATHS.env_root .. '/Conf/0.Mine/common/ascii/banner.txt')

-- Function to format text by removing leading and trailing whitespace,
-- collapsing multiple spaces into one, and padding the text to a fixed length.
-- @param text: The text to be formatted.
-- @return: The formatted text with padding.
local function pad(text)
	text = text:match('^%s*(.-)%s*$') -- Remove leading and trailing whitespace.
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
	return text .. ' ' .. string.rep('.', padding)
end

-- Configuration function for the Dashboard plugin.
-- This function sets up the Dashboard with custom options, including formatting
-- existing items and adding new items to the center section.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
plugin.config = function(_, opts)
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
	for _, item in ipairs(opts.config.center) do
		if item.desc then
			item.desc = pad(item.desc)
		end
	end

	-- Insert a new item for the file browser into the center section.
	table.insert(opts.config.center, 1, {
		key = 'b',                           -- Keybinding without brackets
		icon = ' ',                         -- Icon with appropriate padding for alignment
		desc = pad('File Browser'),          -- Description padded to match the others
		action = 'Telescope file_browser',   -- Action to execute
	})

	-- Apply the configuration options to the dashboard setup.
	dashboard.setup(opts)

	-- Create an autocommand to set local buffer options for the dashboard filetype.
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'dashboard',
		callback = function()
			vim.opt_local.tabstop = 4         -- Number of spaces for a tab.
			vim.opt_local.shiftwidth = 4      -- Number of spaces for autoindent.
			vim.opt_local.softtabstop = 4     -- Number of spaces for tab and backspace.
			vim.opt_local.expandtab = false   -- Use tabs instead of spaces.
		end,
	})
end

-- Return the complete configuration table.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
