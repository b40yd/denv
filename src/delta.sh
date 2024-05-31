#!/usr/bin/env sh

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

. $(dirname "$0")/main.sh
