#!/usr/bin/env pwsh
# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# UTILITY FUNCTIONS
# ==================================================================================================================================== #
# Define the log file path
$logFile = "~\ssh_log.txt"

# Function to log messages to a file
function Log-Message {
	param (
		[string]$message
	)
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	"$timestamp - $message" | Out-File -FilePath $logFile -Append
}

# Retrieves the command of the parent process.
# -------------------------------------------------------------------------------------------------------- #
# This function retrieves the command line used to start the parent process of the current PowerShell script.
# It first obtains the parent process ID (PID) of the current process, then retrieves the command line
# used to start that parent process.
# -------------------------------------------------------------------------------------------------------- #
function Get-ParentCommand {
	try {
		$currentPID = $PID

		while ($true) {
			if ($IsWindows) {
				$currentProcess = Get-CimInstance -Filter "ProcessId = $currentPID"
				if (-not $currentProcess.ParentProcessId) { throw "Parent process is null." }

				$parentPID = $currentProcess.ParentProcessId
				$parentProcess = Get-CimInstance -Filter "ProcessId = $parentPID"
			}
			else {
				$currentProcess = Get-Process -Id $currentPID
				if (-not $currentProcess.Parent.Id) { throw "Parent process is null." }

				$parentPID = $currentProcess.Parent.Id
				$parentProcess = Get-Process -Id $parentPID
			}

			Log-Message "Current command: Name => $($currentProcess.Name) | ProcessName => $($currentProcess.ProcessName) | CommandLine => $($currentProcess.CommandLine)"
			Log-Message "Parent command: Name => $($parentProcess.Name) | ProcessName => $($parentProcess.ProcessName) | CommandLine => $($parentProcess.CommandLine)"
			$parentCmd = $parentProcess.CommandLine

			if ($parentProcess.ProcessName -eq 'ssh' -or $parentProcess.ProcessName -eq 'ssh.exe') {
				$sshCmd = $parentCmd
				break
			}

			$currentPID = $parentPid
		}

		Log-Message "SSH Command: $sshCmd"

		return $sshCmd
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}

# Extracts details from the command string.
# -------------------------------------------------------------------------------------------------------- #
# This function extracts user, host, port, and path details from a given command string.
# It uses regular expressions to parse the command string and extracts the necessary details.
# Parameters:
# - $command: The command string from which details will be extracted.
# Returns:
# - A string containing the formatted user@host:port/path or user@host:path.
# -------------------------------------------------------------------------------------------------------- #
function Extract-CommandDetails {
	param (
		[string]$command
	)

	try {
		# Extract the user part from the command string.
		$userCmd = if ($command -match '([^\s@]+)@([^\s:]+)') { $matches[1] } else { '' }
		# Extract the host part from the command string.
		$hostCmd = if ($command -match '([^\s@]+)@([^\s:]+)') { $matches[2] } else { '' }
		# Extract the port part from the command string, default to 22 if not found.
		$portCmd = if ($command -match '-p\s+(\d+)') { $matches[1] } else { '22' }
		# Extract the path part from the command string.
		if ($command -match '([^@]+@[^\s:]+):([^\s]+)') {
			$pathCmd = $matches[2]
		} elseif ($command -match " '(.*)'$") {
			$pathCmd = $matches[1].TrimStart('/')
		} else {
			$pathCmd = ''
		}

		# Format and return the extracted details based on whether the port is the default (22) or custom.
		if ("$portCmd" -eq '22' -or "$portCmd" -eq '') {
			return "${userCmd}@${hostCmd}:${pathCmd}"
		} else {
			return "${userCmd}@${hostCmd}:${portCmd}/${pathCmd}"
		}
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}

# Extracts details from the URL pattern.
# -------------------------------------------------------------------------------------------------------- #
# This function extracts user, host, port, and path details from a given URL pattern.
# It uses regular expressions to parse the pattern string and extracts the necessary details.
# Parameters:
# - $pattern: The URL pattern string from which details will be extracted.
# Returns:
# - A string containing the formatted user@host:port/path or user@host:path.
# -------------------------------------------------------------------------------------------------------- #
function Extract-PatternDetails {
	param (
		[string]$pattern
	)

	try {
		# Extract the user part from the pattern string.
		$urlPat = if ($pattern -match '([^:]*):*([0-9]*)/*(.*)') { $matches[1] } else { '' }
		# Extract the port part from the pattern string, default to 22 if not found.
		$portPat = if ($pattern -match '([^:]*):*([0-9]*)/*(.*)') { $matches[2] } else { '22' }
		# Extract the path part from the pattern string and remove leading slashes.
		$pathPat = if ($pattern -match '([^:]*):*([0-9]*)/*(.*)') { $matches[3] } else { '' }

		# Format and return the extracted details based on whether the port is the default (22) or custom.
		if ("${portPat}" -eq '22' -or "${portPat}" -eq '') {
			return "${urlPat}:${pathPat}"
		} else {
			return "${urlPat}:${portPat}/${pathPat}"
		}
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}

# Converts paths to a standardized format using forward slashes (/).
# -------------------------------------------------------------------------------------------------------- #
# This function takes a path and converts all backslashes (\) to forward slashes (/),
# ensuring consistency across different operating systems.
# Parameters:
# - $path: The path to be normalized.
# Returns:
# - The normalized path with forward slashes.
# -------------------------------------------------------------------------------------------------------- #
function Normalize-Path {
	param (
		[string]$path
	)

	try {
		return $path -replace '\\', '/'
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}

# Validates the command against the provided patterns.
# -------------------------------------------------------------------------------------------------------- #
# This function validates the parent command and the current working directory against provided patterns.
# It compares the extracted command details and the current directory with the expected patterns.
# If either does not match, it exits with a status code of 1.
# Parameters:
# - $urlPattern: The expected pattern for the command URL.
# - $dirPattern: The expected pattern for the current directory.
# -------------------------------------------------------------------------------------------------------- #
function Validate-Command {
	param (
		[string]$urlPattern,
		[string]$dirPattern
	)

	try {
		# Retrieve the command line of the parent process.
		$parentCmd = Get-ParentCommand
		# Extract command details (user, host, port, path) from the parent command.
		$commandUrl = Extract-CommandDetails -command $parentCmd
		# Extract pattern details (user, host, port, path) from the URL pattern.
		$patternUrl = Extract-PatternDetails -pattern $urlPattern
		# Get the current working directory.
		$commandDir = Normalize-Path -path (Get-Location).Path
		# Normalize the patterns to ensure consistency across different operating systems.
		$dirPattern = Normalize-Path -path $dirPattern

		Log-Message "Verification - Command URL: $commandUrl, Pattern URL: $patternUrl, Current Directory: $commandDir, Dir Pattern: $dirPattern"
		# Validate the extracted command URL and the current directory against the provided patterns.
		if ($commandUrl -match $patternUrl -or $commandDir -match $dirPattern) {
			exit 0
		}
		else {
			exit 1
		}
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #

# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# MAIN FUNCTION
# ==================================================================================================================================== #
# Main function to handle the script execution.
# -------------------------------------------------------------------------------------------------------- #
# This is the main entry point of the script. It validates the number of arguments provided,
# and then calls the Validate-Command function with the given URL pattern and directory pattern.
# If the number of arguments is not exactly two, it prints a usage message and exits with a status code of 1.
# -------------------------------------------------------------------------------------------------------- #
function Main {
	param (
		[string]$urlPattern,
		[string]$dirPattern
	)

	try {
		Log-Message "Validate - URL Pattern: $urlPattern, Dir Pattern: $dirPattern"
		# Validate the command with the provided URL pattern and directory pattern.
		Validate-Command -urlPattern $urlPattern -dirPattern $dirPattern
	} catch {
		Log-Message "Error: $($_)"
		exit 1
	}
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #

# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# MAIN FUNCTION
# ==================================================================================================================================== #
# Call the main function with all the script arguments.
# -------------------------------------------------------------------------------------------------------- #
# This is the script's entry point. It passes all the script arguments to the Main function.
# -------------------------------------------------------------------------------------------------------- #
Main @args
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
