#!/usr/bin/env sh
# see https://www.passwordstore.org/
package_name()
{
    local PACKAGE="pass"

    if command -v zypper >/dev/null 2>&1; then
        PACKAGE="password-store"
    fi

    echo $PACKAGE
}

. $(dirname "$0")/.main.sh
