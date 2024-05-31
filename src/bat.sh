#!/usr/bin/env sh

package_name()
{
    local PACKAGE="bat"

    if command -v emerge >/dev/null 2>&1; then
        PACKAGE="sys-apps/bat"
    fi
    echo $PACKAGE
}

. $(dirname "$0")/.main.sh
