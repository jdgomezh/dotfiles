#!/usr/bin/env bash
set -euo pipefail

# ======================================================================================================================== #
# Utility Functions
# ======================================================================================================================== #

# Retrieves the command of the parent process.
get_parent_command() {
	local parent_pid
	parent_pid=$(ps -o ppid= -p $$ | tr -d ' ')
	ps -o cmd= -p "$parent_pid"
}

# Extracts details from the command string.
extract_command_details() {
	local command="$1"
	local user host port path

	user=$(echo "$command" | grep -oE "[^ ]+@[^ :]+" | awk -F"@" '{print $1}')
	host=$(echo "$command" | grep -oE "[^ ]+@[^ :]+" | awk -F"@" '{print $2}')
	port=$(echo "$command" | grep -oE "\-p [0-9]+" | awk '{print $2}')
	path=$(echo "$command" | grep -oE "(.*) '[^']+'$" | awk -F"'" '{print $2}')

	port="${port:-22}"
	path="${path#/}"

	if [[ "$port" -eq "22" ]]; then
		echo "${user}@${host}:${path}"
	else
		echo "${user}@${host}:${port}/${path}"
	fi
}

# Validates the command against the provided patterns.
validate_command() {
	local url_pattern="$1"
	local dir_pattern="$2"
	local parent_cmd
	local command_url
	local command_dir

	parent_cmd=$(get_parent_command)
	command_url=$(extract_command_details "$parent_cmd")
	command_dir=$(pwd)

	if [[ "$command_url" != $url_pattern ]] || [[ "$command_dir" != $dir_pattern ]]; then
		exit 1
	fi

	exit 0
}

# ======================================================================================================================== #
# Main Function
# ======================================================================================================================== #
main() {
	if [[ $# -ne 2 ]]; then
		echo "Usage: $0 <url_pattern> <dir_pattern>"
		exit 1
	fi

	local url_pattern="$1"
	local dir_pattern="$2"

	validate_command "$url_pattern" "$dir_pattern"
}


# ======================================================================================================================== #
# Exceution
# ======================================================================================================================== #
main "$@"