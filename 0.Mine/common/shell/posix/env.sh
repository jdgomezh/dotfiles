# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# CHECK IF THE COMMON POSIX ENVIRONMENT HAS ALREADY BEEN EXECUTED
# ==================================================================================================================================== #
if [ "${COMMON_POSIX_ENV_WAS_EXECUTED:-0}" -eq 1 ]; then
	return 0 2>/dev/null || exit 0
fi

export COMMON_POSIX_ENV_WAS_EXECUTED=1
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ENVIRONMENT BASE CONFIGURATION
# ==================================================================================================================================== #
# Set XDG Base Directory Specification variables.
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Set user local fonts directory
export XDG_FONTS_HOME="${XDG_FONTS_HOME:-$XDG_DATA_HOME/fonts}"

# Create necessary directories if they do not exist
mkdir -p "${XDG_FONTS_HOME}" "${XDG_BIN_HOME}"

# Update PATH so it includes user's private bin
PATH="$XDG_BIN_HOME:$PATH"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# SDKMAN CONFIGURATION
# ==================================================================================================================================== #
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
SDKMAN_INIT="${SDKMAN_DIR}/bin/sdkman-init.sh"

if [ -d "${SDKMAN_DIR}" ] && [ "$(ls -A "${SDKMAN_DIR}")" ]; then
	# Source the SDKMAN initialization script
	source "${SDKMAN_INIT}"
else
	# Define the versions of SDKMAN tools to be installed
	JAVA_VERSION="21.0.2-open"
	MAVEN_VERSION="3.9.7"
	GRADLE_VERSION="8.8"

	# Install SDKMAN
	curl -s "https://get.sdkman.io" | bash

	# Source the SDKMAN initialization script
	source "${SDKMAN_INIT}"

	# Install the required SDKMAN tools
	sdk install java ${JAVA_VERSION}
	sdk install maven ${MAVEN_VERSION}
	sdk install gradle ${GRADLE_VERSION}
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# NVM CONFIGURATION (NODE VERSION MANAGER)
# ==================================================================================================================================== #
export NVM_DIR="${XDG_DATA_HOME}/nvm"

if [ -s "${NVM_DIR}/nvm.sh" ]; then
	# Source the NVM initialization script
	source "${NVM_DIR}/nvm.sh"
	[ -s "${NVM_DIR}/bash_completion" ] && source "${NVM_DIR}/bash_completion"
else
	# Define the versions of NVM and Node.js to be installed
	NVM_VERSION="v0.39.1"
	NODE_VERSION="16.15.0"

	# Create the NVM directory if it does not exist
	mkdir -p "${NVM_DIR}"

	# Install NVM
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

	# Source the NVM initialization script
	source "${NVM_DIR}/nvm.sh"
	[ -s "${NVM_DIR}/bash_completion" ] && source "${NVM_DIR}/bash_completion"

	# Install the required Node.js version
	nvm install ${NODE_VERSION}
	nvm use ${NODE_VERSION}
	nvm alias default ${NODE_VERSION}
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# PYENV CONFIGURATION
# ==================================================================================================================================== #
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

if [ -d "${PYENV_ROOT}" ] && [ "$(ls -A "${PYENV_ROOT}")" ]; then
	# Add Pyenv to PATH and initialize
	PATH="${PYENV_ROOT}/bin:$PATH"
	eval "$(pyenv init --path)"
else
	# Define the Python version to be installed
	PYTHON_VERSION="3.9.7"

	# Install Pyenv and the specified Python version
	curl https://pyenv.run | bash

	# Add Pyenv to PATH and initialize
	PATH="${PYENV_ROOT}/bin:$PATH"
	eval "$(pyenv init --path)"

	# Install the required Python version
	pyenv install ${PYTHON_VERSION}
	pyenv global ${PYTHON_VERSION}
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# OMNISHARP CONFIGURATION
# ==================================================================================================================================== #
# Define the OmniSharp directory based on the XDG_DATA_HOME environment variable
export OMNISHARP_DIR="${XDG_DATA_HOME}/omnisharp"

