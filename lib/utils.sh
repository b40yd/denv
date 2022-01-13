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

brew_install()
{
    local PACKAGE=$1
    brew install $PACKAGE
    if [ $? = 0 ]; then
        FNRET=0
    else
        FNRET=1
    fi
}

brew_uninstall()
{
    local PACKAGE=$1
    brew uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

brew_upgrade()
{
    local PACKAGE=$1
    brew upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}


apt_install()
{
    local PACKAGE=$1
    DEBIAN_FRONTEND='noninteractive' apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install $PACKAGE -y
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

apt_uninstall()
{
    local PACKAGE=$1
    apt-get -y purge --autoremove $PKGNAME
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

apt_upgrade()
{
    local PACKAGE=$1
    apt-get -y upgrade $PKGNAME
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

yum_install()
{
    local PACKAGE=$1
    yum install -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}
yum_uninstall()
{
    local PACKAGE=$1
    yum -y autoremove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

yum_upgrade()
{
    local PACKAGE=$1
    yum -y upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_install()
{
    local PACKAGE=$1
    pacman --noconfirm -Syy $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_uninstal()
{
    local PACKAGE=$1
    pacman --noconfirm -R $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

pacman_upgrade()
{
    local PACKAGE=$1
    pacman --noconfirm -Syu $PACKAGE
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

install_package()
{
    local PACKAGE=$1
    if command -v brew >/dev/null 2>&1; then
        brew_install $PACKAGE

    elif command -v yum >/dev/null 2>&1; then
        yum_install $PACKAGE
    elif command -v apt-get >/dev/null 2>&1; then
        apt_install $PACKAGE
    elif command -v pacman >/dev/null 2>&1; then
        pacman_install $PACKAGE
    else
        echo "Not found software installer."
        FNRET=1
    fi
    if [ $FNRET = 1 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

port_install()
{
    local PACKAGE=$1
    port install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

port_upgrade()
{
    local PACKAGE=$1
    port upgrade $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

port_uninstall()
{
    local PACKAGE=$1
    port uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

choco_install()
{
    local PACKAGE=$1
    choco install -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}


choco_upgrade()
{
    local PACKAGE=$1
    choco upgrade -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

choco_uninstall()
{
    local PACKAGE=$1
    choco uninstall -y $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_install()
{
    local PACKAGE=$1
    scoop install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_upgrade()
{
    local PACKAGE=$1
    scoop update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

scoop_uninstall()
{
    local PACKAGE=$1
    scoop uninstall $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

emerge_install()
{
    local PACKAGE=$1
    emerge $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

emerge_upgrade()
{
    local PACKAGE=$1
    emerge -puv $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}
emerge_uninstall()
{
    local PACKAGE=$1
    emerge -C $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_install()
{
    local PACKAGE=$1
    dnf -y install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_upgrade()
{
    local PACKAGE=$1
    dnf -y update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

dnf_uninstall()
{
    local PACKAGE=$1
    dnf -y remove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_install()
{
    local PACKAGE=$1
    zypper --non-interactive install $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_upgrade()
{
    local PACKAGE=$1
    zypper --non-interactive update $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}

zypper_uninstall()
{
    local PACKAGE=$1
    zypper --non-interactive remove $PACKAGE
    if [ $? != 0 ]; then
        FNRET=1
    else
        FNRET=0
    fi
}
