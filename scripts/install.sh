#!/bin/bash

source ./scripts/configs.sh

function install() {
    for config_path in ${configs[@]}; do
        if [ -d $config_path ]; then
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
        fi
    done
}

install