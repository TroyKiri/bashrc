function @ {
    . ~/.bashrc
}

genv() {
    case $1 in
    "-w")
        eval wslpath -m $(genv $2)
        ;;
    "")
        cat $(genv -f)
        ;;
    "-e")
        $EDITOR $(genv -f)
        ;;
    "-s")
        name=${2^^}
        path=$3
        data=$(genv -f)

        case $3 in
        ".")
            path=$(pwd)
            ;;
        *) ;;
        esac

        string="export $name=\"$path\""

        echo $string >>$data
        bash
        ;;
    "-f")
        echo $(gf exports/folders)
        ;;
    "-ls")
        echo $(awk -n '/export /','/=/' $(genv -f) | cut -d " " -f2 | cut -d "=" -f1) | awk '{print tolower($0)}'
        ;;
    *)
        env_alias=$(echo $1 | cut -d "/" -f 1)
        additional_path=${1//"$env_alias/"/}
        env=${env_alias^^}

        if [[ -z "$(winenv $env)" ]]; then
            path_env="$(eval "echo \"\$$env\"")"
        else
            path_env="$(winenv $env)"
        fi

        if [ "$env_alias" != "$additional_path" ]; then
            path_env="$path_env/$additional_path"
        fi

        if [[ $path_env == *"himBHs"* || -z $path_env ]]; then
            # error "Alias $1 doesn't exist"
            echo "null"
        fi

        echo $path_env
        ;;
    esac
}

winenv() {
    winenv="$(cmd.exe /C "echo %$@%" 2>/dev/null | tr -d '\r')"

    if [[ $winenv == *"%"* ]]; then
        echo ""
    else
        wslpath $winenv
    fi
}

evalb() {
    eval "$@ & >/dev/null" |& :
}

wcmd() {
    cmd=$1

    case $2 in
    "-a")
        cmd="$cmd $(genv $3)"
        ;;
    *)
        cmd="$cmd ${@:2}"
        ;;
    esac

    eval $cmd
}

wcmdb() {
    cmd=$1

    case $2 in
    "-a")
        cmd="$cmd $(genv $3)"
        ;;
    *)
        cmd="$cmd ${@:2}"
        ;;
    esac

    evalb "$cmd"
}

cd() {
    wcmd "builtin cd" $@
}