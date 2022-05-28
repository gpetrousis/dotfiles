#!/bin/bash -e
set -o errexit
set -o nounset
set -o pipefail

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source $SCRIPTPATH/common.sh

function usage() {
    readonly script_name="${0##*/}"

    cat <<USAGE_TEXT
Usage: ${script_name} [-h] [-p <platform>] [-a] <configs>
DESCRIPTION:
    Install the dotfiles for diffent applications.
    Supported configs: ZSH, Vim, VSCode/CodeServer
    
    Example:
    install.sh -p mac zsh vim

    OPTIONS:
    -h
            Print this help and exit.
    -p  <platform>
            Platform. Available options: linux, mac, picode (Default: linux)
    -a
            Install all the config files (zsh, vim, vscode)
USAGE_TEXT
}

function install_vim() {
	echo "[INFO] Creating vim directories"
	mkdir -p ./vim/vim/plugged
	mkdir -p ./vim/vim/files/swap
	mkdir -p ./vim/vim/files/backup
	mkdir -p ./vim/vim/files/undo

	echo "[INFO] Linking config files"
	./scripts/backup_and_link.sh -p $platform -c vim

	echo "[INFO] Installing vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	echo "[INFO] Installing vim plugins"
	vim +silent +PlugInstall +qall 
}

function install_zsh() {
    echo "[INFO] Linking config files"
	./scripts/backup_and_link.sh -p $platform -c zsh
}

function install_vscode() {
    echo "[INFO] Linking config files"
    case $platform in
    linux)
        target_base="$HOME/.config/Code/User"
        ;;
    mac)
        target_base="$HOME/Library/Application Support/Code/User"
        ;;
    picode)
        target_base="$HOME/.local/share/code-server/User"
        ;;
    esac

    ./scripts/backup_and_link.sh -p $platform -c vscode -s -t $target_base
}

for config in ${configs[@]}; do
    case $config in
    zsh)
        echo "[INFO] Installing zsh"
        install_zsh
        ;;
    vim)
        echo "[INFO] Installing vim"
        install_vim
        ;;
    vscode)
        echo "[INFO] Installing vscode"
        install_vscode
        ;;
    esac
done
