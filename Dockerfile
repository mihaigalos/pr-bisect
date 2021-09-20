FROM debian:buster-slim as base
RUN apt update &&\
    DEBIAN_FRONTEND=noninteractive apt install --yes --fix-broken \
    git

WORKDIR /src
COPY find-broken-commit-in-pr find-broken-pr pr-bisect /usr/bin/

ENTRYPOINT [ "pr-bisect" ]
