#!/usr/bin/env sh

package_name(){
    echo "python3"
}

install_python()
{
    is_installed $(package_name)
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
}

install_pip()
{
    is_installed pip
    if [ $FNRET = 1 ]; then
        if [ $VERBOSE -eq 1 ]
        then
            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        else
            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py > $LOG_OUTPUT 2>&1
        fi
        if [ $? = 0 ]; then
            crit "download get-pip.py failed."
        else
            is_installed $(package_name)
            if [ $FNRET = 1 ]; then
                crit "Frist must be install python3."
            fi
            if [ $VERBOSE -eq 1 ]
            then
                python3 get-pip.py
            else
                python3 get-pip.py > $LOG_OUTPUT 2>&1
            fi

            if [ $? != 0 ]; then
                crit "pip install failed."
            else
                ok "pip installed."
            fi
        fi
    else
        ok "pip installed."
    fi
}

install()
{
    is_installed pyenv
    if [ $FNRET = 1 ]; then
        install_package pyenv
        local env_variable=`grep ".pyenv" $HOME/.zshrc`
        if [ "$env_variable" = "" ]; then
            cat >> $HOME/.zshrc <<EOF
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init --path)"
eval "\$(pyenv init -)"
EOF
        fi
    else
        ok "pyenv installed."
    fi
    install_python
    install_pip
}

. $(dirname "$0")/.main.sh
