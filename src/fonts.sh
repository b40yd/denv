#!/usr/bin/env sh

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
        if [ $VERBOSE -eq 1 ]; then
            git clone https://gitlab.com/b40yd/fonts.git $FONTS
        else
            git clone https://gitlab.com/b40yd/fonts.git $FONTS > $LOG_OUTPUT 2>&1
        fi

        if [ $? != 0 ]; then
            crit "git clone https://gitlab.com/b40yd/fonts failed."
            FNRET=1
        fi
    else
        pushd $FONTS > $LOG_OUTPUT 2>&1
        if [ $VERBOSE -eq 1 ]; then
            git pull
        else
            git pull > $LOG_OUTPUT 2>&1
        fi
        if [ $? != 0 ]; then
            crit "git pull https://gitlab.com/b40yd/fonts failed."
            FNRET=1
        fi
        popd > $LOG_OUTPUT 2>&1
    fi

    if [ "$FNRET" != "0" ]; then
        return
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

. $(dirname "$0")/main.sh
