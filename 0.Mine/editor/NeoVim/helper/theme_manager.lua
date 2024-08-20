-- theme_manager.lua - Theme management module for Neovim.

local ThemeData = {}
local ThemeManager = {}
local available_themes = {
	tokyonight = {
		plugin = 'folke/tokyonight.nvim',
        color_scheme = 'tokyonight',
		lualine_theme = 'tokyonight'
	},
	monokai = {
		plugin = 'tanvirtin/monokai.nvim',
        color_scheme = 'monokai',
		lualine_theme = 'gruvbox_dark'
	},
	gruvbox = {
		plugin = 'ellisonleao/gruvbox.nvim',
        color_scheme = 'gruvbox',
		lualine_theme = 'gruvbox_dark'
	}
}

function ThemeManager.get_theme_config_file()
	return ThemeData.theme_config_file
end

function ThemeManager.get_plugin_theme()
    return ThemeData.plugin_theme
end

function ThemeManager.get_lualine_theme()
    return ThemeData.lualine_theme
end

function setup (theme_name)
	local selected_theme_config = available_themes[theme_name]
	if not selected_theme_config then
		error('Theme not found: ' .. theme_name)
	end

	ThemeData.plugin_theme = selected_theme_config.plugin
	ThemeData.lualine_theme = selected_theme_config.lualine_theme

	ThemeData.theme_config_file = 'theme.' .. selected_theme_config.color_scheme

    return ThemeManager
end

return setup
