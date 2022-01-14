# devn
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
git clone https://github.com/7ym0n/devn.git &&cd devn
```
## Install
All software and environment dependent install. `--sudo` allows sudo
escalation to access to root files.
```
bash devn --install --sudo
```
Specify the installation environment.
```
bash devn --install --only 1.1.1 --sudo
```

## Upgrade
All software and environment dependent upgrade.
```
bash devn --upgrade --sudo
```
Specify the upgrade environment.
```
bash devn --upgrade --only 1.1.1 --sudo
```

## Remove
All software and environment dependent remove.
```
bash devn --remove --sudo
```
Specify the remove environment.
```
bash devn --remove --only 1.1.1 --sudo
```
