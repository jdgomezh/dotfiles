-- Load required modules
local lualine = require('lualine')

local config = {}

config.options = {}
config.sections = {}
config.options.section_separators = {}
config.options.component_separators = {}

-- Theme for lualine
-- @option theme: String - The colorscheme to be applied to lualine.
--   This can be any valid lualine theme name, or one provided by the selected theme.
config.options.theme = _G.theme_manager.get_lualine_theme()

-- Enable or disable icons in the statusline
-- @option icons_enabled: Boolean - true to enable icons, false to disable.
config.options.icons_enabled = true

-- Global status
-- @option globalstatus: Boolean - true to display the statusline in all windows, false to limit it to active windows.
config.options.globalstatus = true

-- Component separators
-- @option component_separators: Table - Defines the separators between individual components in lualine.
--   The separators can be any valid string, including special characters or emojis.
-- @left: String - Separator for the left side of a component.
--   This could be a character like '|' or an icon.
-- @right: String - Separator for the right side of a component.
--   This could be a character like '|' or an icon.
config.options.component_separators.left = ''
config.options.component_separators.right = ''

-- Section separators
-- @option section_separators: Table - Defines the separators between different sections in lualine.
--   This helps visually distinguish different parts of the statusline.
-- @left: String - Separator for the left side of a section.
--   Common options include '', '', or a simple '|' character.
-- @right: String - Separator for the right side of a section.
--   Common options include '', '', or a simple '|' character.
config.options.section_separators.left = ''
config.options.section_separators.right = ''

-- Sections configuration
-- This section defines what information is displayed in each part of the status line.
-- Each section (lualine_a, lualine_b, etc.) corresponds to a different area of the status line.

-- lualine_a section
-- @section lualine_a: Table - Displays the current mode (e.g., NORMAL, INSERT).
--   This is often shown in the left-most part of the status line.
config.sections.lualine_a = {'mode'}

-- lualine_b section
-- @section lualine_b: Table - Displays Git branch, diff status, and diagnostics information.
--   This section is useful for showing version control status and any issues in the code.
-- @branch: String - The name of the current Git branch.
-- @diff: Table - Shows the number of added, modified, and removed lines in the Git diff.
-- @diagnostics: Table - Displays the number of errors, warnings, and other diagnostics info.
config.sections.lualine_b = {'branch', 'diff', 'diagnostics'}

-- lualine_c section
-- @section lualine_c: Table - Displays the name of the current file.
--   This section often shows the file path or just the filename.
--   It helps keep track of the file currently being edited.
config.sections.lualine_c = {'filename'}

-- lualine_x section
-- @section lualine_x: Table - Displays various file information and lazy.nvim status updates.
--   This section can show different pieces of information depending on the user's preferences.
-- @has_updates: Function - Displays if there are updates available for lazy.nvim.
--   Shows a simple indicator if any updates are pending.
-- @file_encoding: Function - Displays the file encoding in uppercase (e.g., UTF-8).
--   Useful for ensuring the file is saved in the correct encoding format.
-- @file_format: Function - Displays the file format, such as 'LF' for Unix or 'CRLF' for Windows.
--   Indicates the line ending format used in the file.
config.sections.lualine_x = {
	{
		require('lazy.status').has_updates,
		cond = require('lazy.status').has_updates,
	},
	{
		function()
			return (vim.bo.fileencoding or 'none'):upper()
		end,
	},
	{
		function()
			local format = vim.bo.fileformat
			return format == 'unix' and 'LF' or 'CRLF'
		end,
	},
}

-- lualine_y section
-- @section lualine_y: Table - Displays indentation type (Spaces or Tabs) and shift width.
--   This section shows whether the file is indented with spaces or tabs.
-- @expandtab: Function - Displays 'SPC' if spaces are used for indentation, 'TAB' if tabs are used.
--   Helps identify if the file follows the correct indentation style.
-- @shiftwidth: Function - Displays the current shift width, e.g., 'SW:2'.
--   Indicates how many spaces a tab or indent level represents.
config.sections.lualine_y = {
	{
		function()
			return vim.bo.expandtab and 'SPC' or 'TAB'
		end,
	},
	{
		function()
			return 'SW:' .. vim.bo.shiftwidth
		end,
	},
}

-- lualine_z section
-- @section lualine_z: Table - Displays the file type (e.g., Lua, Python).
--   This section is usually at the far right of the status line.
--   It helps identify the file type being edited, which can influence syntax highlighting and other editor behaviors.
config.sections.lualine_z = {'filetype'}

-- Setup
lualine.setup(config)
