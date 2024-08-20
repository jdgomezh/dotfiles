# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# CHECK IF THE ZSHRC ENVIRONMENT HAS ALREADY BEEN EXECUTED
# ==================================================================================================================================== #
if [ -n "${NVIM:-}" ] && [ -z "${RESET_IS_NEEDED:-}" ] && {
	[ "${ZSHRC_ENV_WAS_EXECUTED:-0}" -eq 1 ] || \
	[ "${ZPROFILE_ENV_WAS_EXECUTED:-0}" -eq 1 ] || \
	[ "${ZSHENV_ENV_WAS_EXECUTED:-0}" -eq 1 ]
}; then
	export RESET_IS_NEEDED=1
fi

if [ "${ZSHRC_ENV_WAS_EXECUTED:-0}" -eq 1 ] && [ "${RESET_IS_NEEDED:-0}" -eq 0 ]; then
	return 0 2>/dev/null || exit 0
elif [ "${ZSHRC_ENV_WAS_EXECUTED:-0}" -eq 1 ] && [ "${RESET_IS_NEEDED:-0}" -eq 1 ]; then
	export COMMON_ZSH_ENV_WAS_EXECUTED=0
	export COMMON_ZSH_END_WAS_EXECUTED=0
	export COMMON_POSIX_ENV_WAS_EXECUTED=0
	export COMMON_POSIX_END_WAS_EXECUTED=0

	export ZLOGIN_ENV_WAS_EXECUTED=0

	export RESET_IS_NEEDED=0
fi

export ZSHRC_ENV_WAS_EXECUTED=1
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# START OF ZSHRC ENVIRONMENT CONFIGURATION
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
# END OF ZSHRC ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Load Common ZSH End configuration script
source "${ENV_ROOT}/Conf/0.Mine/common/shell/zsh/end.zsh"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/jdgomezh/.local/share/sdkman"
[[ -s "/home/jdgomezh/.local/share/sdkman/bin/sdkman-init.sh" ]] && source "/home/jdgomezh/.local/share/sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
