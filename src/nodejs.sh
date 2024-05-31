#!/usr/bin/env sh

package_name(){
    echo "nodejs"
}

install_nodejs()
{
    is_installed node
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

install()
{
    install_nodejs
    is_installed pyright
    if [ $FNRET = 1 ]; then
        npm_install pyright
    else
        ok "pyright installed."
    fi
}

upgrade()
{
    upgrade_package $(package_name)
    npm_update pyright
}

remove()
{
    npm_uninstall pyright
    remove_package $(package_name)
}

. $(dirname "$0")/.main.sh
