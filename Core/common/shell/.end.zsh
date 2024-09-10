# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# CHECK IF COMMON ZSH END CONFIGURATION WAS EXECUTED
# ==================================================================================================================================== #
if [ "${COMMON_ZSH_END_WAS_EXECUTED:-0}" -eq 1 ]; then
	return 0 2>/dev/null || exit 0
fi

export COMMON_ZSH_END_WAS_EXECUTED=1
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# KEYBINDINGS CONFIGURATION
# ==================================================================================================================================== #
# Configure keybindings to improve navigation and command editing efficiency.
# Each bindkey command assigns a specific key combination to a zsh function.
bindkey '^[[1;5D' backward-word						# Ctrl + Left Arrow: Move cursor backward by one word.
bindkey '^[[1;5C' forward-word						# Ctrl + Right Arrow: Move cursor forward by one word.
bindkey '^[[3;5~' kill-word							# Ctrl + Delete: Kill (cut) the word after the cursor.
bindkey '^H' backward-kill-word						# Ctrl + Backspace: Kill (cut) the word before the cursor.
bindkey '^A' beginning-of-line						# Ctrl + A: Move cursor to the beginning of the line.
bindkey '^E' end-of-line							# Ctrl + E: Move cursor to the end of the line.
bindkey '^U' backward-kill-line						# Ctrl + U: Kill (cut) the text from the cursor to the beginning of the line.
bindkey '^K' kill-line								# Ctrl + K: Kill (cut) the text from the cursor to the end of the line.
bindkey '^Y' yank									# Ctrl + Y: Yank (paste) the last killed (cut) text.
bindkey '^[.' insert-last-word						# Alt + .: Insert the last word of the previous command.
bindkey '^[b' backward-word							# Alt + B: Move cursor backward by one word.
bindkey '^[f' forward-word							# Alt + F: Move cursor forward by one word.
bindkey '^R' history-incremental-search-backward	# Ctrl + R: Search through command history incrementally (backward).
bindkey '^[d' kill-word								# Alt + D: Kill (cut) the word after the cursor.
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #


# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# END OF COMMON ZSH ENVIRONMENT CONFIGURATION
# ==================================================================================================================================== #
# Load Common POSIX End configuration script
source "${ENV_ROOT}/Conf/Core/common/shell/.end.sh"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #
