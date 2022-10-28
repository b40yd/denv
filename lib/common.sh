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

# Script and shell commands homogeneity
export LANG=C
declare -x OUTPUT_SYMBOL=${OUTPUT_SYMBOL:-"#"}
declare -x OUTPUT_LEN=${OUTPUT_LEN:-"70"}

#### Useful Color constants settings for loglevels

# Reset Color (for syslog)
NC='\033[0m'
WHITE='\033[0m'
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GRAY='\033[0;40m'        # Gray

# Bold
BRED='\033[1;31m'         # Red
BGREEN='\033[1;32m'       # Green
BYELLOW='\033[1;33m'      # Yellow
BWHITE='\033[1;37m'       # White

#
# File Backup functions
#
backup_file() {
    FILE=$1
    if [ ! -f $FILE ]; then
        crit "Cannot backup $FILE, it's not a file"
        FNRET=1
    else
        TARGET=$(echo $FILE | sed -s -e 's/\//./g' -e 's/^.//' -e "s/$/.$(date +%F-%H_%M_%S)/" )
        TARGET="$BACKUPDIR/$TARGET"
        debug "Backuping $FILE to $TARGET"
        cp -a $FILE $TARGET
        FNRET=0
    fi
}


#
# Logging functions
#

case $LOGLEVEL in
    error )
        MACHINE_LOG_LEVEL=1
        ;;
    warning )
        MACHINE_LOG_LEVEL=2
        ;;
    ok )
        MACHINE_LOG_LEVEL=3
        ;;
    info )
        MACHINE_LOG_LEVEL=4
        ;;
    debug )
        MACHINE_LOG_LEVEL=5
        ;;
    *)
        MACHINE_LOG_LEVEL=4 ## Default loglevel value to info
esac

_logger() {
    COLOR=$1
    shift
    test -z "$SCRIPT_NAME" && SCRIPT_NAME=$(basename $0)
    builtin echo "$*" | /usr/bin/logger -t "[CIS_Hardening] $SCRIPT_NAME" -p "user.info"
    SCRIPT_NAME_FIXEDLEN=$(printf "%-25.25s" "$SCRIPT_NAME")
    cecho $COLOR "$SCRIPT_NAME_FIXEDLEN $*"
}

cecho () {
    COLOR=$1
    shift
    builtin echo -e "${COLOR}$*${NC}"
}

crit () {
    if [ $MACHINE_LOG_LEVEL -ge 1 ]; then _logger $BRED "[ KO ] $*"; fi
    SCRIPT_NUMBER=($(grep -Eo '^[0-9.]+' <<< $(echo $SCRIPT_NAME)))
    if [ -f $INSTALL_FAILED_LOG ]; then
        if [ "$(grep ${SCRIPT_NUMBER[0]}  $INSTALL_FAILED_LOG)" = "" ]; then
            $(echo ${SCRIPT_NUMBER[0]} >> $INSTALL_FAILED_LOG)
        fi
    else
        $(echo ${SCRIPT_NUMBER[0]} >> $INSTALL_FAILED_LOG)
    fi

    # This variable incrementation is used to measure failure or success in tests
    CRITICAL_ERRORS_NUMBER=$((CRITICAL_ERRORS_NUMBER+1))
}

no_entity() {
    if [ $MACHINE_LOG_LEVEL -ge 1 ]; then _logger $BGREEN "[ none entity, so it's not scored ] $*"; fi
    # This variable incrementation is used to measure whether the service exists in tests
    NONEXISTENT_NUMBER=$((NONEXISTENT_NUMBER+1))
}

warn () {
    if [ $MACHINE_LOG_LEVEL -ge 2 ]; then _logger $BYELLOW "[WARN] $*"; fi
}

ok () {
    if [ $MACHINE_LOG_LEVEL -ge 3 ]; then _logger $BGREEN "[ OK ] $*"; fi
}

info () {
    if [ $MACHINE_LOG_LEVEL -ge 4 ]; then _logger ''      "[INFO] $*"; fi
}

debug () {
    if [ $MACHINE_LOG_LEVEL -ge 5 ]; then _logger $GRAY "[DBG ] $*"; fi
}

# output string
# like python "test".center(10,'=')
#     ===test===
# center 10 "test" "="
#     ===test===
center(){
    local length=$1
    local format_str=$2
    local format_template="%-${#format_str}s"
    local symbol_len=0
    if [ "${#3}" != "0" ]; then
        OUTPUT_SYMBOL="$3"
    fi
    if [ "${#format_str}" -le "${length}" ]; then
        symbol_len=$((($length-${#format_str})/2))
        for i in `seq 1 ${symbol_len}`; do
            printf "%-1s" "${OUTPUT_SYMBOL}"
        done
        printf "${format_template}" "${format_str}"
        for i in `seq 1 ${symbol_len}`; do
            printf "%-1s" "${OUTPUT_SYMBOL}"
        done
        printf "\n"
    else
        printf "${format_template}\n" "${format_str}"
    fi
}
