#!/usr/bin/env sh


package_name(){
    echo "ripgrep"
}

# see https://github.com/ncruces/zenity/releases
install()
{
    is_installed rg
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

. $(dirname "$0")/main.sh
