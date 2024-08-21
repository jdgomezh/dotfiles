-- toggleterm.lua - Configuration for nvim-toggleterm plugin with LazyVim integration.
-- This file sets up the terminal integration for Neovim, replacing LazyTerm with ToggleTerm.
-- ToggleTerm allows for a more flexible and customizable terminal experience in Neovim.

-- Define the main configuration table for the plugin
-- @plugin: Table - The main table that holds the plugin configuration.
local plugin = {}

-- Specify the plugin repository
-- @plugin[1]: String - The repository of the plugin to be installed.
-- 'akinsho/toggleterm.nvim': A Neovim plugin that provides a flexible terminal management experience.
plugin[1] = 'akinsho/toggleterm.nvim'

-- Function to configure the plugin
-- This function sets up default options for ToggleTerm.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param opts: Table - A table containing the options for configuring toggleterm.nvim.
plugin.opts = function(_, opts)
	-- Ensure that pre-existing configurations in opts are preserved
	-- This prevents overwriting user-defined configurations.
	opts.float_opts = opts.float_opts or {}
	opts.float_opts.highlights = opts.float_opts.highlights or {}

	-- Default configuration for ToggleTerm
	-- This section sets the size and behavior of the terminal windows.
	-- @size: Function - A function that returns the size of the terminal based on its direction.
	-- The size is adjusted depending on whether the terminal is horizontal, vertical, or floating.
	opts.size = opts.size or function(term)
		if term.direction == "horizontal" then
			-- Horizontal terminals take 15 lines of space.
			-- This is useful when working in a split view, giving sufficient space to the terminal without overwhelming the main buffer.
			return 15
		elseif term.direction == "vertical" then
			-- Vertical terminals take 40% of the window's width.
			-- This is particularly useful for wide monitors, allowing for a side-by-side view with the main buffer.
			return vim.o.columns * 0.4
		else
			-- Floating terminals default to a size of 20 lines.
			-- Floating terminals provide a distraction-free environment, overlaying the main buffer.
			return 20
		end
	end

	-- Set the key mapping to open ToggleTerm
	-- @open_mapping: String - The key combination to open the terminal.
	-- Using <c-\> (ctrl + \) is a convenient way to toggle the terminal from normal mode.
	opts.open_mapping = [[<leader>Ttt]]

	-- Hide line numbers in the terminal
	-- @hide_numbers: Boolean - Controls whether line numbers are hidden in terminal mode.
	-- true: Line numbers are hidden in terminal mode for better readability.
	-- false: Line numbers are visible in terminal mode.
	opts.hide_numbers = true

	-- Start terminal in insert mode
	-- @start_in_insert: Boolean - Controls whether the terminal starts in insert mode.
	-- true: Terminal starts in insert mode, allowing immediate input without an extra keystroke.
	-- false: Terminal starts in normal mode.
	opts.start_in_insert = true

	-- Enable insert mode mappings in the terminal
	-- @insert_mappings: Boolean - Controls whether insert mode key mappings are active in the terminal.
	-- true: Insert mode mappings are active, allowing consistent keybinding behavior across modes.
	-- false: Insert mode mappings are inactive in the terminal.
	opts.insert_mappings = true

	-- Set the direction of the terminal window
	-- @direction: String - Defines the direction in which the terminal window opens.
	-- Possible values:
	--   'vertical'   : Opens the terminal as a vertical split.
	--   'horizontal' : Opens the terminal as a horizontal split.
	--   'float'      : Opens the terminal as a floating window.
	--   'tab'        : Opens the terminal in a new tab.
	opts.direction = 'float'

	-- Configure options for floating terminal windows
	-- @float_opts: Table - A table containing the floating window options.
	-- Set the border style for floating terminals
	-- @border: String - Defines the border type for floating terminals.
	-- Possible values:
	--   'none'      : No border around the window.
	--   'single'    : Single line border.
	--   'double'    : Double line border.
	--   'rounded'   : Rounded corners for a smooth, modern look.
	--   'solid'     : A solid line border.
	--   'shadow'    : Adds a shadow effect to the window.
	opts.float_opts.border = 'curved'

	-- Set the transparency level of the floating terminal
	-- @winblend: Integer (0-100) - Controls the transparency of the floating terminal.
	-- 0: Fully opaque, no transparency.
	-- 100: Fully transparent, invisible terminal.
	opts.float_opts.winblend = 3

	-- Define custom highlight groups for the floating terminal
	-- @highlights: Table - A table containing custom highlight groups for floating terminal elements.
	-- @border: String - The highlight group for the terminal border.
	-- @background: String - The highlight group for the terminal background.
	opts.float_opts.highlights.border = "Normal"
	opts.float_opts.highlights.background = "Normal"

	-- Define a callback function to execute when the terminal is opened
	-- This function can be used to perform specific actions each time a terminal is opened.
	-- @param term: Terminal - The terminal object that was opened.
	opts.on_open = function(term)
		-- Set a global variable indicating that ToggleTerm is active.
		-- This can be useful for other plugins or configurations that depend on terminal state.
		vim.cmd("let $IS_TOGGLE_TERM = 1")
	end

	-- Define a callback function to execute when the terminal is closed
	-- This function can be used to perform specific actions each time a terminal is closed.
	-- @param term: Terminal - The terminal object that was closed.
	opts.on_close = function(term)
		-- Reset the global variable when ToggleTerm is inactive.
		-- This ensures that the global state accurately reflects whether a terminal is open.
		vim.cmd("let $IS_TOGGLE_TERM = 0")
	end

	-- Return the configured options
	-- @return: The modified opts table with updated configurations.
	return opts
end

-- Function to define key mappings
-- This function sets up key bindings for the plugin using the lazy.nvim keys field.
-- @param self: LazyPlugin - The plugin object that is being configured.
-- @param keys: Table - A table containing the existing key mappings.
plugin.keys = function(_, keys)
	-- Insert key mappings into the keys table

	-- Mapping for opening terminal in the root directory
	-- @<leader>Ttt: String - Key mapping to open a terminal with ToggleTerm.
	-- <cmd>ToggleTerm<CR>: Command to open the terminal.
	-- @desc: String - Description of the key mapping for the command palette.
	table.insert(keys, {
		'<leader>Ttt',
		'<cmd>ToggleTerm<CR>',
		desc = 'Toggle Terminal',
	})

	-- Return the modified keys table
	-- @return: Table - The updated keys table with new key mappings.
	return keys
end

-- Return the complete configuration table
-- This is required by lazy.nvim to properly configure and load the plugin.
-- @return: Table - The plugin configuration to be loaded by lazy.nvim.
return plugin
