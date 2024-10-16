#trap 'echo "Error occurred at ${funcfiletrace[1]}: $?"' ERR

HOSTNAME="$(hostname)"  # Conda clobbers HOST, so we save the real hostname into another variable.

function precmd() {
  OLDHOST="${HOST}"
  HOST="${HOSTNAME}"
}

function preexec() {
  HOST="${OLDHOST}"
}

#function conda_prompt_info() {
#    if [ -n "$CONDA_DEFAULT_ENV" ]; then
#        echo "$ZSH_THEME_CONDA_ENV_PROMPT_PREFIX$CONDA_DEFAULT_ENV$ZSH_THEME_CONDA_ENV_PROMPT_SUFFIX"
#    fi
#}

function pyversion() {
    echo "`python3 -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))'`"
}

function py_prompt_info() {
    echo "$ZSH_THEME_PY_PROMPT_PREFIX$(pyversion)$ZSH_THEME_PY_PROMPT_SUFFIX"
}

function centerf() {
  if [[ -n "$2" ]]
  then
    padding="$(printf '%0.1s' "$2"{1..500})"
  else
    padding="$(printf '%0.1s' ' '{1..500})"
  fi

  termwidth="$(tput cols)"

  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

function acenterf() {
    local IFS=$'\n'
    for line ($=1) centerf "$line" $2
}

function motd_welcome() {
    centerf "welcome, $USER"
}

function motd_unames() {
    if [[ `uname -s` == 'Darwin' ]]; then
        centerf "`uname -srm`"
    else
        centerf "`uname -o`"
        centerf "`uname -r`"
        centerf "`uname -m`"
    fi
}

function motd_cpuinfo() {
    if [[ `uname -s` == 'Darwin' ]]; then
        centerf "`hostinfo | grep physically`"
        centerf "`hostinfo | grep logically`"
    else
        centerf "`cat /proc/cpuinfo | grep -m 1 "model name" | awk -F":" '{print $2}'`"
    fi
}

function motd_meminfo() {
    if [[ `uname -s` == 'Darwin' ]]; then 
        centerf "`hostinfo | grep memory`"
    else
        centerf "`free -m | grep Mem | awk '{print $3 "M of "$2"M RAM used ("$7"M cached)"}'`"
    fi
}

function motd_dfinfo() {
    if [[ `uname -s` == 'Darwin' ]]; then 
        acenterf "`df -lh | grep /dev/disk1s1 | awk '{print $3,"of",$2,"("$5") used on "$9}'`"
    else
        acenterf "`df -lh | grep "data\|home\|\s\/$" | awk '{print $3 " of "$2 " ("$5") on "$6}'`"
    fi
}

export COLS=`tput cols`

function div() {
    tput sgr 0; tput bold; tput setaf 4; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =; tput sgr 0
}

function smalldiv() {
    tput bold; tput setaf 4; centerf '********************'; tput sgr 0
}


function motd() {
    div
    echo
    echo
    tput setaf 5
    figlet -c -w `tput cols` -f Broadway $HOSTNAME
    tput sgr 0
    echo
    echo
    tput sitm
    tput setaf 6
    motd_welcome
    tput sgr 0
    echo
    centerf "`date`"
    echo
    motd_unames
    echo
    smalldiv
    echo
    motd_cpuinfo
    motd_meminfo
    echo
    smalldiv
    echo
    motd_dfinfo
    echo
    div
    tput sgr 0
    echo
}

export XCURSOR_PATH=$RUNTIME/usr/share/icons
