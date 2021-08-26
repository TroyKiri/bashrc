_ps_color() {
  local el="$1"
  local color=37

  case $2 in
  red) color=31 ;;
  green) color=32 ;;
  blue) color=34 ;;
  yellow) color=33 ;;
  cyan) color=36 ;;
  pink) color=35 ;;
  black) color=30 ;;
  esac

  echo "\[\e[${color}m\]$el\[\e[m\]"
}

_ps_profile="$(_ps_color "\u" green)"
_ps_pwd="$(_ps_color "\w" yellow)"
_ps_time="$(_ps_color "\t" pink)"
_ps_symbol="$(_ps_color "\$" green)"
_ps_git_branch="$(_ps_color '$(__git_ps1 "%s")' cyan)"

export PS1="$_ps_profile $_ps_time $_ps_pwd $_ps_git_branch \n$_ps_symbol "