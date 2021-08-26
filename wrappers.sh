vim() {
  wcmd "/usr/bin/vim" $@
}
vsc() {
  wcmdb "code" $@
}
f() {
    case $1 in
    "")
        path=""
        ;;
    ".")
        path="."
        ;;
    "-a")
        path=$(genv $2)
        ;;
    *)
        path=$env
        ;;
    esac

    $(
        cd $path
        explorer.exe .
    )
}