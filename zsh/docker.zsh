# Docker
alias docker-route='sudo route -n add 172.17.0.0/16 $(boot2docker ip)'
alias docker-stopall='docker ps -q | xargs docker stop'
alias docker-rmstopped='docker ps -f status=exited -f status=created | tail -n +2 | awk '"'"'$NF !~ /data/ {print $1}'"'"' | xargs docker rm'
alias docker-rmuntaggedi='docker images -q -f dangling=true | xargs docker rmi'
alias docker-shell='docker run --entrypoint bash -it'

function docker-space-used() {
    docker-machine ssh default df | grep /mnt/sda1/var/lib/docker/aufs | grep /dev/sda1 | awk '{print $3}'
}

function docker-clean() {
    USED_BEFORE=$(docker-space-used)
    docker-rmstopped && docker-rmuntaggedi
    USED_AFTER=$(docker-space-used)
    echo -n "Freed "
    echo $(($USED_BEFORE - $USED_AFTER)) | gnumfmt --to=iec-i --format="%fB"
}

alias docker-pip-compile="docker run -v \$(pwd):/app -it --workdir /app aldryn/base-project:3.0.1 pip-compile -v requirements.in"

# Docker compose
alias fig="docker-compose"
alias dsh="docker-compose run --service-ports shell"
alias dj="docker-compose run --service-ports django"
alias dmake="docker-compose run --service-ports make"
alias app="docker-compose run --service-ports app"
alias dfab="docker-compose run fab"

alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias dcrs="docker-compose run --rm --service-ports"
alias dm="docker-machine"
alias ds="docker-storage"

alias pip-compile-aldryn='docker run --add-host=wheels.aldryn.net:$(dig +short wheels-lime.aldryn.net) -v $(pwd):/app -it --workdir /app aldryn/base:3.15 pip-compile -v -i https://wheels.aldryn.net/v1/aldryn-extras+pypi/aldryn-baseproject/+simple/'
alias pip-compile='docker run --add-host=wheels.aldryn.net:$(dig +short wheels-lime.aldryn.net) -v $(pwd):/app -it --workdir /app aldryn/base:3.15 pip-compile -v -i https://wheels.aldryn.net/v1/pypi/aldryn-baseproject/+simple/'
