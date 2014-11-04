fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
fpath=($HOME/.zsh/func $fpath)

typeset -U fpath

#{{{ ZSH Modules
autoload -Uz compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup
fpath=(/usr/local/share/zsh-completions $fpath)

autoload colors && colors

source ~/.zsh/zaw/zaw.zsh
#}}}

#{{{ Options

REPORTTIME=5

setopt autocd extendedglob

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Spell check commands!  (Sometimes annoying)
setopt CORRECT

# This makes cd=pushd
setopt AUTO_PUSHD

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# No more annoying pushd messages...
# setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# this will ignore multiple directories for the stack.  Useful?  I dunno.
setopt PUSHD_IGNORE_DUPS

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
#setopt RM_STAR_WAIT

# use magic (this is default, but it can't hurt!)
setopt ZLE

setopt NO_HUP

setopt VI

# only fools wouldn't do this ;-)
# I'm a fool!
export EDITOR="vim -v"

#setopt IGNORE_EOF

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Keep echo "station" > station from clobbering station
setopt NO_CLOBBER

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

#}}}

#{{{ External Files

# Include stuff that should only be on this
if [[ -r ~/.localinclude ]]; then
    source ~/.localinclude
fi

# Include local directories
if [[ -r ~/.localdirs ]]; then
    source ~/.localdirs
fi

autoload run-help
HELPDIR=~/zsh_help
#}}}


#{{{ Relative cd

function rcd {
	OLD_IFS=$IFS ; IFS='/'
	cd "$*"
	IFS=$OLD_IFS
	if [ -f .virtualenv ]; then
		workon $(cat .virtualenv)
	elif [ ! -z "$VIRTUAL_ENV" ]; then
		deactivate
	fi
}

function rcdalias {
	function $1 {rcd $HOME/Documents/School/MSE/Courses $1}
	compdef "_files -/ -W $2" $1
}

#}}}

#{{{ Shell Conveniences
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias mk=popd
alias ls='ls -h'
alias l='ls -lFh'
alias lh='ls -lh'
alias rmall='rm -rf'
alias ll='ls -alFh'
alias g='git'
alias pd='popd'
alias greppy="find . -name '*.py' | xargs grep"
alias search="find . -name"
alias copy="xclip -selection c"
#}}}

alias vim='vim'
alias vi='vim'
alias mvim='gvim'
alias git='hub'
alias greset='git reset --hard HEAD && git clean -f'
alias tmux='TERM=xterm-256color tmux'

compdef hub='git'

#{{{ Custom project extensions

# Function to cd to the specified Project directory (or to the projects root
# if no arguments are specified).
function pp {
    cd $HOME/workspace/$1
    if [ -f .virtualenv ]; then
        workon $(cat .virtualenv)
    elif [ ! -z "$VIRTUAL_ENV" ]; then
        deactivate
    fi
}
compdef '_files -/ -W $HOME/projects' pp
#}}}

#{{{ Misc.

# copy with a progress bar.
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

#}}}

#{{{ Globals...

# Global aliases, work in every point of a command
#alias -g G="| grep"
#alias -g L="| less"

#}}}

#{{{ Suffixes...

#}}}

#}}}

#{{{ Completion Stuff

#{{{ Taskwarrior autocompletion

zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]"

#}}}

bindkey -M viins '\C-i' complete-word

# Faster! (?)
#zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle :compinstall filename '/home/admin/.zshrc'

# Display category names
zstyle ':completion:*' verbose yes

# Set category names format
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _ignored

# generate descriptions with magic.
#zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it! (tab-based selection of entry)
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
#zstyle ':completion:*' file-sort modification reverse

# Use colors for completion suggestions
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# complete with a menu for xwindow ids
#zstyle ':completion:*:windows' menu on=0
#zstyle ':completion:*:expand:*' tag-order all-expansions

# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $(( ($#PREFIX+$#SUFFIX)/4 ))  )'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

#zstyle ':completion::approximate*:*' prefix-needed false

#}}}

#{{{ Key bindings

# Use Ctrl-A and Ctrl-E to jump from start to end
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line


#bindkey '^H' history-search-backward
bindkey '^H' zaw-history

# Incremental search is elite!
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward

# Search based on what you typed in already
bindkey -M vicmd "//" history-beginning-search-backward
bindkey -M vicmd "??" history-beginning-search-forward

bindkey "\eOP" run-help

# oh wow!  This is killer...  try it!
bindkey -M vicmd "q" push-line

# Ensure that arrow keys work as they should
bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history

bindkey '\eOA' up-line-or-history
bindkey '\eOB' down-line-or-history

bindkey '\e[C' forward-char
bindkey '\e[D' backward-char

bindkey '\eOC' forward-char
bindkey '\eOD' backward-char

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'u' undo

# Rebind the insert key.  I really can't stand what it currently does.
#bindkey '\e[2~' overwrite-mode

# Rebind the delete key. Again, useless.
#bindkey '\e[3~' delete-char

bindkey -M vicmd '!' edit-command-output

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

#}}}

#{{{ History Stuff

# Where it gets saved
HISTFILE=~/.history

# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=10000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Write after each command
setopt INC_APPEND_HISTORY

# Killer: share history between multiple shells
#setopt SHARE_HISTORY

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

#}}}

#{{{ Prompt!

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

#}}}

#{{{ Testing... Testing...
#exec 2>>(while read line; do
#print '\e[91m'${(q)line}'\e[0m' > /dev/tty; done &)

watch=(notme)
LOGCHECK=0

#}}}

# Autoload screen if we aren't in it.  (Thanks Fjord!)
#if [[ $STY = '' ]] then screen -xR; fi
#

# added by travis gem
[ -f /home/garetjax/.travis/travis.sh ] && source /home/garetjax/.travis/travis.sh

#{{{ Load boxen env
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
#}}}
