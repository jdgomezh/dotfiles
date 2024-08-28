#!/usr/bin/env pwsh

param (
	[string]$sshPattern,  # Expected SSH URI pattern to match against the command
	[string]$dirPattern   # Expected directory pattern to match against the current path
)

# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# LOGGING FUNCTION
# ==================================================================================================================================== #
# The logging function writes messages to a log file, including a timestamp for traceability.
# This is critical for debugging and auditing purposes, allowing us to track the flow and
# outcomes of the script execution over time.
# ==================================================================================================================================== #
# Define the log file path for storing log messages
$logFile = "$HOME/.ssh/ssh_log.log"

# Function to log messages with a timestamp to a designated log file
function Write-Log {
	param (
		[string]$message  # The message to log
	)

	# Get the current date and time formatted as "yyyy-MM-dd HH:mm:ss"
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

	# Combine the timestamp with the message and append it to the log file
	"$timestamp - $message" | Out-File -FilePath $logFile -Append
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# UTILITY FUNCTIONS
# ==================================================================================================================================== #
# These functions are designed to support the core functionality of the script by providing
# essential utilities such as retrieving SSH command information, converting command formats,
# and normalizing file paths. Each function is isolated to ensure single responsibility,
# which improves maintainability and testability.
# ==================================================================================================================================== #
# -------------------------------------------------------------------------------------------------------- #
# Retrieves the SSH command of the parent process
# -------------------------------------------------------------------------------------------------------- #
# This function traverses the process tree to find the command line of the SSH process that initiated
# the current script. It is particularly useful in scenarios where the script is triggered by an SSH session.
# -------------------------------------------------------------------------------------------------------- #
function Get-SshParentCommand {
	try {
		$currentPID = $PID  # Start with the current process ID
		$sshCmd = ""  # Initialize an empty string to store the SSH command

		while ($true) {
			# Retrieve the current process based on its ID
			$currentProcess = Get-Process -Id $currentPID

			# If there is no parent process, break the loop
			if (-not $currentProcess.Parent) {
				break
			}

			# Get the parent process ID and command line
			$parentPID = $currentProcess.Parent.Id
			$parentProcess = Get-Process -Id $parentPID
			$parentCmd = $parentProcess.CommandLine

			# Update current PID to the parent PID for the next iteration
			$currentPID = $parentPID

			# If the parent process is an SSH process, store the command and exit the loop
			if ($parentProcess.ProcessName -eq 'ssh' -or $parentProcess.ProcessName -eq 'ssh.exe') {
				$sshCmd = $parentCmd
				break
			}
		}

		# If no SSH command is found in the loop, attempt to find any running SSH process
		if ([string]::IsNullOrEmpty($sshCmd)) {
			$sshProcess = Get-Process | Where-Object { $_.Name -eq 'ssh' -or $_.Name -eq 'ssh.exe' }
			$sshCmd = $sshProcess.CommandLine
		}

		# Return the SSH command found
		return $sshCmd
	}
	catch {
		# Propagate the error to the caller
		throw $_
	}
}

# -------------------------------------------------------------------------------------------------------- #
# Converts SSH command to a standardized URI format
# -------------------------------------------------------------------------------------------------------- #
# This function takes an SSH command string and converts it into a standardized SSH URI.
# The conversion process involves parsing the command for user, host, port, and optional command
# path, then formatting these elements into a URI string (e.g., ssh://user@host:port/path).
# -------------------------------------------------------------------------------------------------------- #
function Convert-SshCommandToUri {
	param (
		[string]$sshCmd  # The SSH command string to convert
	)

	try {
		$sshUri = ""  # Initialize an empty string to store the SSH URI

		# Regular expression to parse the SSH command
		if ($sshCmd -match '^(.*ssh(?:\.exe)?)\s+(?:(?<flags>(?:-[^\s]+\s[^\s]+\s*)*))?(?:(?<user>[^\@\s]+)@)?(?<host>[\w.-]+)\s(?:"?(?<command>[^"]*)"?\s*)?$') {
			# Extract user, host, flags, and command from the matched string
			$userCmd = $matches['user']
			$hostCmd = $matches['host']
			$flagsCmd = $matches['flags']
			$commandCmd = $matches['command']

			# Extract the port from flags if specified
			$portCmd = if ($flagsCmd -match '-p\s+(\d+)') { $matches[1] } else { "" }

			# Build the SSH URI incrementally
			if (![string]::IsNullOrEmpty($userCmd)) {
				$sshUri += "$userCmd@"
			}

			$sshUri += "$hostCmd"

			if (![string]::IsNullOrEmpty($portCmd) -and "$portCmd" -ne "22") {
				$sshUri += ":$portCmd"
			}

			# Process the command part to extract the path if available
			if (![string]::IsNullOrEmpty($commandCmd)) {
				$commandCmd = $commandCmd.Trim()
				if ($commandCmd -match '(?<path>[''"]?(?:\/|~\/|[\w\-\.]+\/)[^''"\s]+[''"]?)') {
					$pathCmd = $matches['path']
					$pathCmd = $pathCmd.Trim("'").Trim('"')

					if (![string]::IsNullOrEmpty($portCmd) -and "$portCmd" -ne "22" -and ![string]::IsNullOrEmpty($pathCmd)) {
						$sshUri += "$pathCmd"
					}
					elseif (![string]::IsNullOrEmpty($pathCmd)) {
						$sshUri += ":$pathCmd"
					}
				}
			}
		}

		# Prepend the "ssh://" scheme to the URI if any components were found
		if (![string]::IsNullOrEmpty($sshUri)) {
			$sshUri = "ssh://$sshUri"
		}

		Write-Log -message "Converted SSH command ($sshCmd) to URI ($sshUri) with user ($userCmd), host ($hostCmd), port ($portCmd), and command ($commandCmd)."

		# Return the formatted SSH URI
		return $sshUri
	}
	catch {
		# Propagate the error to the caller
		throw $_
	}
}

# -------------------------------------------------------------------------------------------------------- #
# Normalizes file paths to use forward slashes (/)
# -------------------------------------------------------------------------------------------------------- #
# This function ensures consistency in file path formats by converting all backslashes (\)
# to forward slashes (/). This is particularly important for cross-platform compatibility
# as Windows uses backslashes by default, while Unix-like systems use forward slashes.
# -------------------------------------------------------------------------------------------------------- #
function ConvertTo-ForwardSlash {
	param (
		[string]$path  # The file path to normalize
	)

	try {
		# Replace all backslashes with forward slashes
		$normalizedPath = $path -replace '\\', '/'
		return $normalizedPath
	}
	catch {
		# Propagate the error to the caller
		throw $_
	}
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# MAIN FUNCTION
# ==================================================================================================================================== #
# The main function serves as the entry point for script execution. It coordinates the retrieval
# of the parent SSH command, converts it to a URI, and validates it against the provided patterns.
# The results are logged, and the script exits with an appropriate status code based on the outcome.
# ==================================================================================================================================== #
function Main {
	param (
		[string]$sshUriPattern,  # The SSH URI pattern to validate against
		[string]$pathPattern     # The directory path pattern to validate against
	)

	try {
		# Retrieve the parent SSH command
		$parentCmd = Get-SshParentCommand

		# Convert the SSH command to a URI
		$sshUriCmd = Convert-SshCommandToUri -sshCmd $parentCmd

		# Normalize the current directory path and the provided directory pattern
		$commandPath = ConvertTo-ForwardSlash -path (Get-Location).Path
		$pathPattern = ConvertTo-ForwardSlash -path $pathPattern

		# Validate the SSH URI and current directory against the provided patterns
		$isSshUriMatched = $sshUriCmd -match $sshUriPattern
		$isCommandPathMatched = $commandPath -match $pathPattern
		$isSuccess = $isSshUriMatched -and $isCommandPathMatched

		Write-Log -message "Success Matched $($isSuccess.ToString()) => (SSH URI Command: $sshUriCmd ~ SSH URI Pattern: $sshUriPattern = $($isSshUriMatched.ToString()) && Command Path: $commandPath ~ Command Path Pattern: $pathPattern = $($isCommandPathMatched.ToString()))"

		# Validate the SSH URI and current directory against the provided patterns
		if ($isSuccess) { exit 0 } else { exit 1 }
	}
	catch {
		throw $_  # Propagate the error to the caller
	}
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ENTRY POINT
# ==================================================================================================================================== #
# The script's entry point initiates the main function with the provided parameters and
# handles any exceptions that occur during execution, ensuring that the script exits
# with a non-zero status code in case of failure.
# ==================================================================================================================================== #
try {
	# Start the main process with provided SSH and directory patterns
	Main -sshUriPattern $sshPattern -pathPattern $dirPattern
}
catch {
	Write-Log -message "An unexpected error occurred: $_"
	exit 1  # Ensure a non-zero exit code in case of failure
}
finally {
	Write-Log -message "Script execution completed."
}
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
