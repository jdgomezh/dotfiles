-- wezterm.lua - Comprehensive Configuration for WezTerm
-- This file meticulously sets various WezTerm options to enhance user experience.
-- Each configuration option is extensively documented for clarity and maintainability.
-- We use tabs of size 4 for indentation instead of spaces.

-- Import WezTerm API
-- This allows us to configure WezTerm using its provided functions and options.
local wezterm = require 'wezterm'

-- Main configuration table
-- This table contains all the configuration options for WezTerm.
local config = {}

-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- FONT CONFIGURATION
-- ==================================================================================================================================== #
-- Set the font with fallback options.
-- The fallback options ensure that if one font is unavailable, another can be used.
-- @option: font_with_fallback
-- @values: Array of font objects
--   - family: The font family name (string)
--   - harfbuzz_features: Features for advanced text shaping (e.g., calt, clig, liga) (array of strings)
-- @impact: Enhances text rendering by providing alternative fonts if the primary font is not available.
config.font = wezterm.font_with_fallback {
	'JetBrains Mono',
	'Victor Mono',
	'Fira Code',
	'Iosevka Term',
	'Source Code Pro',
	'Font Awesome 5 Free',
	'PowerlineSymbols',
	'MesloLGS NF',
	'Noto Color Emoji',
}

-- Set the font size.
-- @option: font_size
-- @values: Number (font size in points)
-- @impact: Adjusts the size of the text displayed in the terminal.
config.font_size = 11.0
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- LINE HEIGHT CONFIGURATION
-- ==================================================================================================================================== #
-- Set the line height.
-- @option: line_height
-- @values: Number (line height as a multiplier, e.g., 1.0 for normal height)
-- @impact: Controls the vertical space between lines of text.
config.line_height = 1.0
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- SCROLL BAR CONFIGURATION
-- ==================================================================================================================================== #
-- Enable or disable the scroll bar.
-- @option: enable_scroll_bar
-- @values: true (Enable), false (Disable)
-- @impact: Determines whether a scroll bar is visible in the terminal window.
config.enable_scroll_bar = true
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- CELL DIMENSIONS CONFIGURATION
-- ==================================================================================================================================== #
-- Set the height of the cells.
-- @option: cell_height
-- @values: Number (cell height as a multiplier, e.g., 1.0 for normal height)
-- @impact: Adjusts the height of each cell in the terminal grid.
--config.cell_height = 1.0

-- Set the width of the cells.
-- @option: cell_width
-- @values: Number (cell width as a multiplier, e.g., 1.0 for normal width)
-- @impact: Adjusts the width of each cell in the terminal grid.
config.cell_width = 1.0
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- COLOR SCHEME CONFIGURATION
-- ==================================================================================================================================== #
-- Set the color scheme.
-- @option: color_scheme
-- @values: String (name of the color scheme, e.g., 'Gruvbox Dark', 'Solarized Light')
-- @impact: Changes the color palette used for text and background in the terminal.
config.color_scheme = 'Monokai Pro (Gogh)'

