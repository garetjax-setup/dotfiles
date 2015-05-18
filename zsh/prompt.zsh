# Prompt
host_color=cyan
history_color=yellow
user_color=green
root_color=red
directory_color=magenta
error_color=red
jobs_color=green

host_prompt="%{$fg_bold[$host_color]%}%m%{$reset_color%}"

jobs_prompt1="%{$fg_bold[$jobs_color]%}(%{$reset_color%}"
jobs_prompt2="%{$fg[$jobs_color]%}%j%{$reset_color%}"
jobs_prompt3="%{$fg_bold[$jobs_color]%})%{$reset_color%}"
jobs_total="%(1j.${jobs_prompt1}${jobs_prompt2}${jobs_prompt3} .)"

history_prompt1="%{$fg_bold[$history_color]%}[%{$reset_color%}"
history_prompt2="%{$fg[$history_color]%}%h%{$reset_color%}"
history_prompt3="%{$fg_bold[$history_color]%}]%{$reset_color%}"
history_total="${history_prompt1}${history_prompt2}${history_prompt3}"

error_prompt1="%{$fg_bold[$error_color]%}<%{$reset_color%}"
error_prompt2="%{$fg[$error_color]%}%?%{$reset_color%}"
error_prompt3="%{$fg_bold[$error_color]%}>%{$reset_color%}"
error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       "%F{2}(%s%F{3}:%F{2}%b%u)%f "
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'

_vcs_info_wrapper() {
if [[ ! -a ".novcsprompt" ]]; then
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
fi
}

_virtualenv_prompt() {
	if [ ! -z "$VIRTUAL_ENV" ] ; then
		echo "%F{3}("$(basename "$VIRTUAL_ENV")")%f "
	fi
}

_git_status() {
	git status >/dev/null 2>&1 && [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]] && echo '*'
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

RPROMPT=$'%(?..[ %F{7}%?%f ])'

PROMPT=$'$(_virtualenv_prompt)%1~ $(_vcs_info_wrapper)%{$fg[yellow]%}▸%{$reset_color%} '

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

edit-command-output() {
 BUFFER=$(eval $BUFFER)
 CURSOR=0
}
zle -N edit-command-output
