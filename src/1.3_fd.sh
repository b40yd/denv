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
    is_installed fd
    if [ $FNRET = 1 ]; then
        if command -v brew >/dev/null 2>&1; then
            brew_install fd
        elif command -v yum >/dev/null 2>&1; then
            yum_install fd
        elif command -v apt-get >/dev/null 2>&1; then
            apt_install fd
        elif command -v pacman >/dev/null 2>&1; then
            pacman_install fd
        elif command -v port >/dev/null 2>&1; then
            port_install fd
        elif command -v choco >/dev/null 2>&1; then
            choco_install fd
        elif command -v dnf >/dev/null 2>&1; then
            dnf_install fd
        elif command -v emerge >/dev/null 2>&1; then
            emerge_install fd
        elif command -v zypper >/dev/null 2>&1; then
            zypper_install fd
        else
            crit "Not found software installer."
            FNRET=1
        fi
    fi
    FNRET=$FNRET
}

upgrade()
{
    if command -v brew >/dev/null 2>&1; then
        brew_upgrade fd
    elif command -v yum >/dev/null 2>&1; then
        yum_upgrade fd
    elif command -v apt-get >/dev/null 2>&1; then
        apt_upgrade fd
    elif command -v pacman >/dev/null 2>&1; then
        pacman_upgrade fd
    elif command -v port >/dev/null 2>&1; then
        port_upgrade fd
    elif command -v choco >/dev/null 2>&1; then
        choco_upgrade fd
    elif command -v dnf >/dev/null 2>&1; then
        dnf_upgrade fd
    elif command -v emerge >/dev/null 2>&1; then
        emerge_upgrade fd
    elif command -v zypper >/dev/null 2>&1; then
        zypper_upgrade fd
    else
        crit "Not found software installer."
        FNRET=1
    fi
    FNRET=$FNRET
}

remove()
{
    if command -v brew >/dev/null 2>&1; then
        brew_uninstall fd
    elif command -v yum >/dev/null 2>&1; then
        yum_uninstall fd
    elif command -v apt-get >/dev/null 2>&1; then
        apt_uninstall fd
    elif command -v pacman >/dev/null 2>&1; then
        pacman_uninstall fd
    elif command -v port >/dev/null 2>&1; then
        port_uninstall fd
    elif command -v choco >/dev/null 2>&1; then
        choco_uninstall fd
    elif command -v dnf >/dev/null 2>&1; then
        dnf_uninstall fd
    elif command -v emerge >/dev/null 2>&1; then
        emerge_uninstall fd
    elif command -v zypper >/dev/null 2>&1; then
        zypper_uninstall fd
    else
        crit "Not found software installer."
        FNRET=1
    fi
    FNRET=$FNRET
}

if [ -z "$DOTFAIRY_ROOT_DIR" ]; then
    echo "Cannot source DOTFAIRY_ROOT_DIR variable, aborting."
    exit 128
fi

# Main function, will call the proper functions given the configuration (audit, enabled, disabled)
if [ -r $DOTFAIRY_ROOT_DIR/lib/main.sh ]; then
    . $DOTFAIRY_ROOT_DIR/lib/main.sh
else
    echo "Cannot find main.sh, have you correctly defined your root directory?"
    exit 128
fi
