default:
  @just --list

tool := "pr-bisect"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos/docker"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool + ":" + docker_image_version

build_docker:
    docker pull {{docker_image}}
    docker build -t {{docker_image}} .

test: build_docker
    #! /bin/bash
    function err() {
        echo -e "\e[1;31m${@}\e[0m" >&2
        exit 1
    }

    pushd $(mktemp -d)
    pwd
    git clone https://github.com/mihaigalos/pr-bisect-test-repo.git && cd pr-bisect-test-repo
    docker run -t --rm -v $(pwd):/src -v /tmp:/tmp {{docker_image}} ab0337e87b915218542d6226f0fb809fe25111aa 33ccecac94998f271da271edc4806055d0025b5d ./run.sh | tee /tmp/pr-bisect.log
    grep "is the first bad commit" /tmp/pr-bisect.log || err "ERROR: bad commit cannot be found."
    popd

push: test
    docker push {{docker_image}}
