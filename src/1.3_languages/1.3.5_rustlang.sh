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

setup-rustup-toolchain() {
    export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
    export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
    is_installed rustup
    if [ $FNRET = 1 ]; then
        crit "First must be install rustup."
    else
        $SUDO_CMD rustup toolchain add nightly
        $SUDO_CMD rustup component add rust-src
        if [ $? = 0 ]; then
            crit "rust-src install failed."
        else
            ok "rust-src installed."
        fi
        is_installed racer
        if [ $FNRET = 1 ]; then
            $SUDO_CMD cargo +nightly install racer
            if [ $? = 0 ]; then
                crit "racer install failed."
            else
                ok "racer installed."
            fi
        else
            ok "racer installed."
        fi
        is_installed rust-analyzer
        if [ $FNRET = 1 ]; then
            install_package rust-analyzer
        fi
    fi
}

install()
{
    is_installed rustup
    if [ $FNRET = 1 ]; then
        curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
        if [ $? = 0 ]; then
            crit "rustup install failed."
        else
            ok "rustup installed."
        fi
    fi

    setup-rustup-toolchain
}

upgrade()
{
    is_installed rustup
    if [ $FNRET = 0 ]; then
        $SUDO_CMD rustup update
    fi
    upgrade_package rust-analyzer
}

remove()
{
    is_installed rustup
    if [ $FNRET = 0 ]; then
        $SUDO_CMD rustup self uninstall
    fi
    remove_package rust-analyzer
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
