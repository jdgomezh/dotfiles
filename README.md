Required export:
```shell
export ENV_ROOT="/-"
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
ln -sf "${ENV_ROOT}/Conf/0.Mine/editor/NeoVim/theme" "${XDG_CONFIG_HOME}/nvim/lua/theme"
```

Symlink to create by WezTerm:
```shell
ln -sf "${ENV_ROOT}/Conf/0.Mine/terminal/WezTerm/loeader/wezterm.lua" "${XDG_CONFIG_HOME}/wezterm/wezterm.lua"
```
