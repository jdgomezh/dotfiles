# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# CHECK IF THE ZLOGIN ENVIRONMENT HAS ALREADY BEEN EXECUTED
# ==================================================================================================================================== #
if [ -n "${NVIM:-}" ] && [ -z "${RESET_IS_NEEDED:-}" ] && {
	[ "${ZLOGIN_ENV_WAS_EXECUTED:-0}" -eq 1 ] || \
	[ "${ZSHRC_ENV_WAS_EXECUTED:-0}" -eq 1 ] || \
	[ "${ZPROFILE_ENV_WAS_EXECUTED:-0}" -eq 1 ] || \
	[ "${ZSHENV_ENV_WAS_EXECUTED:-0}" -eq 1 ]
}; then
	export RESET_IS_NEEDED=1
fi

if [ "${ZLOGIN_ENV_WAS_EXECUTED:-0}" -eq 1 ] && [ "${RESET_IS_NEEDED:-0}" -eq 0 ]; then
	return 0 2>/dev/null || exit 0
elif [ "${ZLOGIN_ENV_WAS_EXECUTED:-0}" -eq 1 ] && [ "${RESET_IS_NEEDED:-0}" -eq 1 ]; then
	export COMMON_ZSH_ENV_WAS_EXECUTED=0
	export COMMON_ZSH_END_WAS_EXECUTED=0
	export COMMON_POSIX_ENV_WAS_EXECUTED=0
	export COMMON_POSIX_END_WAS_EXECUTED=0

	export RESET_IS_NEEDED=0
fi

export ZLOGIN_ENV_WAS_EXECUTED=1
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# START OF ZLOGIN ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# ENV_ROOT: Determines the root directory of the environment configuration
if [ -z "${ENV_ROOT:-}" ]; then
	# Obtain the script directory using readlink or realpath
	SCRIPT_DIR=$(dirname "$(readlink -f "${(%):-%N}")")
	# Resolve the environment root directory
	ENV_ROOT=$(realpath "${SCRIPT_DIR}/../../../..")
	# Export the environment root directory
	export ENV_ROOT
fi

# Load Common ZSH environment configuration script
source "${ENV_ROOT}/Conf/0.Mine/common/shell/zsh/env.zsh"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# END OF ZLOGIN ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Load Common ZSH End configuration script
source "${ENV_ROOT}/Conf/0.Mine/common/shell/zsh/end.zsh"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
