FROM ubuntu:20.04 as base
RUN apt update &&\
    DEBIAN_FRONTEND=noninteractive apt install --yes --fix-broken \
    bash \
    git \
    tig \
    vim
WORKDIR /src

COPY find-broken-commit-in-pr find-broken-pr pr-bisect /usr/bin/

#CMD ["/pr-bisect"]