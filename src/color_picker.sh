#!/usr/bin/env sh

package_name()
{
    local PACKAGE="zenity"

    if command -v brew >/dev/null 2>&1; then
        PACKAGE="ncruces/tap/zenity"
    fi

    echo $PACKAGE
}

# see https://github.com/ncruces/zenity/releases
install()
{
    is_installed zenity
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

. $(dirname "$0")/main.sh
