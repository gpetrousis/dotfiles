#!/bin/bash -e

function usage {
    echo "Usage:"
    echo "  $0 [options]"
    echo "      -c <config_path>     The path within the dotfiles structure to handle the files. (Default: Current dir)"
    echo "      -s                   Skip dot. Do not add a dot in front of the config files when linkins (Default: 0)"
    echo "      -t <target_base>     The target base path (Default: Home dir)"
    echo "      -h                   Print this message"
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
    echo "[ERROR] No config path found for $config_path"
    exit 1
fi