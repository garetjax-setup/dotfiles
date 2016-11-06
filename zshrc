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

if [ -d ~/.zsh ] ; then
    for file in ~/.zsh/*.zsh; do
        source "$file"
    done
fi
#}}}

#{{{ 

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
export EDITOR="vim"

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

#}}}

#{{{ Shell conveniences
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias mk=popd
alias ls='ls -h'
alias l='lancet'
alias lh='ls -lh'
alias rmall='rm -rf'
alias ll='ls -alFh'
alias pd='popd'
alias greppy="find . -name '*.py' | xargs grep"
alias search="find . -name"
alias copy="xclip -selection c"

# Copy with a progress bar.
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
#}}}

# Editor
alias vim='vim'
alias vi='vim'
alias mvim='gvim'

# Tmux
alias tmux='TERM=xterm-256color tmux'

#{{{ Custom project extensions

# Function to cd to the specified Project directory (or to the projects root
# if no arguments are specified).
function pp {
    cd $HOME/workspace/$1
    if [ -f .virtualenv ]; then
        workon $(cat .virtualenv)
    else
        if [ ! -z "$VIRTUAL_ENV" ]; then
            deactivate
        fi
        # Search for virtualenvs
        local -a venv_dirs
        venv_dirs=(.venv venv env)
        for dir in $venv_dirs ; do
            if [ -f $dir/bin/activate ] ; then
                source $dir/bin/activate
                break
            fi
        done
    fi
}
compdef '_files -/ -W $HOME/workspace' pp
#}}}

# Global aliases, work in every point of a command
#alias -g G="| grep"
#alias -g L="| less"

#{{{ Completion Stuff

#{{{ Taskwarrior autocompletion
zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]"
#}}}

bindkey -M viins '\C-i' complete-word

# Faster! (?)
zstyle ':completion::complete:*' use-cache 1

# case insensitive completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle :compinstall filename '/home/garetjax/.zshrc'

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
bindkey -M filterselect '^E' accept-search

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
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

bindkey '\eOA' up-line-or-history
bindkey '\eOB' down-line-or-history

bindkey '\e[C' forward-char
bindkey '\e[D' backward-char

bindkey '\eOC' forward-char
bindkey '\eOD' backward-char

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'u' undo

# Rebind the insert key.  I really can't stand what it currently does.
bindkey '\e[2~' overwrite-mode

# Rebind the delete key. Again, useless.
bindkey '\e[3~' delete-char

bindkey -M vicmd '!' edit-command-output

# it's like, space AND completion.  Gnarlbot.
bindkey ' ' magic-space

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

#{{{ Load boxen env
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
#}}}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