# If the OmniSharp executable does not exist or is not executable, proceed with installation.
if [ ! -x "${OMNISHARP_DIR}/OmniSharp" ]; then
	# Define the OmniSharp version to download
	OMNISHARP_VERSION="v1.37.17"

	# Determine the correct URL to download the OmniSharp package based on the OS.
	case "$OSTYPE" in
		linux-gnu*)
			PACKAGE_URL="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/${OMNISHARP_VERSION}/omnisharp-linux-x64.zip"
			;;
		darwin*)
			PACKAGE_URL="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/${OMNISHARP_VERSION}/omnisharp-osx.zip"
			;;
		*)
			# If the OS is not supported, clean up and exit with an error.
			echo "Unsupported OS type: $OSTYPE"
			rm -rf "${TEMP_DIR}"
			return 1 2>/dev/null || exit 1
			;;
	esac

	# Clean up any previous installations
	rm -rf "${OMNISHARP_DIR}"

	# Create a temporary directory for downloading the OmniSharp package
	OMNISHARP_TEMP_DIR=$(mktemp -d)

	# Use curl to download the OmniSharp package to the temporary directory.
	curl -L "$PACKAGE_URL" -o "${OMNISHARP_TEMP_DIR}/omnisharp.zip"

	# Unzip the downloaded package into the OmniSharp directory
	unzip "${OMNISHARP_TEMP_DIR}/omnisharp.zip" -d "${OMNISHARP_DIR}"
	rm -rf "${OMNISHARP_TEMP_DIR}"

	# Rename the run file to omnisharp and ensure it is executable.
	mv "${OMNISHARP_DIR}/run" "${OMNISHARP_DIR}/OmniSharp"
	chmod +x "${OMNISHARP_DIR}/OmniSharp"
fi

# Add OmniSharp to PATH
PATH="${OMNISHARP_DIR}:${PATH}"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# NERD FONTS CONFIGURATION
# ==================================================================================================================================== #
NERD_FONTS=(
	"VictorMono		https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/VictorMono.zip"
	"FiraCode		https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
	"JetBrainsMono	https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
	"IosevkaTerm	https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/IosevkaTerm.zip"
)

UPDATE_NERD_FONTS_CACHE=0
for FONT_INFO in "${NERD_FONTS[@]}"; do
	FONT_NAME=$(echo "${FONT_INFO}" | awk '{print $1}')
	FONT_URL=$(echo "${FONT_INFO}" | awk '{print $2}')

	if [ ! -d "${XDG_FONTS_HOME}/${FONT_NAME}" ]; then
		NERD_FONTS_TEMP_DIR=$(mktemp -d)
		curl -L "${FONT_URL}" -o "${NERD_FONTS_TEMP_DIR}/${FONT_NAME}.zip"
		unzip "${NERD_FONTS_TEMP_DIR}/${FONT_NAME}.zip" -d "${XDG_FONTS_HOME}/${FONT_NAME}"
		rm -rf "${NERD_FONTS_TEMP_DIR}"
		UPDATE_NERD_FONTS_CACHE=1
	fi
done

if [ ${UPDATE_NERD_FONTS_CACHE} -eq 1 ]; then fc-cache -f -v; fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ADITIONAL FONTS CONFIGURATION (FOR POWERLEVEL10K)
# ==================================================================================================================================== #
# Install additional fonts
ADDITIONAL_FONTS=(
	"FontAwesome	https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip"
	"SourceCodePro	https://github.com/adobe-fonts/source-code-pro/archive/refs/heads/main.zip"
	"Powerline		https://github.com/powerline/fonts/archive/refs/heads/master.zip"
)

