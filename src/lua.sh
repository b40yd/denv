#!/usr/bin/env sh

lua_package_manager_install()
{
    is_installed luarocks
    if [ $FNRET = 1 ]; then
        install_package luarocks
    else
        ok "luarocks installed."
    fi
}

lua_package_install()
{
    local PACKAGE=$1
    is_installed luarocks
    if [ $FNRET = 1 ]; then
        crit "must be install luarocks."
    else
        is_installed $PACKAGE
        if [ $FNRET = 1 ]; then
            luarocks install $PACKAGE
            if [ $? = 0 ]; then
                FNRET=0
            else
                FNRET=1
            fi
        fi
    fi

    if [ $FNRET = 1 ]; then
        crit "$PACKAGE install failed."
    else
        ok "$PACKAGE installed."
    fi
}

install()
{
    is_installed lua
    if [ $FNRET = 1 ]; then
        install_package lua
    else
        ok "lua installed."
    fi
    lua_package_manager_install
    lua_package_install luacheck
}

upgrade()
{
    upgrade_package lua
    upgrade_package luarocks
}

remove()
{
    remove_package lua
    remove_package luarocks
}

. $(dirname "$0")/main.sh
