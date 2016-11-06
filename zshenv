# Sourced by all interactive and non-interactive ZSH shells
#{{{ Support local ssh-agent socket
#export SSH_AUTH_SOCK=~/.ssh-agent.sock
#}}}

#{{{ Avoid locale errors with python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#}}}

#{{{ Path extensions
export PATH="${HOME}/.local/bin:${PATH}"
#}}}

#{{{ docher-machine config
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.59.103:2376"
export DOCKER_CERT_PATH="/Users/garetjax/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"
#}}}
