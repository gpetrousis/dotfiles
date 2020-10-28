#!/bin/bash -e

source $(dirname $0)/common.sh

echo "[INFO] Using $config_path as ConfigPath"

config_files="$config_path/*"

for file in $config_files; do
    filename=$(basename $file)
    source="$config_path/$filename"
    [[ $skip_dot -eq 1 ]] && target="$target_base/$filename" || target="$target_base/.$filename"

    if [[ -e $target ]] && [[ -L $target ]] && [[ "$(realpath $target)" == "$source" ]]; then
        echo "[INFO] Deleting linked file: $target -> $(realpath $target)"
        rm "$target"
    fi
done