# Docker
alias docker-route='sudo route -n add 172.17.0.0/16 $(boot2docker ip)'
alias docker-stopall='docker ps -q | xargs docker stop'
alias docker-rmstopped='docker ps -f status=exited | tail -n +2 | awk '"'"'$NF !~ /data/ {print $1}'"'"' | xargs docker rm'
alias docker-rmuntaggedi='docker images -q -f dangling=true | xargs docker rmi'
alias docker-clean='docker-rmstopped && docker-rmuntaggedi'
alias docker-shell='docker run --entrypoint bash -it'

# Boot2docker
alias b2dup='boot2docker up && docker-route'

# Boot2docker support for docker-enter
docker-enter() {
    boot2docker ssh '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
    boot2docker ssh -t sudo /var/lib/boot2docker/docker-enter "$@"
}

# Docker compose
alias fig="docker-compose"
alias dsh="docker-compose run --service-ports shell"
alias dj="docker-compose run --service-ports django"
alias dmake="docker-compose run --service-ports make"
alias app="docker-compose run --service-ports app"
alias dfab="docker-compose run fab"
