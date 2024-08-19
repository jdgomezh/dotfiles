# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# CHECK IF THE COMMON ZSH ENVIRONMENT CONFIGURATION SCRIPT WAS EXECUTED
# ==================================================================================================================================== #
if [ "${COMMON_ZSH_ENV_WAS_EXECUTED:-0}" -eq 1 ]; then
	return 0 2>/dev/null || exit 0
fi

export COMMON_ZSH_ENV_WAS_EXECUTED=1
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# START OF COMMON ZSH ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Start Common POSIX environment configuration script
source "${ENV_ROOT}/Conf/0.Mine/common/shell/posix/env.sh"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ENVIRONMENT BASE CONFIGURATION
# ==================================================================================================================================== #
# Set the ZDOTDIR variable to point to the zsh configuration directory.
export ZDOTDIR="${XDG_DATA_HOME}/zsh"
export ZCACHE="${XDG_CACHE_HOME}/zsh"

# Create necessary directories
mkdir -p "${ZDOTDIR}" "${ZCACHE}"

# Create symlinks if they do not exist
for file in .zlogin .zprofile .zshenv .zshrc .zimrc .p10k.zsh; do
	ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/${file}" "${ZDOTDIR}/${file}"
	ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/${file}" "${HOME}/${file}"
done
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ZSH CONFIGURATION
# ==================================================================================================================================== #
# HISTFILE: Path to the history file.
export HISTFILE="${ZCACHE}/zsh_history"
# HISTSIZE: Number of commands to save in the history list.
export HISTSIZE=10000
# SAVEHIST: Number of commands to save in the history file.
export SAVEHIST=10000
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ZIM CONFIGURATION
# ==================================================================================================================================== #
# ZIM_HOME: Defines the directory where ZIM (Zsh IMproved) framework files are stored.
export ZIM_HOME="${XDG_DATA_HOME}/zimfw"

# Use degit tool by default if git is not installed.
# Degit is a tool to download git repositories without having git installed.
command -v git &> /dev/null || zstyle ':zim:zmodule' use 'degit'

# Download the zimfw plugin manager if it is missing.
# This ensures that zimfw is available for managing zsh plugins.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update init.zsh if it is missing or outdated.
# This step ensures that all zimfw modules are properly installed and up-to-date.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR}/.zimrc} ]]; then
	source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Source the zimfw init script
source ${ZIM_HOME}/init.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.cache/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source the Powerlevel10k configuration file
if [[ -e ${ZDOTDIR}/.p10k.zsh ]]; then
	source "${ZDOTDIR}/.p10k.zsh"
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
