#!/usr/bin/env bash
#
# Copyright (C) 2022, 7ym0n
#
# Author: 7ym0n <bb.qnyd@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

lua_package_manager_install()
{
    is_installed luarocks
    if [ $FNRET = 1 ]; then
        install_package luarocks
    else
        if [ $FNRET = 1 ]; then
            crit "luarocks install failed."
        else
            ok "luarocks installed."
        fi
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
        if [ $FNRET = 1 ]; then
            crit "lua install failed."
        else
            ok "lua installed."
        fi
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

if [ -z "$DOTFAIRY_ROOT_DIR" ]; then
    echo "Cannot source DOTFAIRY_ROOT_DIR variable, aborting."
    exit 128
fi

# Main function, will call the proper functions given the configuration (install, upgrade, remove)
if [ -r $DOTFAIRY_ROOT_DIR/lib/main.sh ]; then
    . $DOTFAIRY_ROOT_DIR/lib/main.sh
else
    echo "Cannot find main.sh, have you correctly defined your root directory?"
    exit 128
fi
