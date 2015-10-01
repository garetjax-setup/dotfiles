# Docker
alias docker-route='sudo route -n add 172.17.0.0/16 $(boot2docker ip)'
alias docker-stopall='docker ps -q | xargs docker stop'
alias docker-rmstopped='docker ps -f status=exited | tail -n +2 | awk '"'"'$NF !~ /data/ {print $1}'"'"' | xargs docker rm'
alias docker-rmuntaggedi='docker images -q -f dangling=true | xargs docker rmi'
alias docker-shell='docker run --entrypoint bash -it'

# Boot2docker
alias b2dup='boot2docker up && docker-route'

# Boot2docker support for docker-enter
function docker-enter() {
    boot2docker ssh '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
    boot2docker ssh -t sudo /var/lib/boot2docker/docker-enter "$@"
}

function docker-space-used() {
    boot2docker ssh df | grep /mnt/sda1/var/lib/docker/aufs | grep /dev/sda1 | awk '{print $3}'
}

function docker-clean() {
    USED_BEFORE=$(docker-space-used)
    docker-rmstopped && docker-rmuntaggedi
    USED_AFTER=$(docker-space-used)
    echo -n "Freed "
    echo $(($USED_BEFORE - $USED_AFTER)) | gnumfmt --to=iec-i --format="%fB"
}

# Docker compose
alias fig="docker-compose"
alias dsh="docker-compose run --service-ports shell"
alias dj="docker-compose run --service-ports django"
alias dmake="docker-compose run --service-ports make"
alias app="docker-compose run --service-ports app"
alias dfab="docker-compose run fab"

alias dc="docker-compose"
alias dm="docker-machine"
alias ds="docker-storage"
