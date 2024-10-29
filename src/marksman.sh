#!/usr/bin/env sh

package_name(){
    echo "marksman"
}

# see https://github.com/artempyanykh/marksman
install()
{
    is_installed $(package_name)
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

. $(dirname "$0")/.main.sh
