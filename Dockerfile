FROM alpine/git as base
RUN apk update &&\
    apk add \
        bash &&\
    sed -i -e "s|/bin/ash|/bin/bash|g" /etc/passwd

WORKDIR /src
ENV SHELL=/usr/bin/bash
COPY find-broken-commit-in-pr find-broken-pr pr-bisect /usr/bin/

ENTRYPOINT [ "pr-bisect" ]
