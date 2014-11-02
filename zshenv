# Sources by all non-interactive shells

#{{{ Avoid locale errors with python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#}}}

#{{{ Path extensions
export PATH="${HOME}/.gem/ruby/2.0.0/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
#}}}

#{{{ Load boxen env
# Required to add the custom homebrew bin folder to the path when invoked
# through non-interactive sub shells (e.g. #!/bin/sh).
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
#}}}
