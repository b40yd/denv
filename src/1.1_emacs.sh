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
    is_installed emacs
    if [ $FNRET = 1 ]; then
        if command -v brew >/dev/null 2>&1; then
            brew_install emacs
        elif command -v yum >/dev/null 2>&1; then
            yum_install emacs
        elif command -v apt-get >/dev/null 2>&1; then
            apt_install emacs
        elif command -v pacman >/dev/null 2>&1; then
            pacman_install emacs
        elif command -v port >/dev/null 2>&1; then
            port_install emacs
        elif command -v choco >/dev/null 2>&1; then
            choco_install emacs
        elif command -v dnf >/dev/null 2>&1; then
            dnf_install emacs
        elif command -v emerge >/dev/null 2>&1; then
            emerge_install emacs
        elif command -v zypper >/dev/null 2>&1; then
            zypper_install emacs
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
        brew_upgrade emacs
    elif command -v yum >/dev/null 2>&1; then
        yum_upgrade emacs
    elif command -v apt-get >/dev/null 2>&1; then
        apt_upgrade emacs
    elif command -v pacman >/dev/null 2>&1; then
        pacman_upgrade emacs
    elif command -v port >/dev/null 2>&1; then
        port_upgrade emacs
    elif command -v choco >/dev/null 2>&1; then
        choco_upgrade emacs
    elif command -v dnf >/dev/null 2>&1; then
        dnf_upgrade emacs
    elif command -v emerge >/dev/null 2>&1; then
        emerge_upgrade emacs
    elif command -v zypper >/dev/null 2>&1; then
        zypper_upgrade emacs
    else
        crit "Not found software installer."
        FNRET=1
    fi
    FNRET=$FNRET
}

remove()
{
    if command -v brew >/dev/null 2>&1; then
        brew_uninstall emacs
    elif command -v yum >/dev/null 2>&1; then
        yum_uninstall emacs
    elif command -v apt-get >/dev/null 2>&1; then
        apt_uninstall emacs
    elif command -v pacman >/dev/null 2>&1; then
        pacman_uninstall emacs
    elif command -v port >/dev/null 2>&1; then
        port_uninstall emacs
    elif command -v choco >/dev/null 2>&1; then
        choco_uninstall emacs
    elif command -v dnf >/dev/null 2>&1; then
        dnf_uninstall emacs
    elif command -v emerge >/dev/null 2>&1; then
        emerge_uninstall emacs
    elif command -v zypper >/dev/null 2>&1; then
        zypper_uninstall emacs
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
