default:
  @just --list

tool := "pr-bisect"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos/docker"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool + ":" + docker_image_version

build_docker:
    docker build -t {{docker_image}} .