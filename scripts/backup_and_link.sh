#!/bin/bash

function backup_and_link() {
    if [ $# -eq 0 ]; then
        echo "[ERROR] You need to specify a config path"
        echo "Usage: backup_and_link.sh <config>"
        exit 1
    fi

    config_path=$1
    if ! [ -d $config_path ]; then
        echo "[ERROR] No config path for $config_path"
        exit 1
    fi

    config_files="$config_path/*"
    for filename in $config_files; do
        if [[ "$filename" == *"mac."* ]] && [ "$DOTFILES_TARGET" != "MACOS" ]; then
            continue
        fi

        source="$(pwd)/$filename"
        target="$HOME/.${filename##*/}"

        if [[ -e $target ]]; then
            if [[ -L $target ]]; then
                echo "[INFO] Deleting existing linked file: $target -> $(realpath $target)"
                rm $target
            else
                echo "[INFO] Backing up existing file: $target"
                mv $target ${target}.`date "+%Y%m%d%H%M%S"`.backup
            fi
        fi

        echo "[INFO] Linking config file: $source -> $target"
        ln -s $source $target
    done
}