#!/bin/bash -e
set -o errexit
set -o nounset
set -o pipefail

readonly script_name="${0##*/}"

function usage {
    cat <<USAGE_TEXT
Usage: ${script_name} [-h] [-c <ARG>] [-s] [-t <ARG>]
DESCRIPTION:
    Delete the symbolic links from the target path that
    are pointing to the files in the Config Path.

    OPTIONS:
    -h
            Print this help and exit.
    -s
            Skip dot. Do not add a dot in front of the config files when linkins (Default: 0)
    -t
            The target base path (Default: Home dir)
    -c
            The path within the dotfiles structure to handle the files. (Default: Current dir)

USAGE_TEXT
}

parse_options() {
    config_path=$(pwd)
    target_base=$HOME
    skip_dot=0
    while getopts "hc?st:" opt; do
        case "$opt" in
        h|\?)
            usage
            exit 0
            ;;
        c)  config_path=$(realpath "$OPTARG")
            ;;
        s)  skip_dot=1
            ;;
        t)  target_base=$OPTARG
            ;;
        esac
    done

    shift "$((OPTIND-1))"
}

die() {
    local -r msg="${1}"
    local -r code="${2:-90}"
    echo "${msg}" >&2
    exit "${code}"
}

parse_options

if ! [[ -d $config_path ]]; then
    die "[ERROR] No config path found for $config_path" "1"
fi

echo "[INFO] Using $config_path as ConfigPath"

readonly config_files="$config_path/*"

for file in $config_files; do
    filename=$(basename "$file")
    source="$config_path/$filename"
    [[ $skip_dot -eq 1 ]] && target="$target_base/$filename" || target="$target_base/.$filename"

    if [[ -e $target ]] && [[ -L $target ]] && [[ "$(realpath "$target")" == "$source" ]]; then
        echo "[INFO] Deleting linked file: $target -> $(realpath "$target")"
        rm "$target"
    fi
done