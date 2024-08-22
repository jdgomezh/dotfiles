-- First, loadn the original configuration
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

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

local header = load_header(_G.PATHS.env_root .. '/Conf/0.Mine/common/ascii/banner.txt')

-- Change the header of the dashboard
dashboard.section.header.val = header

-- Finally, set up the dashboard
alpha.setup(dashboard.opts)
