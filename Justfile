default:
  @just --list

tool := "pr-bisect"
docker_container_registry := "docker.pkg.github.com"
docker_user_repo := "mihaigalos/docker"
docker_image_version := "latest"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool + ":" + docker_image_version

build:
    sudo docker build -t {{docker_image}} .

pull:
    #!/bin/bash
    set -x
    docker_container_registry_pull="ghcr.io"
    docker_image="$docker_container_registry_pull/{{docker_user_repo}}/{{tool}}:{{docker_image_version}}"
    sudo docker pull $docker_image

push: test
    docker push {{docker_image}}

test:
    #!/bin/bash
    echo $SHELL
    function err() {
        echo -e "\e[1;31m${@}\e[0m" >&2
        exit 1
    }

    pushd $(mktemp -d)
    pwd
    git clone https://github.com/mihaigalos/pr-bisect-test-repo.git && cd pr-bisect-test-repo
    [ -t 1 ] && DOCKER_TTY="-i" || DOCKER_TTY=""
    sudo docker run $DOCKER_TTY -t --rm -v $(pwd):/src -v /tmp:/tmp {{docker_image}} ab0337e87b915218542d6226f0fb809fe25111aa 33ccecac94998f271da271edc4806055d0025b5d ./run.sh | tee /tmp/pr-bisect.log
    grep "is the first bad commit" /tmp/pr-bisect.log || err "ERROR: bad commit cannot be found."
    popd >/dev/null

