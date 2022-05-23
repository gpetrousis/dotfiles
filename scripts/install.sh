#!/bin/bash -e
set -o errexit
set -o nounset
set -o pipefail

readonly AVAILABLE_CONFIGS="zsh vim vscode"
readonly AVAILABLE_PLATFORMS="linux mac picode"
all=0
configs=()

function usage() {
    readonly script_name="${0##*/}"

    cat <<USAGE_TEXT
Usage: ${script_name} [-h] [-p <platform>] [-a] <configs>
DESCRIPTION:
    Install the dotfiles for diffent applications.
    Supported configs: ZSH, Vim, VSCode/CodeServer
    
    Example:
    install.sh -p mac zsh vim

    OPTIONS:
    -h
            Print this help and exit.
    -p  <platform>
            Platform. Available options: linux, mac, picode (Default: linux)
    -a
            Install all the config files (zsh, vim, vscode)
USAGE_TEXT
}

function parse_options() {
    local OPTIND opt

    platform="linux"
    while getopts "hp:a" opt; do
        case "$opt" in
        h|\?)
            usage
            exit 0
            ;;
        p)
            platform=${OPTARG}
            ;;
        a)  
            all=1
            ;;
        esac
    done

    shift "$((OPTIND-1))"

    while test $# -gt 0; do
        config=$1
        if ! is_valid_config "$config"; then
            die "Invalid config. $config is not in $AVAILABLE_CONFIGS"
        fi    
        configs+=( "$config" )
        shift
    done
}

function die() {
    local -r msg="${1}"
    local -r code="${2:-1}"
    echo "${msg}" >&2
    exit "${code}"
}

function is_valid_platform() {
    for available_platform in $AVAILABLE_PLATFORMS; do
        if [[ $1 == $available_platform ]]; then
            return 0
        fi
    done
    return 1
}

function is_valid_config() {
    for available_config in $AVAILABLE_CONFIGS; do
        if [[ $1 == $available_config ]]; then
            return 0
        fi
    done
    return 1
}

function install_vim() {
	echo "[INFO] Creating vim directories"
	mkdir -p ./vim/plugged
	mkdir -p ./vim/files/swap
	mkdir -p ./vim/files/backup
	mkdir -p ./vim/files/undo

	echo "[INFO] Linking config files"
	./scripts/backup_and_link.sh -c vim

	echo "[INFO] Installing vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	echo "[INFO] Installing vim plugins"
	vim +silent +PlugInstall +qall 
}

function install_zsh() {
    echo "[INFO] Linking config files"
	./scripts/backup_and_link.sh -c zsh
}

function install_vscode() {
    echo "[INFO] Linking config files"
    case $platform in
    linux)
        target_base="$HOME/.config/Code/User"
        ;;
    mac)
        target_base="$HOME/Library/Application Support/Code/User"
        ;;
    picode)
        target_base="$HOME/.local/share/code-server/User"
        ;;
    esac

    ./scripts/backup_and_link.sh -c vscode -s -t $target_base
}

parse_options "$@"

if ! is_valid_platform "$platform"; then
    die "[ERROR] Invalid platform. $platform is not in $AVAILABLE_PLATFORMS"
fi

if [[ $all -eq 0 ]] && [[ ${#configs[@]} -eq 0 ]]; then
    die "[ERROR] You need to specify either -a or a list of configs."
fi

if [[ $all -eq 1 ]]; then
    if ((${#configs[@]})); then
        die "[ERROR] Invalid arguments. Cannot use -a with specific configs."
    fi
    configs=( $AVAILABLE_CONFIGS )
fi


for config in ${configs[@]}; do
    case $config in
    zsh)
        echo "[INFO] Installing zsh"
        install_zsh
        ;;
    vim)
        echo "[INFO] Installing vim"
        install_vim
        ;;
    vscode)
        echo "[INFO] Installing vscode"
        install_vscode
        ;;
    esac
done
