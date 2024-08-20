-- options.lua - Neovim general options configuration.
-- This file sets various Neovim options to enhance the user experience.

-- General Settings
-- These settings control the general behavior and appearance of Neovim.

-- Enable mouse support in all modes.
-- @option: mouse
-- @values: 'a' (Enable mouse in all modes), 'n' (Normal mode), 'v' (Visual mode), 'i' (Insert mode), 'c' (Command-line mode)
-- @impact: Allows using the mouse to navigate, select text, resize windows, etc.
vim.opt.mouse = 'a'

-- Show the cursor position all the time in the status line.
-- @option: ruler
-- @values: true (Enable), false (Disable)
-- @impact: Displays the current cursor position (line and column) in the status line, which can be helpful for navigation and editing.
vim.opt.ruler = true

-- Display line numbers in the gutter.
-- @option: number
-- @values: true (Enable), false (Disable)
-- @impact: Shows line numbers, useful for debugging and navigation.
vim.opt.number = true

-- Display the command being typed in the last line of the screen.
-- @option: showcmd
-- @values: true (Enable), false (Disable)
-- @impact: Helps in tracking partially typed commands, improving the command-line editing experience.
vim.opt.showcmd = true

-- Always display the status line.
-- @option: laststatus
-- @values: 0 (Never), 1 (Only if there are multiple windows), 2 (Always)
-- @impact: The status line provides useful information about the current buffer, mode, etc. Having it always visible can enhance productivity.
vim.opt.laststatus = 2

-- Set the minimal number of columns for the line number.
-- @option: numberwidth
-- @values: Integer (number of columns)
-- @impact: Adjusts the width of the gutter used for line numbers, which can affect the alignment of text.
vim.opt.numberwidth = 1

-- Display the current mode (e.g., -- INSERT --).
-- @option: showmode
-- @values: true (Enable), false (Disable)
-- @impact: Indicates the current mode (Normal, Insert, Visual, etc.), useful for understanding Neovim's state.
vim.opt.showmode = true

-- Highlight matching brackets.
-- @option: showmatch
-- @values: true (Enable), false (Disable)
-- @impact: Makes it easier to see matching brackets, parentheses, and braces, aiding in code readability and error detection.
vim.opt.showmatch = true

-- Highlight the current line.
-- @option: cursorline
-- @values: true (Enable), false (Disable)
-- @impact: Highlights the line where the cursor is, improving visibility and focus during editing.
vim.opt.cursorline = true

-- Use UTF-8 encoding for files.
-- @option: encoding
-- @values: 'utf-8' (UTF-8 encoding), other valid encodings
-- @impact: Ensures that files are read and written in UTF-8 encoding, supporting a wide range of characters and symbols.
vim.opt.encoding = 'utf-8'

-- Enable true color support.
-- @option: termguicolors
-- @values: true (Enable), false (Disable)
-- @impact: Allows Neovim to use a full range of colors, enhancing the appearance of themes and syntax highlighting.
vim.opt.termguicolors = true

-- Use the system clipboard.
-- @option: clipboard
-- @values: 'unnamedplus' (Use the system clipboard), other values (refer to Neovim documentation)
-- @impact: Enables seamless copy-pasting between Neovim and other applications.
vim.opt.clipboard = 'unnamedplus'

-- Show line numbers relative to the current line.
-- @option: relativenumber
-- @values: true (Enable), false (Disable)
-- @impact: Displays line numbers relative to the current line, which can make certain navigation commands more intuitive.
vim.opt.relativenumber = true

-- Configure options for completion.
-- @option: completeopt
-- @values: Comma-separated list (e.g., 'menuone,noselect')
--   - 'menuone': Use the popup menu also when there is only one match
--   - 'noselect': Do not select a match in the menu automatically
-- @impact: Controls the behavior of the completion menu, affecting how suggestions are displayed and selected.
vim.opt.completeopt = {
	'menuone',
	'noselect'
}

-- Enable background buffers.
-- @option: hidden
-- @values: true (Enable), false (Disable)
-- @impact: Allows buffers to be hidden without being saved, enabling smoother switching between files.
vim.opt.hidden = true

-- Highlight search results.
-- @option: hlsearch
-- @values: true (Enable), false (Disable)
-- @impact: Keeps search matches highlighted, making it easier to see all occurrences of the search term.
vim.opt.hlsearch = true

-- Incremental search.
-- @option: incsearch
-- @values: true (Enable), false (Disable)
-- @impact: Shows search results incrementally as you type, improving search efficiency.
vim.opt.incsearch = true

-- Enable smart case sensitivity in searches.
-- @option: smartcase
-- @values: true (Enable), false (Disable)
-- @impact: Makes searches case-sensitive only if the search pattern contains uppercase letters, providing a balance between case sensitivity and convenience.
vim.opt.smartcase = true

-- Ignore case in searches.
-- @option: ignorecase
-- @values: true (Enable), false (Disable)
-- @impact: Makes searches case-insensitive by default, which can simplify searching for text.
vim.opt.ignorecase = true

-- Set the time (in milliseconds) to wait before triggering the CursorHold event.
-- @option: updatetime
-- @values: Integer (milliseconds)
-- @impact: Affects the responsiveness of various plugins and features that depend on the CursorHold event. For example, plugins that show diagnostic messages or linting results can be more responsive with a lower `updatetime`.
vim.opt.updatetime = 300

-- Always show the sign column.
-- @option: signcolumn
-- @values: 'auto' (Automatically show/hide), 'yes' (Always show), 'no' (Never show), 'number' (Show with line numbers)
-- @impact: Keeps the sign column visible, which can prevent text shifting and improve the display of diagnostics and version control signs.
vim.opt.signcolumn = "yes:1"

-- Tab and Indentation Settings
-- These settings control how tabs and indentation are handled in Neovim.

-- Use tabs instead of spaces, and set tab width to 4 spaces.
-- @option: expandtab
-- @values: true (Convert tabs to spaces), false (Use tabs)
-- @impact: Controls whether to use tabs or spaces for indentation.
vim.opt.expandtab = false

-- Set the number of spaces a tab counts for.
-- @option: tabstop
-- @values: Integer (number of spaces per tab)
-- @impact: Affects the display of tabs in files.
vim.opt.tabstop = 4

-- Set the number of spaces for auto-indentation.
-- @option: shiftwidth
-- @values: Integer (number of spaces for auto-indent)
-- @impact: Controls the width of an indentation. It usually matches tabstop.
vim.opt.shiftwidth = 4

-- Set the number of spaces for editing operations like inserting a tab.
-- @option: softtabstop
-- @values: Integer (number of spaces for editing operations)
-- @impact: Makes editing operations (like inserting a tab) use the defined number of spaces.
vim.opt.softtabstop = 4

vim.g.python3_host_prog = "pip"

vim.g.mason_yarn_install_cmd = "yarn global add"

vim.g.mason_node_install_cmd = "yarn global add"


-- Enable syntax highlighting.
-- @cmd: syntax enable
-- @impact: Turns on syntax highlighting based on the file type, improving code readability and navigation.
vim.cmd([[syntax enable]])

-- Enable filetype detection.
-- @cmd: filetype plugin indent on
-- @impact: Enables filetype detection, which allows Neovim to recognize the type of file being edited and apply the appropriate settings and plugins.
vim.cmd([[filetype plugin indent on]])
