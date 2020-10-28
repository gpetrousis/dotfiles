#!/bin/bash -e

source $(dirname $0)/common.sh

files_to_exclude=("Makefile README.md")

echo "[INFO] Using $config_path as ConfigPath"

config_files="$config_path/*"

for file in $config_files; do
    filename=$(basename $file)

    if [[ " ${files_to_exclude[@]} " =~ " ${filename} " ]]; then
        echo "[INFO] Skipping $filename"
        continue
    fi

    if [[ "$filename" == *"mac."* ]] && [ "$DOTFILES_TARGET" != "MACOS" ]; then
        continue
    fi

    source="$config_path/$filename"

    [[ $skip_dot -eq 1 ]] && target="$target_base/$filename" || target="$target_base/.$filename"

    if [[ -e $target ]]; then
        if [[ -L $target ]]; then
            echo "[INFO] Deleting existing linked file: $target -> $(realpath $target)"
            rm "$target"
        else
            echo "[INFO] Backing up existing file: $target"
            mv "$target" "$target.$(date "+%Y%m%d%H%M%S").backup"
        fi
    fi

    echo "[INFO] Linking config file: $source -> $target"
    ln -s "$source" "$target"
done