readonly AVAILABLE_CONFIGS="zsh vim vscode"
readonly AVAILABLE_PLATFORMS="linux mac picode"
all=0
configs=()

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

function fatal() {
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

parse_options "$@"

if ! is_valid_platform "$platform"; then
    fatal "[ERROR] Invalid platform. $platform is not in $AVAILABLE_PLATFORMS"
fi

if [[ $all -eq 0 ]] && [[ ${#configs[@]} -eq 0 ]]; then
    fatal "[ERROR] You need to specify either -a or a list of configs."
fi

if [[ $all -eq 1 ]]; then
    if ((${#configs[@]})); then
        fatal "[ERROR] Invalid arguments. Cannot use -a with specific configs."
    fi
    configs=( $AVAILABLE_CONFIGS )
fi