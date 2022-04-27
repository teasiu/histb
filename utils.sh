_exit() {
    exit_singal=$1
    shift
    echo $*
    exit $exit_singal
}

get_sha256() {
    case $1 in
    -c)
        shift
        wget -q $1 -O - | grep $2 | awk '{print $1}'
    ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        sha256sum $1 2> /dev/null | awk '{print $1}'
    ;;
    esac
}
