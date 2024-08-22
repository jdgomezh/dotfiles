-- theme_manager.lua - Theme management module for Neovim.
-- This module is responsible for managing theme selection and configuration loading in Neovim.
-- It allows for dynamic theme switching and centralized theme management.
local ThemeManager = {}

-- Available Themes Configuration
-- @constant available_themes: Table - Contains configuration details for each supported theme.
--   Each theme entry consists of:
--     plugin: String - The plugin repository that provides the theme.
--     color_scheme: String - The colorscheme command to be executed.
--     lualine_theme: String - The theme to be used for the lualine status line plugin.
local available_themes = {
	catppuccin = {
		plugin = 'catppuccin/nvim',
		lualine_theme = 'catppuccin'
	},
	tokyonight = {
		plugin = 'folke/tokyonight.nvim',
		lualine_theme = 'tokyonight'
	},
	monokai = {
		plugin = 'tanvirtin/monokai.nvim',
		lualine_theme = 'gruvbox_dark'
	},
	gruvbox = {
		plugin = 'ellisonleao/gruvbox.nvim',
		lualine_theme = 'gruvbox_dark'
	},
}

-- Load Theme Configuration
-- @function load_theme
-- @param theme_name: String - The name of the theme to be loaded.
-- @return: Table - The configuration table for the selected theme.
-- @error: Raises an error if the theme is not found in the available_themes table.
local function load_theme(theme_name)
	local theme_config = available_themes[theme_name]
	if not theme_config then
		error('Theme not found: ' .. theme_name)
	end
	return theme_config
end

-- Initialize the Theme Manager
-- @function ThemeManager.init
-- @param theme_name: String - The name of the theme to be initialized.
-- @return: Table - A table with methods to retrieve theme configurations.
--   Methods:
--     get_theme_config_file: Returns the configuration file associated with the selected theme.
--     get_plugin_theme: Returns the plugin associated with the selected theme.
--     get_lualine_theme: Returns the lualine theme associated with the selected theme.
function ThemeManager.init(theme_name)
	local theme_config = load_theme(theme_name)

	return {
		get_theme_config_file = function()
			return 'themes.' .. theme_name
		end,
		get_plugin_theme = function()
			return theme_config.plugin
		end,
		get_lualine_theme = function()
			return theme_config.lualine_theme
		end
	}
end

-- Return the ThemeManager
-- @return: The ThemeManager table with the init method.
return ThemeManager