-- Define custom colors for the terminal.
-- @option: colors
-- @values: Table of color settings
--   - cursor_bg: Background color of the cursor (hex color code)
--   - cursor_fg: Foreground color of the cursor (hex color code)
--   - cursor_border: Border color of the cursor (hex color code)
--   - selection_fg: Foreground color of selected text (hex color code)
--   - selection_bg: Background color of selected text (hex color code)
--   - scrollbar_thumb: Color of the scrollbar thumb (hex color code)
--   - background: Background color of the terminal (hex color code)
--   - foreground: Foreground color of the terminal text (hex color code)
--   - ansi: Array of ANSI colors (8 colors, hex color codes)
--   - brights: Array of bright ANSI colors (8 colors, hex color codes)
-- @impact: Sets custom colors for various elements in the terminal, providing a personalized look and feel.
-- config.colors = {
-- 	foreground = '#C0CAF5',
-- 	background = '#1A1B26',
-- 	cursor_bg = '#C0CAF5',
-- 	cursor_fg = '#1A1B26',
-- 	cursor_border = '#C0CAF5',
-- 	selection_fg = '#C0CAF5',
-- 	selection_bg = '#283457',
-- 	scrollbar_thumb = '#292E42',
-- 	split = '#7AA2F7',
-- 	compose_cursor = '#FF9E64',
-- 	ansi = {'#15161E', '#F7768E', '#9ECE6A', '#E0AF68', '#7AA2F7', '#BB9AF7', '#7DCFFF', '#A9B1D6'},
-- 	brights = {'#414868', '#F7768E', '#9ECE6A', '#E0AF68', '#7AA2F7', '#BB9AF7', '#7DCFFF', '#C0CAF5'},
-- 	tab_bar = {
-- 		inactive_tab_edge = '#16161E',
-- 		background = '#1A1B26',
-- 		active_tab = {
-- 			fg_color = '#16161E',
-- 			bg_color = '#7AA2F7',
-- 		},
-- 		inactive_tab = {
-- 			fg_color = '#545C7E',
-- 			bg_color = '#292E42',
-- 		},
-- 		inactive_tab_hover = {
-- 			fg_color = '#7AA2F7',
-- 			bg_color = '#292E42',
-- 			-- intensity = 'Bold',
-- 		},
-- 		new_tab_hover = {
-- 			fg_color = '#7AA2F7',
-- 			bg_color = '#1A1B26',
-- 			intensity = 'Bold',
-- 		},
-- 		new_tab = {
-- 			fg_color = '#7AA2F7',
-- 			bg_color = '#1A1B26',
-- 		},
-- 	},
-- }
config.colors = {
	foreground = '#C5C8C6',  -- Color principal del texto
	background = '#1D1F21',  -- Color de fondo
	cursor_bg = '#AEAFAD',   -- Color de fondo del cursor
	cursor_fg = '#1D1F21',   -- Color de texto del cursor
	cursor_border = '#AEAFAD', -- Color del borde del cursor
	selection_fg = '#1D1F21', -- Color de texto seleccionado
	selection_bg = '#373B41', -- Color de fondo del texto seleccionado
	scrollbar_thumb = '#282A2E', -- Color de la barra de desplazamiento
	split = '#5F819D',       -- Color de la línea divisoria entre paneles
	compose_cursor = '#FFCC66', -- Color del cursor de composición

	-- Colores ANSI
	ansi = {
		'#1D1F21', -- Negro
		'#CC6666', -- Rojo
		'#B5BD68', -- Verde
		'#F0C674', -- Amarillo
		'#81A2BE', -- Azul
		'#B294BB', -- Magenta
		'#8ABEB7', -- Cian
		'#C5C8C6', -- Blanco
	},
	
	-- Colores ANSI brillantes
	brights = {
		'#666666', -- Negro brillante
		'#D54E53', -- Rojo brillante
		'#B9CA4A', -- Verde brillante
		'#E7C547', -- Amarillo brillante
		'#7AA6DA', -- Azul brillante
		'#C397D8', -- Magenta brillante
		'#70C0B1', -- Cian brillante
		'#EAEAEA', -- Blanco brillante
	},

	-- Colores de la barra de pestañas
	tab_bar = {
		background = '#1D1F21', -- Fondo de la barra de pestañas
		active_tab = {
			bg_color = '#282A2E', -- Fondo de la pestaña activa
			fg_color = '#C5C8C6', -- Texto de la pestaña activa
		},
		inactive_tab = {
			bg_color = '#373B41', -- Fondo de la pestaña inactiva
			fg_color = '#707880', -- Texto de la pestaña inactiva
		},
		inactive_tab_hover = {
			bg_color = '#282A2E', -- Fondo de la pestaña inactiva cuando se pasa el mouse
			fg_color = '#C5C8C6', -- Texto de la pestaña inactiva cuando se pasa el mouse
		},
		new_tab = {
			bg_color = '#1D1F21', -- Fondo del botón de nueva pestaña
			fg_color = '#C5C8C6', -- Texto del botón de nueva pestaña
		},
		new_tab_hover = {
			bg_color = '#282A2E', -- Fondo del botón de nueva pestaña cuando se pasa el mouse
			fg_color = '#C5C8C6', -- Texto del botón de nueva pestaña cuando se pasa el mouse
			intensity = 'Bold',   -- Intensidad del texto del botón de nueva pestaña cuando se pasa el mouse
		},
	},
}
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- WAYLAND COMPATIBILITY
-- ==================================================================================================================================== #
-- Enable or disable Wayland support.
-- @option: enable_wayland
-- @values: true (Enable), false (Disable)
-- @impact: Improves compatibility and performance on X11 by disabling Wayland.
config.enable_wayland = false
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- WINDOW SIZE ADJUSTMENT
-- ==================================================================================================================================== #
-- Adjust window size when changing font size.
-- @option: adjust_window_size_when_changing_font_size
-- @values: true (Enable), false (Disable)
-- @impact: Controls whether the window size should change automatically when the font size is adjusted.
config.adjust_window_size_when_changing_font_size = false
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- TAB BAR CONFIGURATION
-- ==================================================================================================================================== #
-- Use the fancy tab bar.
-- @option: use_fancy_tab_bar
-- @values: true (Enable), false (Disable)
-- @impact: Disables the fancy tab bar to improve performance.
config.use_fancy_tab_bar = false

