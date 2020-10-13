#!/bin/bash

source ./scripts/backup_and_link.sh
source ./scripts/remove_links.sh

function usage(){
    echo "Usage: vim.sh <install|uninstall>"
}

if [ $# -eq 0 ]; then
    echo "[ERROR] You need to specify an action"
    usage
    exit 1
fi

action=$1

if [[ "$action" == "install" ]]; then
    echo "[INFO] Creating vim directories"
    mkdir -p ./vim/vim/plugged
    mkdir -p ./vim/vim/files/swap
    mkdir -p ./vim/vim/files/backup
    mkdir -p ./vim/vim/files/undo

    backup_and_link "vim"

    echo "[INFO] Installing vim-plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo "[INFO] Installing vim plugins"
    vim +silent +PlugInstall +qall 

    # vim -e -v -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"

elif [[ "$action" == "uninstall" ]]; then
    echo "[INFO] Removeing linked files"
    remove_links "vim"
    echo "[INFO] Deleting vim folder"
    rm -rf ./vim/vim
    exit 0
else
    echo "[ERROR] Invalid action"
    usage
    exit 1
fi
