FROM ubuntu:21.10 as base
RUN apt update &&\
    DEBIAN_FRONTEND=noninteractive apt install --yes --fix-broken \
    bash \
    git \
    tig \
    vim
WORKDIR /src

COPY find-broken-commit-in-pr find-broken-pr pr-bisect /usr/bin/

ENTRYPOINT [ "pr-bisect" ]
