#!/bin/env bash
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
LONG_SCRIPT_NAME=$(basename $0)
SCRIPT_NAME=${LONG_SCRIPT_NAME%.sh}
SUDO_CMD=""
forcedstatus=""

[ -r $DOTFAIRY_ROOT_DIR/lib/common.sh     ] && . $DOTFAIRY_ROOT_DIR/lib/common.sh
[ -r $DOTFAIRY_ROOT_DIR/lib/utils.sh      ] && . $DOTFAIRY_ROOT_DIR/lib/utils.sh

info "Working on $SCRIPT_NAME"

# Arguments parsing
while [[ $# > 0 ]]; do
    ARG="$1"
    case $ARG in
        --install)
            debug "Install argument detected, setting status to install"
            forcedstatus=install
            ;;
        --upgrade)
            debug "Upgrade all specified, setting status to upgrade  of configuration"
            forcedstatus=upgrade
            ;;
        --remove)
            debug "Remove all specified, setting status to remove_all  of configuration"
            forcedstatus=remove
            ;;
        --sudo)
            SUDO_CMD="sudo -n"
            ;;
        *)
            debug "Unknown option passed"
            ;;
    esac
    shift
done

case $forcedstatus in
    install )
        install
        exit $FNRET
        ;;
    upgrade )
        upgrade
        exit $FNRET
        ;;
    remove )
        remove
        exit $FNRET
        ;;
    nonexistent)
        no_entity "Check ${SCRIPT_NAME} is nonexistent "
        exit 3
        ;;
    *)
        warn "Wrong value for status : $status. Must be [ install | upgrade | remove ]"
        ;;
esac
