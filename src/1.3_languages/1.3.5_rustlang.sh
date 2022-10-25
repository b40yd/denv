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
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD rustup toolchain add nightly
        else
            $SUDO_CMD rustup toolchain add nightly > $OUTPUT 2>&1
        fi

        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD rustup component add rust-src rustc-dev llvm-tools-preview
        else
            $SUDO_CMD rustup component add rust-src rustc-dev llvm-tools-preview > $OUTPUT 2>&1
        fi

        if [ $? != 0 ]; then
            crit "rust-src install failed."
            FNRET=1
        else
            ok "rust-src installed."
            is_installed racer
            if [ $FNRET = 1 ]; then
                if [ $VERBOSE -eq 1 ]
                then
                    $SUDO_CMD cargo +nightly install racer
                else
                    $SUDO_CMD cargo +nightly install racer > $OUTPUT 2>&1
                fi
                if [ $? != 0 ]; then
                    crit "racer install failed."
                    FNRET=1
                else
                    ok "racer installed."
                    is_installed rust-analyzer
                    if [ $FNRET = 1 ]; then
                        install_package rust-analyzer
                    fi
                fi
            fi
        fi
    fi
}

install()
{
    is_installed rustup
    if [ $FNRET = 1 ]; then
        curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
        if [ $? != 0 ]; then
            crit "rustup install failed."
        else
            ok "rustup installed."
            setup-rustup-toolchain
        fi
    fi
}

upgrade()
{
    is_installed rustup
    if [ $FNRET = 0 ]; then
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD rustup update
        else
            $SUDO_CMD rustup update > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            crit "rustup upgrade failed."
            FNRET=1
        else
            ok "rustup upgraded."
            upgrade_package rust-analyzer
        fi
    else
        crit "rustup not installed."
        FNRET=1
    fi
}

remove()
{
    is_installed rustup
    if [ $FNRET = 0 ]; then

        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD rustup self uninstall
        else
            $SUDO_CMD rustup self uninstall >$OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            crit "rustup remove failed."
            FNRET=1
        else
            ok "rustup removed."
            remove_package rust-analyzer
        fi
    fi
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
