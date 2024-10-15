# ZSH Theme - Preview: https://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host="%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}"
    local user_symbol='#'
else
    local user_host="%{$terminfo[bold]$fg[green]%}%n%{$fg[yellow]%}@%{$fg[blue]%}%m %{$reset_color%}"
    local user_symbol='$'
fi

local current_dir="%{$terminfo[bold]$FG[248]%}%~ %{$reset_color%}"

function spack_prompt_info() {
    [[ -n ${SPACK_ENV} ]] || return
    echo "${ZSH_THEME_SPACK_PREFIX=⸨}`basename $SPACK_ENV`${ZSH_THEME_SPACK_SUFFIX=⸩}"
}

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[130]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[red]%}«"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="» %{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

ZSH_THEME_PY_PROMPT_PREFIX="%F{070} "
ZSH_THEME_PY_PROMPT_SUFFIX="%f "

ZSH_THEME_CONDA_PREFIX="%F{magenta}󰜐 "
ZSH_THEME_CONDA_SUFFIX=" %f"

ZSH_THEME_SPACK_PREFIX="%F{red}󰓁 "
ZSH_THEME_SPACK_SUFFIX=" %f"


PROMPT='╭─ $(spack_prompt_info)$(conda_prompt_info)$(virtualenv_prompt_info)$(py_prompt_info)${user_host}${current_dir}$(ruby_prompt_info)$(git_prompt_info)
╰─%B${user_symbol}%b '
RPROMPT='%B${return_code}%b'
