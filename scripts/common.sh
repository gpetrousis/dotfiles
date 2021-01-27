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

function usage {
    cat <<USAGE_TEXT
Usage: ${0} [-h] [-c <ARG>] [-s] [-t <ARG>]
OPTIONS:
-h | -- help
        Print this help and exit.
-s
        Skip dot. Do not add a dot in front of the config files when linkins (Default: 0)
-t
        The target base path (Default: Home dir)
-c
        The path within the dotfiles structure to handle the files. (Default: Current dir)
USAGE_TEXT
}

config_path=$(pwd)
target_base=$HOME
skip_dot=0

while getopts "hc?st:" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;
    c)  config_path=$(realpath $OPTARG)
        ;;
    s)  skip_dot=1
        ;;
    t)  target_base=$OPTARG
        ;;
    esac
done

shift "$((OPTIND-1))"

if ! [[ -d $config_path ]]; then
    die "[ERROR] No config path found for $config_path" "1"
fi