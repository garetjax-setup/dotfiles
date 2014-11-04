# Sourced by all non-interactive zsh shells

#{{{ Avoid locale errors with python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#}}}

#{{{ Path extensions
export PATH="/opt/boxen/homebrew/bin:${HOME}/.local/bin:${PATH}"
#}}}

#{{{ Boot2docker config
export DOCKER_CERT_PATH=/opt/boxen/data/docker/certs/boxen-boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376
#}}}
