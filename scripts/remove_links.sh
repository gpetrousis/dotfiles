#!/bin/bash -e
set -o errexit
set -o nounset
set -o pipefail

die() {
    local -r msg="${1}"
    local -r code="${2:-90}"
    echo "${msg}" >&2
    exit "${code}"
}

readonly conf_file="$(dirname $0)/common.sh"

if [[ ! -f "${conf_file}" ]]; then
    die "[ERROR] eading configuration file: ${conf_file}" "3"
fi
. "${conf_file}"

echo "[INFO] Using $config_path as ConfigPath"

readonly config_files="$config_path/*"

for file in $config_files; do
    filename=$(basename $file)
    source="$config_path/$filename"
    [[ $skip_dot -eq 1 ]] && target="$target_base/$filename" || target="$target_base/.$filename"

    if [[ -e $target ]] && [[ -L $target ]] && [[ "$(realpath $target)" == "$source" ]]; then
        echo "[INFO] Deleting linked file: $target -> $(realpath $target)"
        rm "$target"
    fi
done