UPDATE_ADITIONAL_FONTS_CACHE=0
for FONT_INFO in "${ADDITIONAL_FONTS[@]}"; do
	FONT_NAME=$(echo "${FONT_INFO}" | awk '{print $1}')
	FONT_URL=$(echo "${FONT_INFO}" | awk '{print $2}')

	if [ ! -d "${XDG_FONTS_HOME}/${FONT_NAME}" ]; then
		ADDITIONAL_FONTS_TEMP_DIR=$(mktemp -d)
		curl -L "${FONT_URL}" -o "${ADDITIONAL_FONTS_TEMP_DIR}/${FONT_NAME}.zip"
		unzip "${ADDITIONAL_FONTS_TEMP_DIR}/${FONT_NAME}.zip" -d "${XDG_FONTS_HOME}/${FONT_NAME}"
		rm -rf "${ADDITIONAL_FONTS_TEMP_DIR}"
		UPDATE_ADITIONAL_FONTS_CACHE=1
	fi
done

if [ ${UPDATE_ADITIONAL_FONTS_CACHE} -eq 1 ]; then fc-cache -f -v; fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# MESLOLGS NF CONFIGURATION (FOR POWERLEVEL10K)
# ==================================================================================================================================== #
MESLOLGS_FONTS_DIR="${XDG_FONTS_HOME}/MesloLGS_NF"

if [ ! -d "${MESLOLGS_FONTS_DIR}" ]; then
	UPDATE_MESLOLGS_FONTS_CACHE=0
	MESLOLGS_FONTS=(
		"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
		"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
		"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
		"https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
	)

	mkdir -p "${MESLOLGS_FONTS_DIR}"
	for FONT_URL in "${MESLOLGS_FONTS[@]}"; do
		curl -L "${FONT_URL}" -o "${MESLOLGS_FONTS_DIR}/$(basename ${FONT_URL})"
		UPDATE_MESLOLGS_FONTS_CACHE=1
	done

	if [ ${UPDATE_MESLOLGS_FONTS_CACHE} -eq 1 ]; then fc-cache -f -v; fi
fi
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# NEOVIM CONFIGURATION
# ==================================================================================================================================== #
export NEOVIM_DIR="/opt/nvim-linux64"

if [ ! -d "${NEOVIM_DIR}" ] && [ ! -n "$(ls -A "${NEOVIM_DIR}")" ]; then
	NVIM_VERSION="stable"
	NVIM_TEMP_DIR="$(mktemp -d)"

	# Download and extract the NeoVim package
	curl -L "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz" -o "${NVIM_TEMP_DIR}/nvim-linux64.tar.gz"
	tar -xzf "${NVIM_TEMP_DIR}/nvim-linux64.tar.gz" -C "${NVIM_TEMP_DIR}"

	# Move the extracted NeoVim package to the installation directory
	sudo mv "${NVIM_TEMP_DIR}/nvim-linux64" "${NEOVIM_DIR}"
	rm -rf "${NVIM_TEMP_DIR}"
fi

# Add NeoVim to PATH
PATH="${NEOVIM_DIR}/bin:$PATH"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# Jet Brains Toolbox
# ==================================================================================================================================== #
PATH="$PATH:${XDG_DATA_HOME}/JetBrains/Toolbox/scripts"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ALIASES
# ==================================================================================================================================== #
alias ls='lsd'
alias cat='batcat'
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
#
# ==================================================================================================================================== #
# General configuration for Java applications
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# GTK3 configurations to improve compatibility
export GTK_IM_MODULE=ibus
export QT_QPA_PLATFORMTHEME=gtk2
export XDG_CURRENT_DESKTOP=BSPWM
export CLUTTER_IM_MODULE=ibus
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11

# Font and graphics appearance improvements
export LIBGL_ALWAYS_INDIRECT=1
export MOZ_USE_XINPUT2=1

# Set the default editor to Neovim
export EDITOR='nvim'
export VISUAL='nvim'
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# END OF COMMON POSIX COMPLIANT ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Export the updated PATH
export PATH
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
