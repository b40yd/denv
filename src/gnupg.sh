#!/usr/bin/env sh

package_name(){
    echo "gnupg"
}

install()
{
    is_installed gpg
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

. $(dirname "$0")/main.sh
