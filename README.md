pyenv dependencies:
```shell
sudo apt-get install -y \
    libbz2-dev \
    libncurses5-dev libncursesw5-dev \
    libffi-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    zlib1g-dev \
    liblzma-dev \
    tk-dev \
    libgdbm-dev \
    libnss3-dev \
    libdb5.3-dev \
    libexpat1-dev \
    liblzma-dev \
    libffi-dev \
    libbz2-dev \
    uuid-dev
```

R dependencies:
```shell
sudo apt install -y dirmngr gnupg apt-transport-https software-properties-common
sudo apt install -y build-essential libcurl4-openssl-dev libssl-dev libxml2-dev cmake clang
```

Basic dependencies:
```shell
sudo apt install curl wget zip unzip fontconfig neofetch git zsh lsd bat gnupg apt-transport-https openssh-client
```

Powershell Core (pwsh) required:
```shell
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -cs)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/microsoft-powershell.list'
sudo apt update
sudo apt install -y powershell
pwsh --version
```

or download with:
```shell
wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.5/powershell_7.4.5-1.deb_amd64.deb
sudo dpkg -i powershell_7.4.5-1.deb_amd64.deb
sudo apt-get install -f
```

Required export:
```shell
export ENV_ROOT="/-"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
```

Symlink básico:
```shell
ln -sf "${ENV_ROOT}" "${HOME}/-"
```

Symlinks to create by posix:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/posix/.profile" "${HOME}/.profile"
```

Symlinks to create by bash:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/bash/.bash_login" "${HOME}/.bash_login"
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/bash/.bash_profile" "${HOME}/.bash_profile"
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/bash/.bashrc" "${HOME}/.bashrc"
```


Symlinks to create by zsh:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/.zshenv" "${HOME}/.zshenv"
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/.zprofile" "${HOME}/.zprofile"
ln -sf "${ENV_ROOT}/Conf/0.Mine/shell/zsh/.zlogin" "${HOME}/.zlogin"
```

Symlinks to create by Git:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/Git/config/.gitconfig" "${HOME}/.gitconfig"
```

Symlinks to create by Neofetch:
```shell
mkdir -p "${XDG_CONFIG_HOME}/neofetch"
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/Neofetch/config/config.conf" "${XDG_CONFIG_HOME}/neofetch/config.conf"
```

Symlink to create by NeoVim:
```shell
mkdir -p "${XDG_CONFIG_HOME}/nvim/lua"
ln -sf "${ENV_ROOT}/Conf/0.Mine/editor/NeoVim/loader/init.lua" "${XDG_CONFIG_HOME}/nvim/init.lua"
ln -sf "${ENV_ROOT}/Conf/0.Mine/editor/NeoVim/plugin" "${XDG_CONFIG_HOME}/nvim/lua/plugin"
ln -sf "${ENV_ROOT}/Conf/0.Mine/editor/NeoVim/themes" "${XDG_CONFIG_HOME}/nvim/lua/themes"
```

Symlink to create by WezTerm:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/terminal/WezTerm/loeader/wezterm.lua" "${XDG_CONFIG_HOME}/wezterm/wezterm.lua"
```

Symlink to create by Kitty:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/terminal/Kitty/config/kitty.conf" "${XDG_CONFIG_HOME}/kitty/kitty.conf"
```

Symlink to create by SSH:
```shell
mkdir -p "${HOME}/.ssh"
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/SSH/config/config" "${HOME}/.ssh/config"
```

Symlink to create by Obsidian:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/Obsidian/config/ffdfe0a9ad35e092.json" "${XDG_CONFIG_HOME}/obsidian/ffdfe0a9ad35e092.json"
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/Obsidian/config/obsidian.prs-jdgomezh-desktop.json" "${XDG_CONFIG_HOME}/obsidian/obsidian.json"
ln -sf "${ENV_ROOT}/Conf/0.Mine/tool/Obsidian/config/Preferences" "${XDG_CONFIG_HOME}/obsidian/Preferences"
```
