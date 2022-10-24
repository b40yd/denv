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

OS_PLATFORM=`uname -s`
OUTPUT="/tmp/denv.log"

brew_install()
{
    local PACKAGE=$1
    $SUDO_CMD brew install $PACKAGE
    if [ $? = 0 ]; then
        FNRET=0
    else
        FNRET=1
    fi
}

brew_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD brew uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

brew_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD brew upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}


apt_install()
{
    local PACKAGE=$1
    $SUDO_CMD apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install $PACKAGE -y
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

apt_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD apt-get -y purge --autoremove $PKGNAME
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

apt_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD apt-get -y upgrade $PKGNAME
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

yum_install()
{
    local PACKAGE=$1
    $SUDO_CMD yum install -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}
yum_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD yum -y autoremove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

yum_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD yum -y upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_install()
{
    local PACKAGE=$1
    $SUDO_CMD pacman --noconfirm -Syy $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_uninstal()
{
    local PACKAGE=$1
    $SUDO_CMD pacman --noconfirm -R $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD pacman --noconfirm -Syu $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}


is_installed()
{
    local CMD=$1
    if command -v $CMD >/dev/null 2>&1; then
        FNRET=0
    else
        FNRET=1
    fi
}

port_install()
{
    local PACKAGE=$1
    $SUDO_CMD port install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

port_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD port upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

port_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD port uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

choco_install()
{
    local PACKAGE=$1
    $SUDO_CMD choco install -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}


choco_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD choco upgrade -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

choco_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD choco uninstall -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_install()
{
    local PACKAGE=$1
    $SUDO_CMD scoop install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD scoop update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD scoop uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

emerge_install()
{
    local PACKAGE=$1
    $SUDO_CMD emerge $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

emerge_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD emerge -puv $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}
emerge_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD emerge -C $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_install()
{
    local PACKAGE=$1
    $SUDO_CMD dnf -y install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD dnf -y update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD dnf -y remove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_install()
{
    local PACKAGE=$1
    $SUDO_CMD zypper --non-interactive install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_upgrade()
{
    local PACKAGE=$1
    $SUDO_CMD zypper --non-interactive update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_uninstall()
{
    local PACKAGE=$1
    $SUDO_CMD zypper --non-interactive remove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

install_package()
{
    local PACKAGE=$1
    is_installed $PACKAGE
    if [ $FNRET = 1 ]; then
        if command -v brew >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                brew_install $PACKAGE
            else
                brew_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v yum >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                yum_install $PACKAGE
            else
                yum_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v apt-get >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                apt_install $PACKAGE
            else
                apt_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v pacman >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                pacman_install $PACKAGE
            else
                pacman_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v port >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                port_install $PACKAGE
            else
                port_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v choco >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                choco_install $PACKAGE
            else
                choco_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v dnf >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                dnf_install $PACKAGE
            else
                dnf_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v emerge >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                emerge_install $PACKAGE
            else
                emerge_install $PACKAGE > $OUTPUT 2>&1
            fi
        elif command -v zypper >/dev/null 2>&1; then
            if [ $VERBOSE -eq 1 ]
            then
                zypper_install $PACKAGE
            else
                zypper_install $PACKAGE > $OUTPUT 2>&1
            fi
        else
            crit "Not found software installer."
            FNRET=1
        fi
    fi

    if [ $FNRET = 1 ]; then
        crit "$PACKAGE install failed."
    else
        ok "$PACKAGE installed."
    fi
    FNRET=$FNRET
}

upgrade_package()
{
    local PACKAGE=$1
    if command -v brew >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            brew_upgrade $PACKAGE
        else
            brew_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v yum >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            yum_upgrade $PACKAGE
        else
            yum_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v apt-get >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            apt_upgrade $PACKAGE
        else
            apt_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v pacman >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            pacman_upgrade $PACKAGE
        else
            pacman_upgrade$PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v port >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            port_upgrade $PACKAGE
        else
            port_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v choco >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            choco_upgrade $PACKAGE
        else
            choco_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v dnf >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            dnf_upgrade $PACKAGE
        else
            dnf_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v emerge >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            emerge_upgrade $PACKAGE
        else
            emerge_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v zypper >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            zypper_upgrade $PACKAGE
        else
            zypper_upgrade $PACKAGE > $OUTPUT 2>&1
        fi
    else
        crit "Not found software installer."
        FNRET=1
    fi

    if [ $FNRET = 1 ]; then
        crit "$PACKAGE upgrade failed."
    else
        ok "$PACKAGE upgraded."
    fi
    FNRET=$FNRET
}

remove_package()
{
    local PACKAGE=$1
    if command -v brew >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            brew_uninstall $PACKAGE
        else
            brew_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v yum >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            yum_uninstall $PACKAGE
        else
            yum_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v apt-get >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            apt_uninstall $PACKAGE
        else
            apt_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v pacman >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            pacman_uninstall $PACKAGE
        else
            pacman_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v port >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            port_uninstall $PACKAGE
        else
            port_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v choco >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            choco_uninstall $PACKAGE
        else
            choco_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v dnf >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            dnf_uninstall $PACKAGE
        else
            dnf_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v emerge >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            emerge_uninstall $PACKAGE
        else
            emerge_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    elif command -v zypper >/dev/null 2>&1; then
        if [ $VERBOSE -eq 1 ]
        then
            zypper_uninstall $PACKAGE
        else
            zypper_uninstall $PACKAGE > $OUTPUT 2>&1
        fi
    else
        crit "Not found software installer."
        FNRET=1
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE remove failed."
    else
        ok "$PACKAGE removed."
    fi
    FNRET=$FNRET
}

npm_install()
{
    local PACKAGE=$1
    is_installed npm
    if [ $FNRET = 1 ]; then
        crit "First must be install nodejs npm."
    else
        debug "$SUDO_CMD npm install -g --registry https://registry.npm.taobao.org $PACKAGE"
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD npm install -g --registry=https://registry.npm.taobao.org $PACKAGE
        else
            $SUDO_CMD npm install -g --registry=https://registry.npm.taobao.org $PACKAGE > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            FNRET=0
        else
            FNRET=1
        fi
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE install failed."
    else
        ok "$PACKAGE installed."
    fi
}

npm_uninstall()
{
    local PACKAGE=$1
    is_installed npm
    if [ $FNRET = 1 ]; then
        crit "First must be install nodejs npm."
    else
        debug "$SUDO_CMD npm uninstall $PACKAGE -y"
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD npm uninstall $PACKAGE -y
        else
            $SUDO_CMD npm uninstall $PACKAGE -y > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            FNRET=0
        else
            FNRET=1
        fi
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE uninstall failed."
    else
        ok "$PACKAGE uninstalled."
    fi
}

npm_update()
{
    local PACKAGE=$1
    is_installed npm
    if [ $FNRET = 1 ]; then
        crit "First must be install nodejs npm."
    else
        debug "$SUDO_CMD npm update $PACKAGE"
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD npm update $PACKAGE
        else
            $SUDO_CMD npm update $PACKAGE > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            FNRET=0
        else
            FNRET=1
        fi
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE upgrade failed."
    else
        ok "$PACKAGE upgraded."
    fi
}

pip_install()
{
    local PACKAGE=$1
    is_installed pip
    if [ $FNRET = 1 ]; then
        crit "First must be install pip tools."
    else
        debug "$SUDO_CMD pip install -i https://mirrors.aliyun.com/pypi/simple/ $PACKAGE"
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD pip install -i https://mirrors.aliyun.com/pypi/simple/ $PACKAGE
        else
            $SUDO_CMD pip install -i https://mirrors.aliyun.com/pypi/simple/ $PACKAGE > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            FNRET=0
        else
            FNRET=1
        fi
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE install failed."
    else
        ok "$PACKAGE installed."
    fi
}

pip_uninstall()
{
    local PACKAGE=$1
    is_installed pip
    if [ $FNRET = 1 ]; then
        crit "First must be install pip tools."
    else
        debug "$SUDO_CMD pip uninstall $PACKAGE -y"
        if [ $VERBOSE -eq 1 ]
        then
            $SUDO_CMD pip uninstall $PACKAGE -y > $OUTPUT
        else
            $SUDO_CMD pip uninstall $PACKAGE -y > $OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            FNRET=0
        else
            FNRET=1
        fi
    fi
    if [ $FNRET = 1 ]; then
        crit "$PACKAGE uninstall failed."
    else
        ok "$PACKAGE uninstalled."
    fi
}

is_pip_installed()
{
    local PACKAGE=$1
    if pip3 show $PACKAGE >/dev/null 2>&1; then
        FNRET=0
    else
        FNRET=1
    fi
}
