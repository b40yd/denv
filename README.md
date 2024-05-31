# denv
development environment install by shell.
# Introduce
## Support
For MacOS:
- brew
- port

For Linux:
- apt-get
- yum
- pacman
- dnf
- emerge
- zypper

For Windows:
- scoop
- choco

## Tools
- Emacs
- git
- ripgrep
- fd
- zenity (color picker)

## Environment
- Java
- Golang
- C
- Python
- Rust
- Web development

# Usage
## Download
```
git clone https://github.com/7ym0n/denv.git &&cd denv
```
## Configure
Set shell environment variable.
``` shell
alias cp="cp -i"
alias rm="trash"
alias cat="bat"
```

## Install
All software and environment dependent install. `--sudo` allows sudo
escalation to access to root files.
```
bash denv --install --sudo
```
Specify the installation environment.
```
bash denv --install --only emacs --sudo
```

## Upgrade
All software and environment dependent upgrade.
```
bash denv --upgrade --sudo
```
Specify the upgrade environment.
```
bash denv --upgrade --only emacs --sudo
```

## Remove
All software and environment dependent remove.
```
bash denv --remove --sudo
```
Specify the remove environment.
```
bash denv --remove --only emacs --sudo
```
