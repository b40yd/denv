#!/usr/bin/env sh

install()
{
    is_installed ccls
    if [ $FNRET = 1 ]; then
        install_package ccls
    else
        ok "ccls installed."
    fi

    is_installed cmake
    if [ $FNRET = 1 ]; then
        install_package cmake
    else
        ok "cmake installed."
    fi

    is_installed gcc
    if [ $FNRET = 1 ]; then
        install_package gcc
    else
        ok "gcc installed."
    fi

    is_installed clang
    if [ $FNRET = 1 ]; then
        install_package clang
    else
        ok "clang installed."
    fi

}

upgrade()
{
    upgrade_package ccls
    upgrade_package cmake
    upgrade_package gcc
    upgrade_package clang

}

remove()
{
    remove_package ccls
    remove_package cmake
    remove_package gcc
    remove_package clang
}

. $(dirname "$0")/.main.sh
