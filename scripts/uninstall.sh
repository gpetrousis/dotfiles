#!/bin/bash -e
set -o errexit
set -o nounset
set -o pipefail

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source $SCRIPTPATH/common.sh

function uninstall_vim() {
    echo "[INFO] Removing linked files"
	./scripts/remove_links.sh -p $platform -c vim
	echo "[INFO] Deleting vim folder"
	rm -rf ./vim/vim
}

function uninstall_zsh() {
	echo "[INFO] Removing linked files"
	./scripts/remove_links.sh -p $platform -c zsh
}

function uninstall_vscode() {
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

    ./scripts/remove_links.sh -p $platform -c vscode -s -t $target_base
}

for config in ${configs[@]}; do
    case $config in
    zsh)
        echo "[INFO] Uninstalling zsh"
        uninstall_zsh
        ;;
    vim)
        echo "[INFO] Uninstalling vim"
        uninstall_vim
        ;;
    vscode)
        echo "[INFO] Uninstalling vscode"
        uninstall_vscode
        ;;
    esac
done
