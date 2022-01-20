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

SYSTEM_TYPE=`uname -s`

fonts_path()
{
    local os_fonts_path="/usr/share/fonts"
    if [ "$SYSTEM_TYPE" = "Darwin" ]; then
        os_fonts_path="${HOME}/Library/Fonts"
    fi
    echo $os_fonts_path
}

install()
{
    local FONTS="/tmp/fonts"
    if [ ! -d $FONTS ]; then
        git clone https://gitlab.com/7ym0n/fonts.git $FONTS
        if [ $? != 0 ]; then
            crit "git clone https://gitlab.com/7ym0n/fonts failed."
            return
        fi
    else
        pushd $FONTS
        git pull
        if [ $? != 0 ]; then
            crit "git pull https://gitlab.com/7ym0n/fonts failed."
            return
        fi
        popd
    fi
    # find $FONTS -type f -name "*tf" -o -name "*ttc" | xargs -I {} cp -rfv {} .
    files=$(find $FONTS -type f -name "*tf" -o -name "*ttc")
    if [ $? = 0 ]; then
        for f in $files
        do
            local os_font_file=$(fonts_path)/${f##*/}
            if [ ! -f $os_font_file ]; then
                cp -rfv $f $os_font_file
                if [ $? = 0 ]; then
                    ok "$os_font_file installed."
                fi
            else
                ok "$os_font_file installed."
            fi
        done
    fi
    if [ "$SYSTEM_TYPE" = "Linux" ]; then
        $SUDO_CMD fc-cache -f -v
    fi
}

upgrade()
{
    warn "You need manual upgrade fonts."
}

remove()
{
    warn "You need manual remove fonts."
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
