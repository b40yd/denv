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

install_python()
{
    is_installed python3
    if [ $FNRET = 1 ]; then
        install_package python3
    else
        if [ $FNRET = 1 ]; then
            crit "python3 install failed."
        else
            ok "python3 installed."
        fi
    fi
}

install_pip()
{
    is_installed pip
    if [ $FNRET = 1 ]; then
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        is_installed python3
        if [ $FNRET = 1 ]; then
            crit "Frist must be install python3."
        else
            python3 get-pip.py
        fi
    else
        if [ $FNRET = 1 ]; then
            crit "pip install failed."
        else
            ok "pip installed."
        fi
    fi
}

install()
{
    install_python
    install_pip
    is_pip_installed python-language-server
    if [ $FNRET = 1 ]; then
        pip_install python-language-server[all]
    else
        ok "python-language-server installed."
    fi
    is_pip_installed yapf
    if [ $FNRET = 1 ]; then
        pip_install yapf
    else
        ok "yapf installed."
    fi
    is_pip_installed black
    if [ $FNRET = 1 ]; then
        pip_install black
    else
        ok "black installed."
    fi
}

upgrade()
{
    upgrade_package python3
}

remove()
{
    pip_uninstall black
    pip_uninstall yapf
    pip_uninstall python-language-server
    remove_package python3
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
