#!/bin/bash

source ./scripts/configs.sh

function uninstall() {
    for config_path in ${configs[@]}; do
        if [ -d $config_path ]; then
            config_files="$config_path/*"
            for filename in $config_files; do
                source="$(pwd)/$filename"
                target="$HOME/.${filename##*/}"

                if [ -e $target ] && [ -L $target ] && [ "$(realpath $target)" == "$source" ]; then
                    echo "[INFO] Deleting linked file: $target -> $(realpath $target)"
                    rm $target
                fi
            done
        fi
    done
}

uninstall