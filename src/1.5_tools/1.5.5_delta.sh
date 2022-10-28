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

package_name()
{
    local PACKAGE="git-delta"

    if command -v choco >/dev/null 2>&1; then
        PACKAGE="delta"
    elif command -v scoop >/dev/null 2>&1; then
        PACKAGE="delta"
    elif command -v brew >/dev/null 2>&1; then
        PACKAGE="delta"
    fi
    echo $PACKAGE
}

install()
{
    is_installed $(package_name)
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
    if [ "$(grep "delta" $HOME/.gitconfig)" = "" ];then
       info "Init delta config."
       cat >$HOME/.gitconfig<<EOF
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only --features=interactive

[delta]
    features = decorations

[delta "interactive"]
    keep-plus-minus-markers = false

[delta "decorations"]
    commit-decoration-style = blue ol
    commit-style = raw
    file-style = omit
    hunk-header-decoration-style = blue box
    hunk-header-file-style = red
    hunk-header-line-number-style = "#067a00"
    hunk-header-style = file line-number syntax
EOF
    fi
}

upgrade()
{
    upgrade_package $(package_name)
}

remove()
{
    remove_package $(package_name)
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
