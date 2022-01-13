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
install_nodejs()
{
    is_installed node
    if [ $FNRET = 1 ]; then
        install_package nodejs
    else
        if [ $FNRET = 1 ]; then
            crit "nodejs install failed."
        else
            ok "nodejs installed."
        fi
    fi
}

install()
{
    install_nodejs
    npm_install bash-language-server
    npm_install typescript-language-server
    npm_install vscode-json-languageserver
    is_installed mmdc
    if [ $FNRET = 1 ]; then
        npm_install @mermaid-js/mermaid-cli
    else
        ok "@mermaid-js/mermaid-cli installed."
    fi
    npm_install vscode-css-languageserver-bin
    npm_install vscode-html-languageserver-bin

}

upgrade()
{
    upgrade_package nodejs
    npm_update bash-language-server
    npm_update typescript-language-server
    npm_update vscode-json-languageserver
    npm_update @mermaid-js/mermaid-cli
    npm_update vscode-css-languageserver-bin
    npm_update vscode-html-languageserver-bin
}

remove()
{

    npm_uninstall vscode-html-languageserver-bin
    npm_uninstall vscode-css-languageserver-bin
    npm_uninstall @mermaid-js/mermaid-cli
    npm_uninstall vscode-json-languageserver
    npm_uninstall typescript-language-server
    npm_uninstall bash-language-server
    remove_package nodejs
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
