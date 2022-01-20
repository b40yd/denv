#!/bin/bash
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
install()
{
    is_installed ccls
    if [ $FNRET = 1 ]; then
        install_package ccls
    else
        if [ $FNRET = 1 ]; then
            crit "ccls install failed."
        else
            ok "ccls installed."
        fi
    fi

    is_installed cmake
    if [ $FNRET = 1 ]; then
        install_package cmake
    else
        if [ $FNRET = 1 ]; then
            crit "cmake install failed."
        else
            ok "cmake installed."
        fi
    fi

    is_installed gcc
    if [ $FNRET = 1 ]; then
        install_package gcc
    else
        if [ $FNRET = 1 ]; then
            crit "gcc install failed."
        else
            ok "gcc installed."
        fi
    fi

    is_installed clang
    if [ $FNRET = 1 ]; then
        install_package clang
    else
        if [ $FNRET = 1 ]; then
            crit "clang install failed."
        else
            ok "clang installed."
        fi
    fi

}

upgrade()
{
    upgrade_package ccls
    upgrade_package cmake
    upgrade_package gcc
    upgrade_package clang

}

remove()
{
    remove_package ccls
    remove_package cmake
    remove_package gcc
    remove_package clang
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
