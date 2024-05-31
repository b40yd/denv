#!/usr/bin/env sh

package_name(){
    echo "openjdk"
}

install()
{
    is_installed java
    if [ $FNRET = 1 ]; then
        install_package $(package_name)
    else
        ok "$(package_name) installed."
    fi
    warn "maven package manager, you need manual download https://maven.apache.org/download.cgi"
    warn "setting your shell environment variable. \nexport MAVEN_HOME=/usr/local/apache-maven-\${version}
export PATH=\$PATH:/Users/admin/repos/go/bin:\${MAVEN_HOME}/bin"
}

. $(dirname "$0")/.main.sh
