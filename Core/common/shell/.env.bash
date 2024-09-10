echo "Environment configured by ${0} script."
# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# START OF COMMON BASH ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# ENV_ROOT: Determines the root directory of the environment configuration
if [ -z "${ENV_ROOT:-}" ]; then
	# Obtain the script directory using readlink or realpath
	SCRIPT_DIR=$(dirname "$(readlink -f "$0" 2>/dev/null || realpath "$0")")
	# Resolve the environment root directory
	ENV_ROOT=$(realpath "${SCRIPT_DIR}/../../../..")
	# Export the environment root directory
	export ENV_ROOT
fi

# Load Common POSIX environment configuration script
source "${ENV_ROOT}/Conf/Core/common/shell/.env.sh"

# Check if the common Bash environment has already been executed
if [ "${COMMON_BASH_ENV_WAS_EXECUTED:-0}" -eq 1 ] && [ -z "${NVIM:-}" ]; then
	# Exit the script if it has already been executed
	return 0 2>/dev/null || exit 0
elif [ "${COMMON_BASH_ENV_WAS_EXECUTED_ON_NVIM:-0}" -eq 1 ]; then
	# Exit the script if it has already been executed
	return 0 2>/dev/null || exit 0
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# END OF COMMON BASH ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Mark the common Bash environment as executed
export COMMON_BASH_ENV_WAS_EXECUTED=1
# Mark the common Bash environment as executed on Neovim
if [ -n "${NVIM:-}" ]; then
	export COMMON_BASH_ENV_WAS_EXECUTED_ON_NVIM=1
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
