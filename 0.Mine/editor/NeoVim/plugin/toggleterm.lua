-- toggleterm.lua - Configuration for akinsho/toggleterm.nvim plugin.
-- This file sets up ToggleTerm, a plugin that provides a toggleable terminal for Neovim.
-- ToggleTerm allows users to open terminals within Neovim, providing a flexible interface for running shell commands and managing terminal sessions.

-- Main configuration table
-- This table contains all the configuration options for ToggleTerm.
-- It follows the structure expected by lazy.nvim plugin manager.
local plugin = {}

-- Plugin definition for lazy.nvim
-- @plugin: akinsho/toggleterm.nvim - A plugin to provide a toggleable terminal within Neovim.
-- This plugin helps in managing terminal sessions within Neovim, allowing users to toggle terminals on and off as needed.
plugin[1] = 'akinsho/toggleterm.nvim'

-- Configuration function for the ToggleTerm plugin.
-- This function sets up ToggleTerm with custom options, ensuring it integrates well with Neovim's settings.
-- @param PluginSpec: The specification of the plugin, detailing its name and dependencies.
-- @param opts: The options table to configure the plugin, containing user-defined settings.
-- The function modifies the options table to include the necessary settings for ToggleTerm.
plugin.config = function(PluginSpec, opts)
	-- Load the toggleterm module.
	-- @require: Require the toggleterm module for configuration.
	local toggleterm = require('toggleterm')

	-- Set default options if not already provided by the user.
	-- These options ensure the plugin behaves as expected with sensible defaults.
	-- @option: size
	-- @type: integer or function
	-- @default: 20
	-- @description: The size of the terminal window. Can be an integer or a function that returns an integer based on the terminal direction.
	opts.size = opts.size or function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		else
			return 20
		end
	end

	-- @option: open_mapping
	-- @type: string
	-- @default: [[<c-\>]]
	-- @description: Key mapping to open the terminal. The default is <C-\>, which means pressing the Control key and the backslash key together.
	opts.open_mapping = [[<c-\>]]

	-- @option: hide_numbers
	-- @type: boolean
	-- @default: true
	-- @description: Hide the number column in the terminal buffer.
	opts.hide_numbers = true

	-- @option: start_in_insert
	-- @type: boolean
	-- @default: true
	-- @description: Start the terminal in insert mode.
	opts.start_in_insert = true

	-- @option: insert_mappings
	-- @type: boolean
	-- @default: true
	-- @description: Whether or not to apply the open mapping in insert mode.
	opts.insert_mappings = true

	-- @option: direction
	-- @type: string
	-- @default: 'horizontal'
	-- @description: The direction of the terminal (horizontal, vertical, tab, float).
	opts.direction = 'float'

	-- @option: shade_filetypes
	-- @type: table of strings
	-- @default: {}
	-- @description: Filetypes to not shade the terminal buffer.
	-- opts.shade_filetypes = opts.shade_filetypes or {}

	-- @option: shade_terminals
	-- @type: boolean
	-- @default: true
	-- @description: Shade the terminal background.
	-- opts.shade_terminals = opts.shade_terminals or true

	-- @option: shading_factor
	-- @type: integer
	-- @default: 2
	-- @description: The factor by which to shade the terminal background.
	-- opts.shading_factor = opts.shading_factor or 2

	-- @option: terminal_mappings
	-- @type: boolean
	-- @default: true
	-- @description: Whether or not to apply the open mapping in the opened terminals.
	-- opts.terminal_mappings = opts.terminal_mappings or true

	-- @option: persist_size
	-- @type: boolean
	-- @default: true
	-- @description: Persist the size of the terminal across sessions.
	-- opts.persist_size = opts.persist_size or true

	-- @option: close_on_exit
	-- @type: boolean
	-- @default: true
	-- @description: Close the terminal window when the process exits.
	opts.close_on_exit = opts.close_on_exit or true

	-- @option: shell
	-- @type: string
	-- @default: vim.o.shell
	-- @description: The shell to use for the terminal.
	opts.shell = vim.o.shell

	-- Options specific to floating terminals.
	opts.float_opts = opts.float_opts or {}

	-- Border style for floating terminal
	-- @option: border
	-- @values: String (e.g., 'single', 'double', 'shadow', 'curved', 'none')
	-- @impact: Sets the border style for the floating terminal window.
	opts.float_opts.border = 'curved'

	-- Window transparency level
	-- @option: winblend
	-- @values: Integer (0-100)
	-- @impact: Determines the transparency of the floating terminal window.
	opts.float_opts.winblend = 3

	-- Highlight groups for floating terminal borders and backgrounds.
	opts.float_opts.highlights = opts.float_opts.highlights or {}

	-- Border highlight group
	-- @option: border
	-- @values: String (e.g., "Normal", "HighlightGroupName")
	-- @impact: Sets the highlight group for the floating terminal border.
	opts.float_opts.highlights.border = "Normal"

	-- Background highlight group
	-- @option: background
	-- @values: String (e.g., "Normal", "HighlightGroupName")
	-- @impact: Sets the highlight group for the floating terminal background.
	opts.float_opts.highlights.background = "Normal"

	-- Callback function for terminal open event.
	opts.on_open = function(term)
		vim.cmd("let $IS_TOGGLE_TERM = 1")
	end

	-- Callback function for terminal close event.
	opts.on_close = function(term)
		vim.cmd("let $IS_TOGGLE_TERM = 0")
	end,

	-- Apply the configuration options to the toggleterm setup.
	-- @setup: Call the setup function with the provided options.
	toggleterm.setup(opts)

	-- Define key mappings for ToggleTerm functions
	local key_mappings = {
		-- Toggle terminal window
		-- @key: <Leader>ttt (Leader key, t, t, t)
		-- @mode: normal
		-- @action: ToggleTerm
		-- @description: Toggles the terminal window.
		{ 'n', '<Leader>ttt', "<cmd>ToggleTerm<CR>", { noremap = true, silent = true } },
	}

	-- Apply key mappings
	for _, mapping in ipairs(key_mappings) do
		vim.api.nvim_set_keymap(unpack(mapping))
	end
end

-- Return the complete configuration table.
-- @return: Table containing all configuration options.
-- This table is required by lazy.nvim to properly configure and load the plugin.
return plugin
