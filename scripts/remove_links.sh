#!/bin/bash
config_path=$(pwd)

if ! [[ -z $1 ]]; then
    config_path=$(realpath $1)
fi

if ! [[ -d $config_path ]]; then
    echo "[ERROR] No config path found for $config_path"
    exit 1
fi

echo "[INFO] Using $config_path as ConfigPath"

config_files="$config_path/*"

for file in $config_files; do
    filename=$(basename $file)
    source="$config_path/$filename"
    target="$HOME/.$filename"
    echo "[INFO] Source: $source"
    echo "[INFO] Target: $target"

    if [[ -e $target ]] && [[ -L $target ]] && [[ "$(realpath $target)" == "$source" ]]; then
        echo "[INFO] Deleting linked file: $target -> $(realpath $target)"
        rm $target
    fi
done