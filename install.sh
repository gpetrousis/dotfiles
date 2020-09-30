#!/bin/bash

configs=("zsh")

function install() {
    for config_path in ${configs[@]}; do
        # echo $config_path
        if [ -d $config_path ]; then
            config_files="$config_path/*"
            for filename in $config_files; do
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

                ln -s $source $target
            done
        fi
    done
}

install