#!/usr/bin/env sh

package_name(){
    echo "coreutils"
}

install()
{
    is_installed nice
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "nice installed."
    fi
}

. $(dirname "$0")/.main.sh
