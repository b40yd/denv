#!/usr/bin/env sh


package_name(){
    echo "graphviz"
}

install()
{
    is_installed dot
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

. $(dirname "$0")/.main.sh
