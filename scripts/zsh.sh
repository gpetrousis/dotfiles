#!/bin/bash

source ./scripts/backup_and_link.sh
source ./scripts/remove_links.sh

function usage(){
    echo "Usage: zsh.sh <install|uninstall>"
}

if [ $# -eq 0 ]; then
    echo "[ERROR] You need to specify an action"
    usage
    exit 1
fi

action=$1

if [[ "$action" == "install" ]]; then
    backup_and_link "zsh"
elif [[ "$action" == "uninstall" ]]; then
    remove_links "zsh"
else
    echo "[ERROR] Invalid action"
    usage
    exit 1
fi