-- Enable or disable the tab bar.
-- @option: enable_tab_bar
-- @values: true (Enable), false (Disable)
-- @impact: Determines whether the tab bar is visible.
config.enable_tab_bar = true

-- Hide the tab bar if there is only one tab.
-- @option: hide_tab_bar_if_only_one_tab
-- @values: true (Enable), false (Disable)
-- @impact: Hides the tab bar when only one tab is open, providing a cleaner interface.
config.hide_tab_bar_if_only_one_tab = true
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- WINDOW TRANSPARENCY
-- ==================================================================================================================================== #
-- Set the window background opacity.
-- @option: window_background_opacity
-- @values: Number (opacity value between 0.0 and 1.0, where 1.0 is fully opaque)
-- @impact: Makes the window background semi-transparent for better visual appearance.
config.window_background_opacity = 0.95
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- TEXT BLINK RATE CONFIGURATION
-- ==================================================================================================================================== #
-- Set the text blink rate.
-- @option: text_blink_rate
-- @values: Number (blink rate in milliseconds, 0 to disable blinking)
-- @impact: Disables text blinking if set to 0, otherwise sets the blink rate.
config.text_blink_rate = 0
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- CURSOR BLINK RATE CONFIGURATION
-- ==================================================================================================================================== #
-- Set the cursor blink rate.
-- @option: cursor_blink_rate
-- @values: Number (blink rate in milliseconds, 0 to disable blinking)
-- @impact: Sets the blink rate for the cursor. A value of 0 disables cursor blinking.
config.cursor_blink_rate = 400
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- IME (INPUT METHOD EDITOR) CONFIGURATION
-- ==================================================================================================================================== #
-- Enable or disable the IME.
-- @option: use_ime
-- @values: true (Enable), false (Disable)
-- @impact: Disables the IME if it is not used, improving performance and preventing unintended input behavior.
config.use_ime = false
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- CURSOR STYLE CONFIGURATION
-- ==================================================================================================================================== #
-- Set the default cursor style.
-- @option: default_cursor_style
-- @values: String (e.g., 'SteadyBlock', 'BlinkingBar', 'SteadyBar')
-- @impact: Defines the appearance of the cursor in the terminal. For instance, a vertical bar cursor improves visual clarity.
config.default_cursor_style = 'BlinkingBar'
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- FONT RENDERING CONFIGURATION
-- ==================================================================================================================================== #
-- Set the freetype load target.
-- @option: freetype_load_target
-- @values: String (e.g., 'Normal', 'Light', 'Mono', 'Horizontal')
-- @impact: Controls font rendering quality and performance. 'Normal' is a balanced choice.
config.freetype_load_target = 'Normal'
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- GLYPH MISSING WARNING
-- ==================================================================================================================================== #
-- Warn about missing glyphs.
-- @option: warn_about_missing_glyphs
-- @values: true (Enable), false (Disable)
-- @impact: Enables warnings for missing glyphs, aiding in debugging font issues.
config.warn_about_missing_glyphs = true
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- BOLD TEXT CONFIGURATION
-- ==================================================================================================================================== #
-- Brighten colors for bold text.
-- @option: bold_brightens_ansi_colors
-- @values: true (Enable), false (Disable)
-- @impact: Does not increase brightness for bold text, keeping the color scheme consistent.
config.bold_brightens_ansi_colors = false
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- TERMINAL TYPE CONFIGURATION
-- ==================================================================================================================================== #
-- Set the terminal type.
-- @option: term
-- @values: String (e.g., 'xterm-256color', 'wezterm')
-- @impact: Defines the terminal type for compatibility with various applications and systems.
config.term = 'xterm-256color'
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- SCROLLBACK BUFFER CONFIGURATION
-- ==================================================================================================================================== #
-- Set the number of scrollback lines.
-- @option: scrollback_lines
-- @values: Integer (number of lines)
-- @impact: Increases the number of lines kept in the scrollback buffer, allowing more text to be reviewed.
config.scrollback_lines = 3500
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- HARFBUZZ FEATURES CONFIGURATION
-- ==================================================================================================================================== #
-- Set HarfBuzz features.
-- @option: harfbuzz_features
-- @values: Array of features (e.g., 'calt=1', 'clig=1', 'liga=1')
-- @impact: Enables advanced text shaping features, improving text rendering quality.
config.harfbuzz_features = {'calt=1', 'clig=1', 'liga=1'}
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- WINDOW PADDING CONFIGURATION
-- ==================================================================================================================================== #
-- Set the padding for the window.
-- @option: window_padding
-- @values: Object with left, right, top, bottom properties (values in pixels)
-- @impact: Removes or adjusts padding around the terminal window, providing a cleaner look.
config.window_padding = {
	left = 1,
	right = 0,
	top = 1,
	bottom = 1,
}
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- KEY BINDINGS CONFIGURATION
-- ==================================================================================================================================== #
-- Key bindings to enhance productivity and comfort.
-- @option: keys
-- @values: Array of key binding objects
--   - key: The key to bind (string)
--   - mods: Modifier keys (e.g., 'CTRL', 'ALT') (string)
--   - action: Action to perform (e.g., 'ActivateCopyMode', 'Paste', 'SpawnTab') (WezTerm action)
-- @impact: Provides custom key bindings for various actions, improving workflow efficiency.
config.keys = {
	-- Copy mode with CTRL + Shift + C
	{ key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
	-- Paste with CTRL + Shift + V
	{ key = 'V', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
	-- Open a new tab with CTRL + T
	{ key = 'T', mods = 'CTRL', action = wezterm.action.SpawnTab 'DefaultDomain' },
	-- Close the current tab with CTRL + W
	{ key = 'W', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true } },
	-- Switch to the next tab with CTRL + Tab
	{ key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
	-- Switch to the previous tab with CTRL + Shift + Tab
	{ key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
	-- Split the window vertically with CTRL + Shift + D
	{ key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
	-- Split the window horizontally with CTRL + D
	{ key = 'D', mods = 'CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	-- Toggle full screen with F11
	{ key = 'F11', action = wezterm.action.ToggleFullScreen },
	-- Increase font size with CTRL + '+'
	{ key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
	-- Decrease font size with CTRL + '-'
	{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
	-- Reset font size with CTRL + 0
	{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
	-- Reload configuration with CTRL + Shift + R
	{ key = 'R', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
}
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- WSL CONFIGURATION
-- ==================================================================================================================================== #
-- Function to detect if running on Windows
-- @option: is_windows
-- @return: Boolean indicating if running on Windows
-- @impact: Used to conditionally apply settings based on the operating system.
local function is_windows()
	wezterm.log_info('Target triple: ' .. wezterm.target_triple)
	return wezterm.target_triple == 'x86_64-pc-windows-msvc'
end

-- Function to check if WSL is installed and Debian is available
-- @option: has_wsl_debian
-- @return: Boolean indicating if WSL with Debian is available
-- @impact: Ensures that default_prog is set only if Debian is available in WSL on Windows.
local function has_wsl_debian()
	if not is_windows() then
		return false
	end

	local success, stdout, stderr = wezterm.run_child_process({'wsl.exe', '-l', '-q'})
	if not success then
		return false
	end

	for line in string.gmatch(stdout, '([^\n]+)') do
		line = line:gsub('[^%w%-_]', ''):lower()
		if line:match('debian') then
			return true
		end
	end

	return false
end

-- Set default program to launch in WezTerm if running on Windows with WSL and Debian
-- @option: default_prog
-- @values: Array of strings (program and arguments)
-- @impact: Configures WezTerm to start WSL with Debian by default if available.
if has_wsl_debian() then
	config.default_prog = { 'wsl.exe', '-d', 'Debian' }
end
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


-- //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
-- RETURN CONFIGURATION
-- ==================================================================================================================================== #
-- Return the complete configuration table
-- @return: Table containing all configuration options
return config
-- ==================================================================================================================================== #
-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
