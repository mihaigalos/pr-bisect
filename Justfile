default:
  @just --list

tool := "pr-bisect"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos/docker"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool + ":" + docker_image_version

build_docker:
    docker build -t {{docker_image}} .

test: build_docker
    #! /bin/bash
    pushd $(mktemp -d)
    pwd
    git clone https://github.com/mihaigalos/pr-bisect-test-repo.git && cd pr-bisect-test-repo
    docker run -it --rm -v $(pwd):/src -v /tmp:/tmp ghcr.io/mihaigalos/docker/pr-bisect:0.0.1 ab0337e87b915218542d6226f0fb809fe25111aa 33ccecac94998f271da271edc4806055d0025b5d ./run.sh | tee /tmp/pr-bisect.log
    grep "is the first bad commit" /tmp/pr-bisect.log || echo ERROR: bad commit cannot be found.
    popd

push: test
    docker push {{docker_image}}
