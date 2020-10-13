#!/bin/bash

function remove_links() {
    if [ $# -eq 0 ]; then
        echo "[ERROR] You need to specify a config path"
        echo "Usage: remove_links.sh <config>"
    fi 

    config_path=$1
    if ! [ -d $config_path ]; then
        echo "[ERROR] No config path for $config_path"
        exit
    fi

    config_files="$config_path/*"
    for filename in $config_files; do
        source="$(pwd)/$filename"
        target="$HOME/.${filename##*/}"

        if [ -e $target ] && [ -L $target ] && [ "$(realpath $target)" == "$source" ]; then
            echo "[INFO] Deleting linked file: $target -> $(realpath $target)"
            rm $target
        fi
    done
}