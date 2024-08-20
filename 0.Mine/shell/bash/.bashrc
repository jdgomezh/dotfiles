# //////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ #
# ENVIRONMENT BASE CONFIGURATION
# ==================================================================================================================================== #
# Check if the environment root is set, if not set it to the default value.
if [ -z "${ENV_ROOT}" ]; then
    export ENV_ROOT=$(realpath "$(dirname "$(readlink -f "$0")")/../../../..")
fi

source "$ENV_ROOT/Conf/0.Mine/common/shell/bash/env.bash"
# ==================================================================================================================================== #
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////////////////////////////////////// #

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/jdgomezh/.local/share/sdkman"
[[ -s "/home/jdgomezh/.local/share/sdkman/bin/sdkman-init.sh" ]] && source "/home/jdgomezh/.local/share/sdkman/bin/sdkman-init.sh"
